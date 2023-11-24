package ai.maum.biz.fastaicc.main.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.user.domain.OAuthTokenVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;


@Service
public interface AuthService extends UserDetailsService{

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException;


    public UserVO getAccount(String userId);

    @Transactional("transactionManager")
    public int updateAccount(UserVO authVO);

    public int disableAccount(UserVO authVO);

    public int enableAccount(UserVO authVO);

    public List<UserVO> getUserList(FrontMntVO frontMntVO);

    public int getresultUserTotalCount(FrontMntVO frontMntVO);

    public int checkDup(UserVO authVO);

    public UserVO getAccountById(int id);


    public int updateLoginDt(UserVO authVO);
    
    public int updateUserMenuGroup(Map<String,Object> userInfo);
    
    @Transactional("transactionManager")
    public void addOAuthUserIfNotExist(OAuthTokenVO oAuthTokenVO) throws Exception;
   
    @Transactional("transactionManager")
    public void addMaumAiUserIfNotExist(String email, String name) throws Exception;
    
    public String getSessionId(UserVO userVo);

    public void addPwError(Map map);
}
