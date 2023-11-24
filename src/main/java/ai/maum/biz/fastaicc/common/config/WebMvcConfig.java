package ai.maum.biz.fastaicc.common.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import ai.maum.biz.fastaicc.common.CommonInterceptor;
import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.LoginInterceptor;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	/* 메뉴 서비스 */
	@Autowired
	MenuService menuService;

	/* 메뉴 서비스 */
	@Autowired
	AuthService authService;


    @Autowired
    CustomProperties customProperties;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new CommonInterceptor(menuService, authService,customProperties)).addPathPatterns("/**/**")
				.excludePathPatterns("/**/**.*").excludePathPatterns("/login")// 로그인 쪽은 예외처리를 한다.
				.excludePathPatterns("/redtie/login")
				.excludePathPatterns("/mobile/login")
				.excludePathPatterns("/mobile/redtie/login")
				.excludePathPatterns("/oauth/**")
				.excludePathPatterns("/callvalidUrl")
				.excludePathPatterns("/callvalidUrlTest");
		
		registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/login")
				.excludePathPatterns("/resources/**");
	}

	@Bean
	MappingJackson2JsonView jsonView(){
		return new MappingJackson2JsonView();
	}


}
