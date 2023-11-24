package ai.maum.biz.fastaicc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan // @WebListener 스캔을 가능하도록
@SpringBootApplication
public class FastaiccApplication {

    public static void main(String[] args) {
        SpringApplication.run(FastaiccApplication.class, args);
    }

}
