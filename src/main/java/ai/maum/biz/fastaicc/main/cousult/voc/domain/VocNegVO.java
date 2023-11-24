package ai.maum.biz.fastaicc.main.cousult.voc.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


@Getter
@Setter
@Data
public class VocNegVO {

    int page;
    int amount;

    private int seq;
    private int contractNo;

    private String keyword;
    private String speakerCode;
    private String sentence;

    private Date consultTime;

    private String isInBound;
    private String telNo;
    private String category;
    private String callId;

    private int cnt;            //키워드 별 건수
    private int custId;         //고객ID

    private int totalCall;      //총 콜수
    private int negCall;        //불만 콜수

    private int totalCnt;
}
