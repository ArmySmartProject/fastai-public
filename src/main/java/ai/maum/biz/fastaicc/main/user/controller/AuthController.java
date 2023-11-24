package ai.maum.biz.fastaicc.main.user.controller;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class AuthController {

    @Autowired
    AuthService authService;

    @Autowired
    CommonService commonService;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    CustomProperties customProperties;

    @Autowired
    ConsultingService consultingService;

    @Inject
    Utils utils;

    @Inject
    VariablesMng variablesMng;

    @RequestMapping(value = "/authCkeck", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String authCheck() {
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			return "true";
		}
        return "false";
    }
    
    @RequestMapping(value = "/authority_duplicate_login", method = {RequestMethod.GET, RequestMethod.POST})
    public String duplicate_login() {

        return "/errors/authority_duplicate_login";
    }

    @RequestMapping(value = {"/mobile/login", "/mobile/redtie/login"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String goLoginMobile() {

        return "/mobile/chatting_login";
    }

    @RequestMapping(value = "/redtie/login", method = {RequestMethod.GET, RequestMethod.POST})
    public String goLoginRedtie() {

        return "/login_redtie";
    }

    @RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
    public String goLogin() {

        return "/login";
    }

    @RequestMapping(value = "/intro", method = {RequestMethod.GET, RequestMethod.POST})
    public String goIntro() {

        return "/intro";
    }

    //로그인 - 로그인 버튼 클릭 시 호출, 로그인 체크.
    @RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
    public String doLogout(HttpSession session) {
        utils.logout(session);

        return "/login";
    }

    @RequestMapping("/failed")
    @ResponseBody
    public String failed() {
        return "Failed";
    }


    @ResponseBody
    @RequestMapping(value = "/checkPwError", method = RequestMethod.POST)
    public boolean checkPwError(@RequestBody HashMap<String, String> checkID) {
        try{
            String nowID = checkID.get("idToLogin");
            UserVO userVO = authService.getAccount(nowID);
            if(userVO.getPwError()>=customProperties.getPwErrMax()){
                return false;
            }
        }catch (Exception e){
            return true;
        }
        return true;
    }

    @ResponseBody
    @RequestMapping(value = "/changePWEmail", method = RequestMethod.POST)
    public String changePWEmail(@RequestBody HashMap<String, String> checkID) {
        String nowID = checkID.get("idToLogin");
        UserVO userVO = authService.getAccount(nowID);
        try{
            String nowEmail = userVO.getEmail();
            if(nowEmail!=null){
                if(nowEmail.length()>0){
                    String randomPW = getRandomString(10);
                    changePW(nowID, randomPW);
                    sendEmailWithPW(nowID,nowEmail,randomPW);
                    if(nowEmail.length()>3){
                        char[] emailArray = nowEmail.toCharArray();
                        for(int i = 3; i<nowEmail.length(); i++){
                            emailArray[i] = '*';
                        }
                        nowEmail = String.valueOf(emailArray);
                    }
                    return "[useremail]/" + nowEmail;
                }
            }
        }catch (Exception e){}
        try{
            String superID = userVO.getRegisterId();
            if(superID.length()>3){
                char[] idArray = superID.toCharArray();
                for(int i = 3; i<superID.length(); i++){
                    idArray[i] = '*';
                }
                superID = String.valueOf(idArray);
            }
            return "[superid]/" + superID;
        }catch (Exception e){
            return "[ERROR]";
        }
    }


    @ResponseBody
    @RequestMapping(value = "/resetPwLock", method = RequestMethod.POST)
    public boolean resetPwLock(@RequestBody HashMap<String, String> checkID) {
        try{
            String nowID = checkID.get("idToCheck");
            Map<String, Object> pwErrorMap = new HashMap<>();
            pwErrorMap.put("PW_ERROR",0);
            pwErrorMap.put("USER_ID",nowID);
            authService.addPwError(pwErrorMap);
            changePW(nowID, nowID);
        }catch (Exception e){
        }
        return true;
    }

    private boolean sendEmailWithPW(String id, String email, String newPW){
        System.out.println("SendEmailWithPw : " + id + "/" + email + "/" + newPW);
        String idStr = id;
        if(idStr.length()>3){
            char[] idArray = idStr.toCharArray();
            for(int i = 3; i<idStr.length(); i++){
                idArray[i] = '*';
            }
            idStr = String.valueOf(idArray);
        }
        String nowMessage = "  <div style=\"margin:0;padding:100px 0;height:100%;background-color:#f7f8fc;\">\n"
            + "    <div style=\"width:650px; margin: 0 auto; border:solid 1px #cfd5eb; text-align:center;\">\n"
            + "      <div style=\"background:#fff;padding:0 10px;\">\n"
            + "        <div style=\"margin:0;border-bottom:1px solid #eaecf3;\">\n"
            + "          <img src=\"https://ci6.googleusercontent.com/proxy/qXwX7hz7j_fnotDuWdp1bg7Her0-_rqqMsMV6vycFvZfASLH83Dd4grY3bSTKQuBK6-Ix8EDvw7FI7LbSPCsFcM=s0-d-e1-ft#https://maum.ai/aiaas/common/images/maumai.png\" alt=\"logo\" style=\"height:32px;margin:0 auto;padding:17px 0 10px;\">\n"
            + "        </div>\n"
            + "      </div>\n"
            + "      <div style=\"font-size:16px;color:#000;background:#fff;padding:28px 24px 100px;box-sizing:border-box;\">\n"
            + "        <p style=\"font-size:18px;font-weight:600;letter-spacing:-0.26px;color:#14b6cb;margin:0 0 30px 0;\">FAST 대화형 AI</p>\n"
            + "        <p style=\"font-weight:500;line-height:1.71;letter-spacing:-0.4px;color:#34424e;font-size:14px;\">\n"
            + "          임시 비밀번호가 발급되었습니다.\n"
            + "        </p>\n"
            + "        <p style=\"font-weight:500;line-height:1.71;letter-spacing:-0.4px;color:#34424e;font-size:14px;\">\n"
            + "          로그인 후 비밀번호를 변경해주세요.\n"
            + "        </p>\n"
            + "        <div style=\"margin:50px 0 0 0;\">\n"
            + "          <p style=\"font-weight:500;line-height:1.71;letter-spacing:-0.4px;color:#34424e;font-size:14px;\">\n"
            + "            아이디 : <span style=\"font-size:14px;font-weight:bold;line-height:1.79;letter-spacing:-0.4px;padding:0;margin:0 0 30px 0;border-bottom: 1px solid;\">\n"
            + "              "+idStr+"\n"
            + "            </span>\n"
            + "          </p>\n"
            + "          <p style=\"font-weight:500;line-height:1.71;letter-spacing:-0.4px;color:#34424e;font-size:14px;\">\n"
            + "            임시 비밀번호 : <span style=\"font-size:14px;font-weight:bold;line-height:1.79;letter-spacing:-0.4px;padding:0;margin:0 0 30px 0;border-bottom: 1px solid;\">\n"
            + "              "+newPW+"\n"
            + "            </span>\n"
            + "          </p>\n"
            + "        </div>\n"
            + "      </div>\n"
            + "      <div style=\"border-top:1px solid #eaecf3;\">\n"
            + "        <p style=\"background:#fff;font-size:13px;letter-spacing:-0.24px;color:#34424e;margin:0;padding:15px 0 20px;\">Copyright © 2022 주식회사 마인즈랩. All rights reserved.</p>\n"
            + "      </div>\n"
            + "    </div>\n"
            + "  </div>";



        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
        nameValuePairs.add(new BasicNameValuePair("fromaddr", "fastai@maum.ai"));
        nameValuePairs .add(new BasicNameValuePair("toaddr", email));
        nameValuePairs.add(new BasicNameValuePair("subject", "FAST 계정 비활성화로 인한 임시비밀번호입니다."));
        nameValuePairs.add(new BasicNameValuePair("message", nowMessage));

        HttpClient hc = HttpClients.createDefault();
        String callMngUrl = "https://maum.ai/support/sendMail";

        HttpPost hp = new HttpPost(callMngUrl);
        StringEntity passJson;
        HttpResponse getRes;

        try {
            hp.setEntity(new UrlEncodedFormEntity(nameValuePairs, "utf-8"));
            getRes = hc.execute(hp);
            String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");
        } catch (Exception e) {
            System.out.println("sendEmailWithPW Error : " + e.toString());
            return false;
        }
        return true;
    }




    private String getRandomString(int length)
    {
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();
        String chars[] =
        ("a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,"
            + "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z").split(",");
        for (int i=0 ; i<length ; i++)
        { buffer.append(chars[random.nextInt(chars.length)]);}
        return buffer.toString();
    }

    private boolean changePW(String id, String newPw){
        System.out.println("changePW : " + id);
        UserVO nowUser = authService.getAccount(id);
        String chPw = passwordEncoder.encode(newPw);
        Map<String, Object> ChUserPwMap = new HashMap<>();
        ChUserPwMap.put("CUST_OP_CH_PW", chPw);
        ChUserPwMap.put("CUST_OP_USER_ID", nowUser.getUserNo());
        ChUserPwMap.put("ENABLED_YN", "N");
        ChUserPwMap.put("CUST_OP_ID", id);
        consultingService.updateUserPw(ChUserPwMap);

        Map<String, Object> pwErrorMap = new HashMap<>();
        pwErrorMap.put("PW_ERROR",0);
        pwErrorMap.put("USER_ID",id);
        authService.addPwError(pwErrorMap);
        return true;
    }

}

