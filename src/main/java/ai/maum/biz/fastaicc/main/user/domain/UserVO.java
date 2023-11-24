package ai.maum.biz.fastaicc.main.user.domain;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO implements UserDetails,Serializable {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -3699528822133982700L;
	
	private int userNo;
    private String userId;
    private String userNm;
    private String userPw;

    private String loginFailCnt;
    private String sbscrbTy;
    private String companyId;
    private String companyName;
    private String companyNameEn;
    
    private String jurirno1;
    private String jurirno2;
    private String bizrno1;
    private String bizrno2;
    private String bizrno3;
    private String moblphonNo1;
    private String moblphonNo2;
    private String moblphonNo3;
    private String fxnum1;
    private String fxnum2;
    private String fxnum3;
    private String rprsntvNm;
    private String bassAdres;
    private String detailAdres;
    private String brthdy;
    private String positionCd;
    private String deptCd;
    private String sexdstn;
    private String opStartTm;
    private String opEndTm;


    private String expiredYn;
    private String lockYn;
    private String crtExpriedYn;
    private String enabledYn;
    
    private String userAuthTy;
    private String userAuthTyNm;
    private Collection <? extends GrantedAuthority> authorities;

    private String recentConectDt;
    private String registDt;
    private String updusrId;
    private String updtDt;
    private String deleteAt;
    private String deleteDt;
    private String registerId;
    
    private String sessionId;
    
    private List<String> usernameList; //for delete
    private String name;
    private String email;
    private String newPassword;        //for update password
    private String targetDt;           //created_date
    private List<String> checkedList;
    private List<String> delAuthList;
    private List<String> accountCheckedList;

    private int pwError;

    private LinkedHashMap<String, MenuVO> menuLinkedMap;

    /** 
     * 시스템 관리자 메뉴 수정화면으로 이동시 저장 한다
     * 해당 변수는 시스템 메뉴의 경로나 상세 정보를 가져올때 사용함
     * 추후 필요한 페이지가 있다면 해당 변수에 저장하여 MenuService의 getUserMeneCours 함수에 사용
    **/
    private LinkedHashMap<String, MenuVO> sysMenuMap;
    
    
    public void setPassword(String userPw) {
		this.userPw=userPw;
	}
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }
    
	@Override
	public String getPassword() {
		return userPw;
	}
	
	public void setUsername(String userId) {
		this.userId=userId;
	}
	
	@Override
	public String getUsername() {
		return userId;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return expiredYn.equals("Y");
	}
	@Override
	public boolean isAccountNonLocked() {
		return lockYn.equals("Y");
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return crtExpriedYn.equals("Y");
	}
	@Override
	public boolean isEnabled() {
		return enabledYn.equals("Y");
	}

  public int getPwError() {
    return pwError;
  }

  public void setPwError(int pwError) {
    this.pwError = pwError;
  }
}
