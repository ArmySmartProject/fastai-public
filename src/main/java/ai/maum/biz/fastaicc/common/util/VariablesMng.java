package ai.maum.biz.fastaicc.common.util;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import org.springframework.stereotype.Component;

import java.util.HashMap;

@Getter
@Setter
@Component
@Data
public class VariablesMng {
    private String callStatusCode = "FCD_02";            //콜상태코드. FCD_02
    private String monitoringResultCode = "FCD_09";        //모니터링결과. FCD_09
    private String finalResultCode = "FCD_10";            //최종결과. FCD_10
    private String custOpInfoCode = "CUST_OP";            //상담사 정보. CUST_OP
    private String mntType = "MNT_TYPE";                //모니터링 종류. MNT_TYPE
    private String prod_name = "PROD_NAME";                //계약 종류. PROD_NAME
    private String callback_status = "FCD_11";            //콜백대상여부. FCD_11

    private int callCount = 30;                        //최종결과 판별용 콜 횟수
    private int basePeriod = 7;                            //최종결과 판별용 기간

}

