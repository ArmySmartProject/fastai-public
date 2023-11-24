package ai.maum.biz.fastaicc.main.cousult.socket.controller;

import ai.maum.biz.fastaicc.common.config.GetHttpSessionConfigurator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import java.util.Map;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@ServerEndpoint(value="/updateOpStatus", configurator = GetHttpSessionConfigurator.class)
public class UpdateOpStatusController {

    @Autowired
    CommonService commonService;

    @Autowired
    CampaignService campaignService;

    @Autowired
    CustomProperties customProperties;

    @Autowired
    VariablesMng variablesMng;
    
    //private static final List<Session> sessionList=new ArrayList<Session>();
    
    private static final List<Session> sessionList=new ArrayList<Session>();
    private static final Map<Session, EndpointConfig> configs = Collections.synchronizedMap(new HashMap<>());

    public UpdateOpStatusController() {
		// TODO Auto-generated constructor stub
        log.info("웹소켓(서버) UpdateOpStatusController 객체생성");
    }
    
    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
    	
        log.info("Open session id:"+session.getId());
        if (!configs.containsKey(session)) {
            configs.put(session, config);
        }
        try {
            final Basic basic=session.getBasicRemote();
            basic.sendText("wss");
        }catch (Exception e) {
            // TODO: handle exception
            log.error(e.getMessage());
        }
        sessionList.add(session);
    }
    /*
     * 모든 사용자에게 메시지를 전달한다.
     * @param self
     * @param message
     */
    private void sendAllSessionToMessage(Session self,String message) throws Exception {

        EndpointConfig selfConfig = configs.get(self);
        HttpSession selfHttpSession = (HttpSession) selfConfig.getUserProperties().get(GetHttpSessionConfigurator.Session);
        log.info("selfHttpSession id : "+selfHttpSession.getId());

    	  try {
            for(Session session : UpdateOpStatusController.sessionList) {
                EndpointConfig config = configs.get(session);
                HttpSession httpSession = (HttpSession) config.getUserProperties().get(GetHttpSessionConfigurator.Session);
                log.info("httpSession id : "+httpSession.getId());
                if(!self.getId().equals(session.getId()) && !selfHttpSession.getId().equals(httpSession.getId())) {
                	log.debug(message);
                    session.getBasicRemote().sendText(message);
                }
            }
        }catch (Exception e) {
            // TODO: handle exception
            log.error(e.getMessage());
        }

    }
    @OnMessage
    public void onMessage(String message,Session session) throws Exception {
    	
    	log.info("Message From "+message);
    	
         try {
             final Basic basic=session.getBasicRemote();
             basic.sendText("to : "+message);
         }catch (Exception e) {
             // TODO: handle exception
             log.error(e.getMessage());
         }
         sendAllSessionToMessage(session, message);

    }
    
    @OnError
    public void onError(Throwable e,Session session) {
        
    }
    
    @OnClose
    public void onClose(Session session) {
    	log.info("Session "+session.getId()+" has ended");
        sessionList.remove(session);

        if (configs.containsKey(session)) {
            configs.remove(session);
        }

    }

    
}
