package ai.maum.biz.fastaicc.main.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.system.admin.mapper.SystemManageMapper;
import ai.maum.biz.fastaicc.main.system.admin.service.SystemManageService;
import ai.maum.biz.fastaicc.main.user.domain.OAuthTokenVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.mapper.AuthMapper;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    AuthMapper authMapper;
    
    @Autowired
    SystemManageMapper systemManageMapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    UtilProperties utilProperties;

    @Autowired
	SystemManageService systemManageService;
	
    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        UserVO account = authMapper.getAccount(userId);
        //account.setAuthorities(getAuthorities(userId));

        return account;
    }


    public UserVO getAccount(String userId) {
        return authMapper.getAccount(userId);
        
    }

    public List<UserVO> getUserList(FrontMntVO frontMntVO){
        return authMapper.getUserList(frontMntVO);
    }


    //SSO 연동 사용자 추가
    public int addSsoAccount(UserVO userVO) {
		int result  = authMapper.insertSsoUser(userVO);
		
		HashMap<String,Object> param=new HashMap<String,Object>();
		param.put("companyGroupId", Integer.parseInt(utilProperties.getCompanyGroupId()));
		param.put("userId", userVO.getUserId());
		param.put("CUST_OP_ID",  userVO.getUserId());
		systemManageService.insertMenuAuthMenuGroup(param);
		
		return result;
    }

    // 계정 중복 확인
    public int checkDup(UserVO authVO) {
        return authMapper.checkDup(authVO);
    }

    //Id와 일치하는 계정 정보 가져오기
    public UserVO getAccountById(int id) {
        return authMapper.getAccountById(id);
    }

    //paging
    public int getresultUserTotalCount(FrontMntVO frontMntVO) { return authMapper.getresultUserTotalCount(); }

    //기존 계정 수정 데이터
    @Override
    public int updateAccount(UserVO authVO) {
        authVO.setNewPassword(passwordEncoder.encode(authVO.getNewPassword()));
        return authMapper.updateAccount(authVO);
    }

    //기존 계정중 체크된 거 비활성화할 계정
    @Override
    public int disableAccount(UserVO authVO) { return authMapper.disableAccount(authVO);
    }

    //기존 계정중 체크된 거 활성화할 계정
    @Override
    public int enableAccount(UserVO authVO) { return authMapper.enableAccount(authVO);
    }

    // 로그인 시간 변경 
    public int updateLoginDt(UserVO authVO) {return authMapper.updateLoginDt(authVO);};

    // sso 로그인 연동
    @Override
    public void addOAuthUserIfNotExist(OAuthTokenVO token) throws Exception {
        UserVO currentUser = authMapper.getAccount(token.getEmail());

        Random random = new Random();
        String pw = String.valueOf(random.nextInt());

        UserVO tmpAuth = new UserVO();
        tmpAuth.setUsername(token.getEmail());
        tmpAuth.setUserNm(token.getName());
        tmpAuth.setPassword(passwordEncoder.encode(pw));
        tmpAuth.setName(token.getName());

        System.out.println(utilProperties.getCompanyId());
        tmpAuth.setCompanyId(utilProperties.getCompanyId());

        tmpAuth.setDeleteAt("N");
        tmpAuth.setUserAuthTy("N");
        tmpAuth.setSbscrbTy("S");
        tmpAuth.setLoginFailCnt("0");
        addSsoAccount(tmpAuth);

    }
    
    @Override
    public void addMaumAiUserIfNotExist(String email, String name) throws Exception {

        Random random = new Random();
        String pw = String.valueOf(random.nextInt());

        UserVO tmpAuth = new UserVO();
        tmpAuth.setUsername(email);
        tmpAuth.setUserNm(name);
        tmpAuth.setPassword(passwordEncoder.encode(pw));
        tmpAuth.setName(name);

        System.out.println(utilProperties.getCompanyId());
        tmpAuth.setCompanyId(utilProperties.getCompanyId());

        tmpAuth.setDeleteAt("N");
        tmpAuth.setUserAuthTy("N");
        tmpAuth.setSbscrbTy("S");
        tmpAuth.setLoginFailCnt("0");
        addSsoAccount(tmpAuth);
    }

	@Override
	public String getSessionId(UserVO userVo) {
		return authMapper.getSessionId(userVo);
	}


	@Override
	public int updateUserMenuGroup(Map<String, Object> userInfo) {
		return systemManageMapper.updateMenuAuthMenuGroup(userInfo);
	}

	@Override
	public void addPwError(Map map){
        authMapper.addPwError(map); }
}
