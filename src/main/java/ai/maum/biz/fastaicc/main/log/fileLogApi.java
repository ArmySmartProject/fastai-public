package ai.maum.biz.fastaicc.main.log;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class fileLogApi {
    @Autowired
    private Environment env;

    public fileLogApi() {
    }

    @GetMapping(
            path = {"/logfile/filelist/{id}"}
    )
    public JSONObject fileList(HttpServletResponse response, @PathVariable String id) throws Exception {
        JSONObject jsonObject = new JSONObject();
        String logDir = "logging.file." + id;
        String path = this.env.getProperty(logDir);
        File file = new File(path);
        File[] files = file.listFiles();
        String pattern = "yyyy-MM-dd";
        String[] filenameList = new String[files.length];
        String[] fileDateList = new String[files.length];

        for(int i = 0; i < files.length; ++i) {
            String[] split = files[i].toString().split("/");
            filenameList[i] = split[split.length - 1];
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            fileDateList[i] = simpleDateFormat.format(files[i].lastModified());
        }

        jsonObject.put("fileList", filenameList);
        jsonObject.put("fileDateList", fileDateList);
        return jsonObject;
    }

    @GetMapping({"/logfile/vi/{id}/{page}"})
    public JSONObject viewlog(HttpServletResponse response, @PathVariable String id, @PathVariable String page, @RequestParam String filename) {
        Long skipid;
        try {
            skipid = Long.parseLong(page);
        } catch (NumberFormatException var14) {
            skipid = 0L;
        }

        JSONObject jsonObject = new JSONObject();
        String logDir = "logging.file." + id;
        String path = this.env.getProperty(logDir) + "/" + filename;
        String[] ret = new String[300];

        try {
            AtomicLong i = new AtomicLong(1L);
            AtomicInteger arr = new AtomicInteger(0);
            Files.lines(Paths.get(path)).skip(skipid * 300L).forEach((line) -> {
                ret[arr.get()] = line;
                i.incrementAndGet();
                arr.incrementAndGet();
                if (i.get() > 300L) {
                    throw new RuntimeException();
                }
            });
        } catch (IOException var12) {
        } catch (RuntimeException var13) {
        }

        jsonObject.put("logData", ret);
        return jsonObject;
    }

    @GetMapping({"/logfile/countline/{id}"})
    public JSONObject countlinelog(HttpServletResponse response, @PathVariable String id, @RequestParam String filename) {
        JSONObject jsonObject = new JSONObject();
        String logDir = "logging.file." + id;
        String path = this.env.getProperty(logDir) + "/" + filename;
        String[] var7 = new String[300];

        try {
            Long count = Files.lines(Paths.get(path)).count();
            jsonObject.put("data", "success");
            jsonObject.put("count", count);
        } catch (IOException var9) {
            jsonObject.put("data", "fail");
        } catch (RuntimeException var10) {
            jsonObject.put("data", "fail");
        }

        return jsonObject;
    }

    @GetMapping({"/logfile/find/{id}"})
    public JSONObject findlog(HttpServletResponse response, @RequestParam String filename, @PathVariable String id, @RequestParam String page, @RequestParam String word) {
        String logDir = "logging.file." + id;
        String path = this.env.getProperty(logDir) + "/" + filename;

        Long skipPage;
        try {
            skipPage = Long.parseLong(page);
        } catch (NumberFormatException var17) {
            skipPage = 0L;
        }

        JSONObject jsonObject = new JSONObject();
        new ArrayList();
        String[] ret = new String[300];

        AtomicLong skipRowAtomic = new AtomicLong(skipPage * 300L);

        try {
            new AtomicLong(1L);
            AtomicBoolean isFind = new AtomicBoolean(false);
            Files.lines(Paths.get(path)).skip(skipRowAtomic.get()).forEach((line) -> {
                ret[(int)skipRowAtomic.get() % 300] = line;
                if (!isFind.get() && line.contains(word)) {
                    jsonObject.put("page", skipRowAtomic.get() / 300L);
                    jsonObject.put("word", word);
                    jsonObject.put("data", "success");
                    isFind.set(true);
                }

                if (isFind.get() && (int)skipRowAtomic.get() % 300 == 299) {
                    jsonObject.put("line", ret);
                    throw new RuntimeException();
                } else {
                    skipRowAtomic.incrementAndGet();
                }
            });
        } catch (IOException var15) {
        } catch (RuntimeException var16) {
        }

        if(skipRowAtomic.get() % 300 != 299){
            String[] ret2 = new String[300];

            for(int i=0;i<(int)skipRowAtomic.get()%300;i++){
                ret2[i] = ret[i];
            }

            for(int i=(int)skipRowAtomic.get()%300;i<300;i++){
                ret2[i] = "";
            }

            jsonObject.put("page", skipRowAtomic.get() / 300L);
            jsonObject.put("word", word);
            jsonObject.put("data", "success");
            jsonObject.put("line",ret2);


        }




        if (jsonObject.size() == 0) {
            jsonObject.put("data", "null");
        }

        return jsonObject;
    }

    @GetMapping({"/logfile/findall/{id}"})
    public JSONObject findalllog(HttpServletResponse response, @RequestParam String filename, @PathVariable String id, @RequestParam String page, @RequestParam String word) {
        String logDir = "logging.file." + id;
        String path = this.env.getProperty(logDir) + "/" + filename;

        Long skipPage;
        try {
            skipPage = Long.parseLong(page);
        } catch (NumberFormatException var17) {
            skipPage = 0L;
        }

        JSONObject jsonObject = new JSONObject();
        new ArrayList();
        ArrayList findIdx = new ArrayList();

        try {
            new AtomicLong(1L);
            AtomicLong skipRowAtomic = new AtomicLong(skipPage * 300L);
            AtomicInteger isFind = new AtomicInteger(-1);
            Files.lines(Paths.get(path)).skip(0L).forEach((line) -> {
                if ((long)isFind.get() != skipRowAtomic.get() / 300L && line.contains(word)) {
                    findIdx.add((int)skipRowAtomic.get() / 300);
                    isFind.set((int)skipRowAtomic.get() / 300);
                }

                skipRowAtomic.incrementAndGet();
            });
            jsonObject.put("word", word);
            if (findIdx.isEmpty()) {
                jsonObject.put("data", "fail");
            } else {
                jsonObject.put("data", "success");
            }

            jsonObject.put("page", findIdx);
        } catch (IOException var15) {
        } catch (RuntimeException var16) {
        }

        if (jsonObject.size() == 0) {
            jsonObject.put("data", "null");
        }

        return jsonObject;
    }
}
