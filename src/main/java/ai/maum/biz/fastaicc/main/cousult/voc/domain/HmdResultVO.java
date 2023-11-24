package ai.maum.biz.fastaicc.main.cousult.voc.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Data
public class HmdResultVO {
    private String sttResultDetailId;
    private String category1;
    private String category2;
    private String category3;
    private String count;

    private String sentence;
    private String speaker;
    private String speakerCode;
    private String createdDtm;
    private String telNo;
    private String callId;
}
