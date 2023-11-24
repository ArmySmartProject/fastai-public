package ai.maum.biz.fastaicc.common.security;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component("loginFailureHandler")
public class LoginFailureHandler implements AuthenticationFailureHandler {

	private String loginidname;			// 로그인 id값이 들어오는 input 태그 name
	private String loginpasswdname;		// 로그인 password 값이 들어오는 input 태그 name
	private String loginredirectname;		// 로그인 성공시 redirect 할 URL이 지정되어 있는 input 태그 name
	private String exceptionmsgname;		// 예외 메시지를 request의 Attribute에 저장할 때 사용될 key 값
	private String defaultFailureUrl;		// 화면에 보여줄 URL(로그인 화면)

	AuthService authService;
	CustomProperties customProperties;


	public LoginFailureHandler(AuthService authService, CustomProperties customProperties ){
		this.loginidname = "j_username";
		this.loginpasswdname = "j_password";
		this.loginredirectname = "loginRedirect";
		this.exceptionmsgname = "error_msg";
		this.defaultFailureUrl = "/login";
		this.authService = authService;
		this.customProperties = customProperties;
	}
	
	
	public String getLoginidname() {
		return loginidname;
	}


	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}


	public String getLoginpasswdname() {
		return loginpasswdname;
	}


	public void setLoginpasswdname(String loginpasswdname) {
		this.loginpasswdname = loginpasswdname;
	}

	public String getExceptionmsgname() {
		return exceptionmsgname;
	}

	public String getLoginredirectname() {
		return loginredirectname;
	}


	public void setLoginredirectname(String loginredirectname) {
		this.loginredirectname = loginredirectname;
	}


	public void setExceptionmsgname(String exceptionmsgname) {
		this.exceptionmsgname = exceptionmsgname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}


	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}


	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			org.springframework.security.core.AuthenticationException exception) throws IOException, ServletException {
		HttpSession session = request.getSession();
		String referer = request.getHeader("referer");
		if (referer.contains("/redtie/login")) {
			this.defaultFailureUrl = "/redtie/login";
			session.setAttribute("root", "/redtie/login");
		} else if (referer.contains("/mobile/login")) {
			this.defaultFailureUrl = "/mobile/login";
			session.setAttribute("root", "/mobile/login");
		} else if (referer.contains("/loginProcess")){
			String root = (String) session.getAttribute("root");
			this.defaultFailureUrl = root;
		} else {
			this.defaultFailureUrl = "/login";
			session.setAttribute("root", "/login");
		}
		String errormsg = "errormsg";
		if(exception instanceof AuthenticationCredentialsNotFoundException) {
			errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
		} else if(exception instanceof LockedException) {
			errormsg = "계정이 잠겨있습니다. 관리자에게 문의하세요.";
		} else if(exception instanceof DisabledException) {
			errormsg = "계정이 잠겨있습니다. 관리자에게 문의하세요.";
		} else if(exception instanceof UsernameNotFoundException) {
			errormsg = "계정이 비활성 상태이거나 사용자가 존재하지 않습니다. 관리자에게 문의하세요.";
		} else if(exception instanceof BadCredentialsException){
			String nowUserName = request.getParameter("username");
			int nowPwError;
			String companyId = "";
			String SbscrbTy = "";
			try{
				UserVO user = authService.getAccount(nowUserName);
				companyId = user.getCompanyId().toString();
				SbscrbTy = user.getSbscrbTy().toString();
				nowPwError = user.getPwError();
			}catch (Exception e){
				nowPwError = 0;
			}
			if(companyId.equals("comp007") && SbscrbTy.equals("S")){
				errormsg = "FastIdError";
			}else {
				errormsg = "PWError/" + nowPwError + "/" + customProperties.getPwErrMax();
			}

		}
		
		// Request 객체의 Attribute에 사용자가 실패시 입력했던 로그인 ID와 비밀번호를 저장해두어 로그인 페이지에서 이를 접근하도록 한다
		String loginid = request.getParameter(loginidname);
		String loginpasswd = request.getParameter(loginpasswdname);
		String loginRedirect = request.getParameter(loginredirectname);
		
		request.setAttribute(loginidname, loginid);
		request.setAttribute(loginpasswdname, loginpasswd);
		request.setAttribute(loginredirectname, loginRedirect);
		// Request 객체의 Attribute에 예외 메시지 저장
		request.setAttribute(exceptionmsgname, errormsg);
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}
}
