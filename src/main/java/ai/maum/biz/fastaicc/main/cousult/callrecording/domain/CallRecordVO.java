package ai.maum.biz.fastaicc.main.cousult.callrecording.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Setter
@Data
public class CallRecordVO {

    private int callId;
    private String callType;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String startDateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String endDateTime;

    private float duration;
    private String sipUser; // Phone No
    private String campaignName;
    private String company;

    //VOC analysis 페이징 관련 변수
    private int page;
    private int amount;
    private int totalCnt;
    

    private String callTypeCode;
    private String startTime;
    private String endTime;
    private String companyName;
}
