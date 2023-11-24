package ai.maum.biz.fastaicc.common.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignScoreVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Component
public class Utils {
	// 널 체크. null or ''인 경우 null로 세팅
	public String checkNullInit(String str) {
		if( StringUtils.isBlank(str) ) {
			return str = null;
		}

		return str;
	}
	
	
	//Session 체크 후 로그인 or 유효페이지 리턴
	public boolean checkSession(HttpSession sess) {
		String uid = (String)sess.getAttribute("uid");
		String id = (String)sess.getAttribute("id");
		
		if( StringUtils.isBlank(uid) || StringUtils.isBlank(id) ) {
			return false;
		}else {
			return true;
		}
	}


	//로그아웃, 모든 세션 삭제.
	public void logout(HttpSession sess) {
		sess.invalidate();
	}
	
	
	// 콜상태 코드 값 <option> 태그 생성
	public static String makeCallStatusTag(HashMap<String, String> mapObj) {
		StringBuilder returnVal = new StringBuilder();
		
		for(String key : mapObj.keySet() ) {
			returnVal.append("<option value='").append(key).append("'>").append(mapObj.get(key)).append("</option>");
		}
		
		return returnVal.toString();
	}
	
	
	//List<CmCampaignScoreDTO> 형태를 Map으로 전환
	public static HashMap<String, String> makeHashMapForScore(List<CmCampaignScoreVO> list) {
		HashMap<String, String> scoreMap = new HashMap<String, String>();
		
		String taskVal = "";
		for(CmCampaignScoreVO one : list) {
			taskVal = one.getTaskValue();
			if( StringUtils.isBlank(taskVal) ){
				scoreMap.put(one.getInfoSeq(), "");
			}else{
				scoreMap.put(one.getInfoSeq(), taskVal);
			}
		}
		
		return scoreMap;
	}
	
	public List<CmContractVO> doSortForAutoMonitoring(List<CmContractVO> list, String chkList) {
		List<CmContractVO> returnVal = null;
		List<CmContractVO> head = new ArrayList<>();
		List<CmContractVO> tail = new ArrayList<>();
		
		String [] chkSplit = chkList.split(",");
		
		int flag = 0;
		for( CmContractVO oneDTO : list) {
			for(String one : chkSplit) {
				if( !StringUtils.isBlank(one) ) {
					if( one.equals(oneDTO.getContractNo()) ) {
						head.add(oneDTO);
						flag = 1;
						break;
					}
				}
			}
			
			if(flag == 0) {
				tail.add(oneDTO);
			}
			
			flag = 0;
		}
		
		returnVal = ListUtils.union(head, tail);
		
		return returnVal;
	}

	public long getDateDiff(Date from, Date to) {
		long diff = from.getTime() - to.getTime();
		return diff/(24*60*60*1000);
	}

	// 로그인 시 사용자 이름 가져오기
	public static UserVO getLogInAccount(AuthService authService) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		UserVO account=null;
		if(authService!=null)
			account = authService.getAccount(userId);

		return account;
	}
	
	// 로그인 시 사용자 이름 가져오기
	public static UserVO getUserVo() {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			return userDto.getUser();
		}

		return null;
	}
}












