
package ai.maum.biz.fastaicc.main.log;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardWatchEventKinds;
import java.nio.file.WatchEvent;
import java.nio.file.WatchKey;
import java.nio.file.WatchService;
import java.nio.file.WatchEvent.Kind;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicLong;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
public class realTimeLogApi {
    private static final Logger log = LoggerFactory.getLogger(realTimeLogApi.class);
    @Autowired
    private Environment env;
    public int Threadcnt = 0;
    @Value("${logging.maxThread}")
    public int Max_thread;
    ExecutorService executorService = Executors.newFixedThreadPool(10);

    public realTimeLogApi() {
    }

    @GetMapping(
            path = {"/realtime/{id}"},
            produces = {"text/event-stream"}
    )
    public SseEmitter realtimeLog(@PathVariable String id, @RequestParam String tailNsize, @RequestParam String logName) {
        SseEmitter logEmitter = new SseEmitter(3600000L);

        try {
            if (this.Threadcnt >= 10) {
                logEmitter.send("over Thread");
                logEmitter.send("----------------------------------------------program Exit----------------------------------------------");
                return logEmitter;
            }

            String logDir = "logging.file." + logName;
            String logfileName = "logging.name." + logName;
            Path path = (new FileSystemResource(this.env.getProperty(logDir))).getFile().toPath();
            Path pollingfile = path.resolve(this.env.getProperty(logfileName));
            WatchService watchService = FileSystems.getDefault().newWatchService();
            path.register(watchService, StandardWatchEventKinds.ENTRY_MODIFY);
            Long tailn = Long.parseLong(tailNsize);
            Long fileline = Files.lines(pollingfile).count();
            Long skippage = fileline - tailn;
            AtomicLong Atomicskippage = new AtomicLong(skippage);
            if (skippage < 0L) {
                Atomicskippage.set(0L);
            }

            try {
                Files.lines(pollingfile).skip(Atomicskippage.get()).forEach((line) -> {
                    try {
                        logEmitter.send(line);
                    } catch (IOException var4) {
                        throw new RuntimeException();
                    } catch (Exception var5) {
                        throw new RuntimeException();
                    }

                    Atomicskippage.incrementAndGet();
                });
            } catch (Exception var15) {
                return logEmitter;
            }

            this.executorService.execute(() -> {
                ++this.Threadcnt;
                log.info("Realtime Log Thread start");
                log.info("Now Sse Thread cnt : " + this.Threadcnt);

                try {
                    Long nowfilesize = Files.size(pollingfile);
                    Long lastfilesisize = -1L;

                    label72:
                    while(true) {
                        while(true) {
                            try {
                                WatchKey watchKey = watchService.poll();
                                if (watchKey != null) {
                                    List<WatchEvent<?>> events = watchKey.pollEvents();
                                    Iterator var10 = events.iterator();

                                    while(var10.hasNext()) {
                                        WatchEvent<?> event = (WatchEvent)var10.next();
                                        Kind<?> kind = event.kind();
                                        Path changed = path.resolve((Path)event.context());
                                        if (kind.equals(StandardWatchEventKinds.ENTRY_MODIFY) && changed.equals(pollingfile)) {
                                            try {
                                                Files.lines(changed).skip(Atomicskippage.get()).forEach((line) -> {
                                                    try {
                                                        logEmitter.send(line);
                                                    } catch (IOException var5) {
                                                        throw new realTimeLogApi.ExitException();
                                                    } catch (Exception var6) {
                                                        throw new realTimeLogApi.ExitException();
                                                    }

                                                    Atomicskippage.incrementAndGet();
                                                });
                                                lastfilesisize = Files.size(pollingfile);
                                            } catch (realTimeLogApi.ExitException var15) {
                                                throw new realTimeLogApi.ExitException();
                                            } catch (Exception var16) {
                                                throw new realTimeLogApi.ExitException();
                                            }
                                        }
                                    }

                                    if (!watchKey.reset()) {
                                        try {
                                            watchService.close();
                                        } catch (IOException var17) {
                                            break label72;
                                        }
                                    }
                                } else {
                                    nowfilesize = Files.size(pollingfile);
                                    if (nowfilesize < lastfilesisize) {
                                        Atomicskippage.set(0L);
                                    }

                                    Thread.sleep(500L);
                                    logEmitter.send(SseEmitter.event().id("dummy"));
                                }
                            } catch (InterruptedException var18) {
                                break label72;
                            } catch (IOException var19) {
                                break label72;
                            } catch (realTimeLogApi.ExitException var20) {
                                break label72;
                            } catch (Exception var21) {
                                break label72;
                            }
                        }
                    }
                } catch (IOException var22) {
                }

                --this.Threadcnt;
                log.info("Thread ent");
                log.info("SseEmitter Thread cnt :" + this.Threadcnt);
            });
        } catch (IOException var16) {
        }

        return logEmitter;
    }

    public class ExitException extends RuntimeException {
        public ExitException() {
        }
    }
}
