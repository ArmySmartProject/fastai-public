package ai.maum.biz.fastaicc.common.config;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

public class GetHttpSessionConfigurator extends Configurator {

  public static final String Session = "Session";
  public static final String Context = "Context";

  @Override
  public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
    HttpSession session = (HttpSession) request.getHttpSession();
    ServletContext context = session.getServletContext();
    config.getUserProperties().put(GetHttpSessionConfigurator.Session, session);
    config.getUserProperties().put(GetHttpSessionConfigurator.Context, context);
  }
}
