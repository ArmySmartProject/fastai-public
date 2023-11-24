package ai.maum.biz.fastaicc.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Component
public class CommonUtils {
    private static CommonUtils instance;
    String tag_option_start;
    String tag_option_close;
    StringBuilder sb;

    @Autowired
    private AuthService authService;
    private static AuthService authServiceStatic;

    private static UtilProperties properties;

    @Autowired
    public CommonUtils(UtilProperties properties)
    {
        CommonUtils.properties = properties;
    }

    @PostConstruct
    private void initialize() {
        this.authServiceStatic = authService;
    }

    public CommonUtils(){
        tag_option_start = "<option value='%s' %s>";
        tag_option_close = "</option>";

        sb = new StringBuilder();
    }

    public static CommonUtils getInstance(){
        if( instance == null ){
            instance = new CommonUtils();

            return instance;
        }

        return instance;
    }

    //String Empty and "0" check
    public static boolean strEmptyZero(String str){
        if( !StringUtils.isBlank(str) && !str.equals("0") ){
            return true;
        }else{
            return false;
        }
    }

    //String Empty check
    public static boolean strEmpty(String str){
        return !StringUtils.isBlank(str);
    }

    //String Empty check
    public static boolean strEmpty(String str, String str2){
        if( !StringUtils.isBlank(str) && !StringUtils.isBlank(str2) ){
            return true;
        }else {
            return false;
        }
    }
/*


    //사용자 권한 select box의 option tag 생성
    public String doSelectBoxTagUserRight(List<CommonCodeDTO> commonCodeList, String selected){
        sb.delete(0, sb.length());

        for( CommonCodeDTO one : commonCodeList ){
            if( !one.getCode_two().equals(selected) ){
                sb.append(String.format(tag_option_start, one.getCode_two(), ""));
            }else{
                sb.append(String.format(tag_option_start, one.getCode_two(), "selected"));
            }
            sb.append(one.getCode_value());
            sb.append(tag_option_close);
        }

        return sb.toString();
    }


    //사용자 권한 select box의 option tag 생성
    public String checkUserRight(List<UserRoleDTO> roleList, String selected){
        sb.delete(0, sb.length());

       */
/* sb.append(String.format(tag_option_start, 0, ""));
        sb.append("--선택--");
        sb.append(tag_option_close);*//*

        for( UserRoleDTO one : roleList ){
            if( !one.getRole_type().equals(selected) ){
                sb.append(String.format(tag_option_start, one.getRole_ser(), ""));
            }else{
                sb.append(String.format(tag_option_start, one.getRole_ser(), "selected"));
            }
            sb.append(one.getRole_desc());
            sb.append(tag_option_close);
        }

        return sb.toString();
    }

    //사이트 리스트 select box의 option tag 생성
    public String doSelectBoxTagSiteList(List<MinutesSiteDTO> siteList, String selected){
        sb.delete(0, sb.length());

        for( MinutesSiteDTO one : siteList ){
            if( !one.getMinutes_site_ser().equals(selected) ) {
                sb.append(String.format(tag_option_start, one.getMinutes_site_ser(), ""));
            }else{
                sb.append(String.format(tag_option_start, one.getMinutes_site_ser(), "selected"));
            }
            sb.append(one.getSite_name());
            sb.append(tag_option_close);
        }

        return sb.toString();
    }


    //사이트 리스트 select box의 option tag 생성
    public String doSelectBoxTaModelList(List<ModelDTO> modelList, int selected){
        sb.delete(0, sb.length());

        for( ModelDTO one : modelList ){
            if( one.getStt_model_ser() !=  selected) {
                sb.append(String.format(tag_option_start, one.getStt_model_ser(), ""));
            }else{
                sb.append(String.format(tag_option_start, one.getStt_model_ser(), "selected"));
            }
            sb.append(one.getModel_desc());
            sb.append(tag_option_close);
        }

        return sb.toString();
    }
*/



    //'yyyyMMddhhmmss' 형태로 현재 날짜, 시간, 초를 String으로 반환
    public String getTodate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        Date date = new Date();
        String str = sdf.format(date);
        return str;
    }

    //'yyyyMMdd' 형태로 현재 날짜로 반환
    public String getDate(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = new Date();
        String str = sdf.format(date);
        return str;
    }

    public static String generateRandomUuid()
    {
        return UUID.randomUUID().toString();
    }

    public static <T> T parseJsonStringToObject(String jsonString, T t) throws Exception
    {
        ObjectMapper mapper = new ObjectMapper();
        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        return mapper.readValue(jsonString, (Class<T>) t.getClass());
    }
}
