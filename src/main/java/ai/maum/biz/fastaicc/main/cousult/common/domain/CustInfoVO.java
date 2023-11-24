package ai.maum.biz.fastaicc.main.cousult.common.domain;

import java.util.List;
import lombok.Data;

@Data
public class CustInfoVO {

    private int custId;
    private int campaignId;
    private int obCallQueueId;
    private String custNm;
    private String custTelNo;
    private String custData;
    private List<String> custDataList;
    private String userId;

}
