package ai.maum.biz.fastaicc.common.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import ai.maum.biz.fastaicc.common.CustomProperties;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Component
public class MailUtill {
	
    @Autowired
    CustomProperties customProperties;
	
	/*
	 * static final String FROM = "mailtest0218@gmail.com"; static final String
	 * FROMNAME = "마인즈랩test"; static final String TO = "accepthan@gmail.com";
	 * 
	 * static final String SMTP_USERNAME = "mailtest0218@gmail.com"; static final
	 * String SMTP_PASSWORD = "a123456789!";
	 * 
	 * static final String HOST = "smtp.gmail.com"; static final int PORT = 25;
	 * 
	 * static final String SUBJECT = "마인즈랩test";
	 * 
	 * static final String BODY = String.join( System.getProperty("line.separator"),
	 * "<h1>메일 내용</h1>", "<p>이 메일은 아름다운 사람이 보낸 아름다운 메일입니다!</p>." );
	 */
 
    public void sendMail(Map<String, Object> CsDtlContMap,Map<String, Object> CsDtlReCallMap,Map<String, Object> CsDtlEsCalationMap) throws Exception {
    	
    	String addr = CsDtlEsCalationMap.get("NEW_CUST_OP_EMAIL").toString();
    	
    	ClassPathResource resource = new ClassPathResource("mail/mail_01.html");
		try {
		    Path path = Paths.get(resource.getURI());
		    List<String> content = Files.readAllLines(path);
		    
		    String mailContent = StringUtil.join(content.toArray());
		    
		    SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    String outString = beforeFormat.format (new Date());
		    mailContent=mailContent.replace("#{DATE}",outString);
		    
		    String NEW_CUST_OP_ID = (String) CsDtlEsCalationMap.get("NEW_CUST_OP_ID");
		    mailContent=mailContent.replace("#{NEW_CUST_OP_ID}",NEW_CUST_OP_ID);
		    
		    String CONSULT_TYPE1_DEPTH_NM = CsDtlContMap.get("CONSULT_TYPE1_DEPTH1_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE1_DEPTH2_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE1_DEPTH3_NM");
		    mailContent=mailContent.replace("#{CONSULT_TYPE1_DEPTH}",CONSULT_TYPE1_DEPTH_NM);
		    
		    String CONSULT_TYPE2_DEPTH_NM = CsDtlContMap.get("CONSULT_TYPE2_DEPTH1_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE3_DEPTH2_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE2_DEPTH3_NM");
		    mailContent=mailContent.replace("#{CONSULT_TYPE2_DEPTH}",CONSULT_TYPE2_DEPTH_NM);
		    
		    String CONSULT_TYPE3_DEPTH_NM = CsDtlContMap.get("CONSULT_TYPE3_DEPTH1_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE3_DEPTH2_NM")+" - "+CsDtlContMap.get("CONSULT_TYPE3_DEPTH3_NM");
		    mailContent=mailContent.replace("#{CONSULT_TYPE3_DEPTH}",CONSULT_TYPE3_DEPTH_NM);
		    
		    String USER_CUST_NM = (String) CsDtlContMap.get("USER_CUST_NM");
		    mailContent=mailContent.replace("#{USER_CUST_NM}",USER_CUST_NM);
		    
		    String USER_CUST_TEL_NO = (String) CsDtlContMap.get("USER_CUST_TEL_NO");
		    mailContent=mailContent.replace("#{USER_CUST_TEL_NO}",USER_CUST_TEL_NO);
		    
		    String USER_CUST_EMAIL = (String) CsDtlContMap.get("USER_CUST_EMAIL");
		    mailContent=mailContent.replace("#{USER_CUST_EMAIL}",USER_CUST_EMAIL);
		    
		    String CALL_MEMO = (String) CsDtlContMap.get("CALL_MEMO");
		    mailContent=mailContent.replace("#{CALL_MEMO}",CALL_MEMO);
		    
		    String IMPORTANCE_LEVEL_NM = (String)CsDtlEsCalationMap.get("IMPORTANCE_LEVEL_NM");
		    mailContent=mailContent.replace("#{IMPORTANCE_LEVEL_NM}",IMPORTANCE_LEVEL_NM);
		    
		    
		    String recipient = addr; //받는 사람의 메일주소를 입력해주세요.
	    	String subject = "안녕하세요. "+NEW_CUST_OP_ID+"님 이관되어진 상담이 있으니 확인하시어 고객에게 적정한 응대 바랍니다."; //메일 제목 입력해주세요. 
	    	String body = mailContent; //메일 내용 입력해주세요.
	    	
			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1); 
			nameValuePairs.add(new BasicNameValuePair("fromaddr", "fastai@maum.ai"));
			nameValuePairs .add(new BasicNameValuePair("toaddr", recipient)); 
			nameValuePairs.add(new BasicNameValuePair("subject", subject));
			nameValuePairs.add(new BasicNameValuePair("message", body));
			log.info(body);
			
	    	HttpClient hc = HttpClients.createDefault();
	        String callMngUrl = "https://maum.ai/support/sendMail";
	        
	        HttpPost hp = new HttpPost(callMngUrl);
	        StringEntity passJson;
	        HttpResponse getRes;

	        try {
	            //passJson = new StringEntity(buffer.toString());

	            //hp.addHeader("Content-type", "application/json");
	            //hp.setEntity(passJson);
	            hp.setEntity(new UrlEncodedFormEntity(nameValuePairs,"UTF-8"));

	            getRes = hc.execute(hp);
	            String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }    	
	        
		} catch (IOException e) {
			e.printStackTrace();
		}

    	
    }
}
