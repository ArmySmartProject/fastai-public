package ai.maum.biz.fastaicc.common.config;

import ai.maum.biz.fastaicc.common.CustomProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import ai.maum.biz.fastaicc.common.AuthProvider;
import ai.maum.biz.fastaicc.common.JwtAuthenticationFilter;
import ai.maum.biz.fastaicc.common.SSOExternalAPI;
import ai.maum.biz.fastaicc.common.security.LogOutSuccessHandler;
import ai.maum.biz.fastaicc.common.security.LoginFailureHandler;
import ai.maum.biz.fastaicc.common.security.LoginSuccessHandler;
import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Configurable
@EnableWebSecurity
@EnableGlobalAuthentication
@Order(SecurityProperties.DEFAULT_FILTER_ORDER)
public class AuthConfigController extends WebSecurityConfigurerAdapter {

    @Autowired
    AuthProvider authProvider;

    @Autowired
    LogOutSuccessHandler logOutSuccessHandler;
    
    @Autowired
    SSOExternalAPI ssoExternalAPI;
   
    @Autowired
    UtilProperties utilProperties;
    
    @Autowired
    AuthService authService;

    @Autowired
    MenuService menuService;

    @Autowired
    CustomProperties customProperties;

    @Override
    public void configure(WebSecurity web) throws Exception
    {
        web.ignoring().antMatchers(
            "/favicon.ico",
            "/error/**",
            "/webjars/**",
            "/loginajax/**",
            "/resources/**",
            "/getRSAKeyValue/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception
    {
        http
            .authorizeRequests()
            .antMatchers(  "/authority_duplicate_login", "/login", "/intro", "/redtie/login", "/mobile/login",
                "/mobile/redtie/login", "/service","/service/**","/resources/**","/oauth/**","/callReservationApi",
                "/callvalidUrl","/callvalidUrlTest","/api/sso/properties/**","/getBotList",
                "/custDataUploadApi","/manual", "/checkPwError", "/changePWEmail", "/resetPwLock").permitAll()
            .antMatchers("/**").authenticated()
            .and()
            .headers()
            .frameOptions().disable()
            .and()
            .formLogin()
            .loginPage("/login")
            .loginProcessingUrl("/loginProcess")
            .successHandler(new LoginSuccessHandler(menuService))
            .failureHandler(new LoginFailureHandler(authService, customProperties))
            .permitAll()
            .and()
            .logout()
            .invalidateHttpSession(true)  /*로그아웃시 세션 제거*/
            .logoutUrl("/logout") /* 로그아웃 url*/
            .logoutSuccessUrl("/login") /* 로그아웃 성공시 이동할 url */
            .deleteCookies("HAPPYCALLSESSIONID") /*쿠키 제거*/
            .clearAuthentication(true) /*권한정보 제거*/
            .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
            .addLogoutHandler(logOutSuccessHandler)
            .logoutSuccessHandler(logOutSuccessHandler).permitAll()
            .and()
            .csrf()
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/callvalidUrl")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/callvalidUrlTest")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/changePWEmail")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/resetPwLock")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/mobileChatting")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/checkPwError")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/redtie/mobileChatting")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/custDataUploadApi")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .csrf()
            .ignoringAntMatchers("/getBotList")
            .csrfTokenRepository(new CookieCsrfTokenRepository())
            .and()
            .sessionManagement()
            .maximumSessions(1) /* session 허용 갯수 */
            .expiredUrl("/authority_duplicate_login") /* session 만료시 이동 페이지*/
            .maxSessionsPreventsLogin(false).and() /* 동일한 사용자 로그인시 x, false 일 경우 기존 사용자*/
            .and()
            .authenticationProvider(authProvider);
            
        http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
        
    }

    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        JwtAuthenticationFilter filter = new JwtAuthenticationFilter(authService, ssoExternalAPI, utilProperties);
        return filter;
    }
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{

    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    public AuthenticationProvider ssoAuthProvider()
    {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(authService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    SecurityContextRepository securityContextRepository(){
        return new HttpSessionSecurityContextRepository();
    }


    @Bean
    public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
        return new ServletListenerRegistrationBean<HttpSessionEventPublisher>(new HttpSessionEventPublisher());
    }


}
