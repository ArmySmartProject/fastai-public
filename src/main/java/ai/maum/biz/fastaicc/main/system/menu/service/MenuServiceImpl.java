package ai.maum.biz.fastaicc.main.system.menu.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import ai.maum.biz.fastaicc.main.system.menu.mapper.MenuMapper;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    MenuMapper menuMapper;


	@Override
	public LinkedHashMap<String, MenuVO> getUserMenu(String userTy,String userId) {
		
		List<MenuVO> userMenuList=null;
		
		if(userTy.equals("S")) {
			userMenuList = menuMapper.getUserMenuSystem();
		}else if(userTy.equals("A")) {
			userMenuList = menuMapper.getUserMenuCompanyId(userId);
		}else {
			userMenuList = menuMapper.getUserMenuUserId(userId);
		}
		LinkedHashMap<String, MenuVO> menuHashMap = new LinkedHashMap<>();
		for(MenuVO vo : userMenuList) {
			menuHashMap.put(vo.getMenuCode(), vo);
		}
		
		
		for(MenuVO vo : userMenuList) {
			String topMenuCode=vo.getTopMenuCode();
			String menuCode=vo.getMenuCode();
			
			if(topMenuCode==null || "".equals(topMenuCode) || menuHashMap.get(topMenuCode) == null)
				continue;
			if(menuHashMap.get(topMenuCode).getMenuLinkedMap()==null) {
				menuHashMap.get(topMenuCode).setMenuLinkedMap(new LinkedHashMap<>());
			}
			menuHashMap.get(topMenuCode).getMenuLinkedMap().put(menuCode,vo);
		}
		
		// 사용자 메뉴 출력
		Set<String> keyset = menuHashMap.keySet();
		for(String key : keyset) {
			
			if(menuHashMap.get(key).getTopMenuCode()==null) {
				// 1뎁스
				log.debug(key);
				LinkedHashMap<String, MenuVO> downMenuList1 = menuHashMap.get(key).getMenuLinkedMap();
				if(downMenuList1!=null) {
					for(String key1 : downMenuList1.keySet()) {
						// 2뎁스
						log.debug("=>"+key1);
						LinkedHashMap<String, MenuVO> downMenuList2 = downMenuList1.get(key1).getMenuLinkedMap();
						
						if(downMenuList2!=null) {
							for(String key2 : downMenuList2.keySet()) {
								// 3뎁스
								log.debug("==>"+key2);
							}
						}
					}
				}
			}
		
		}
		return menuHashMap;
	}


	@Override
	public String getUserMeneCours(String lang, String menuCode) {
		String cours="";
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			LinkedHashMap<String, MenuVO> menuMap = userVo.getSysMenuMap();
			if(menuMap==null) {
				menuMap = getMenu();
				userVo.setSysMenuMap(menuMap);
			}
			if(lang==null) {
				lang="ko";
			}
			String topMenuCode = menuMap.get(menuCode).getTopMenuCode();
			String topMenuCode1 = "";
			
			while(true) {
				//1뎁스 메뉴 경로
				if(menuMap.get(menuCode).getTopMenuCode() == null || "".equals(menuMap.get(menuCode).getTopMenuCode())) {
					if(lang.equals("ko")) {
						cours = menuMap.get(menuCode).getMenuNmKo();
					} else if(lang.equals("en")) {
						cours = menuMap.get(menuCode).getMenuNmEn();
					}
					
					break;
				}
				if(topMenuCode!=null && !"".equals(topMenuCode)) {
					topMenuCode1 = menuMap.get(topMenuCode).getTopMenuCode();
				
					//2뎁스 메뉴 경로
					if(topMenuCode.equals(menuMap.get(topMenuCode).getMenuCode()) && menuMap.get(topMenuCode).getTopMenuCode() == null) {
						if(lang.equals("ko")) {
							cours = menuMap.get(topMenuCode).getMenuNmKo() +" > "+ menuMap.get(menuCode).getMenuNmKo();
						} else if(lang.equals("en")) {
							cours = menuMap.get(topMenuCode).getMenuNmEn() +" > "+ menuMap.get(menuCode).getMenuNmEn();
						}
						break;
					}
					//3뎁스 메뉴 경로
					if(topMenuCode1.equals(menuMap.get(topMenuCode1).getMenuCode())) {
						if(lang.equals("ko")) {
							cours =menuMap.get(topMenuCode1).getMenuNmKo() + " > "+menuMap.get(topMenuCode).getMenuNmKo() +" > "+ menuMap.get(menuCode).getMenuNmKo();
						} else if(lang.equals("en")) {
							cours =menuMap.get(topMenuCode1).getMenuNmEn() + " > "+menuMap.get(topMenuCode).getMenuNmEn() +" > "+ menuMap.get(menuCode).getMenuNmEn();
						}
						break;
					}
				}
			}
		}
		return cours;
	}


	@Override
	public LinkedHashMap<String, MenuVO> getMenu() {

		List<MenuVO> userMenuList= menuMapper.getMenu();
		
		LinkedHashMap<String, MenuVO> menuHashMap = new LinkedHashMap<>();
		for(MenuVO vo : userMenuList) {
			menuHashMap.put(vo.getMenuCode(), vo);
		}
		
		for(MenuVO vo : userMenuList) {
			String topMenuCode=vo.getTopMenuCode();
			String menuCode=vo.getMenuCode();
			
			if(topMenuCode==null || "".equals(topMenuCode) || menuHashMap.get(topMenuCode) == null)
				continue;
			if(menuHashMap.get(topMenuCode).getMenuLinkedMap()==null) {
				menuHashMap.get(topMenuCode).setMenuLinkedMap(new LinkedHashMap<>());
			}
			menuHashMap.get(topMenuCode).getMenuLinkedMap().put(menuCode,vo);
		}
		
		// 사용자 메뉴 출력
		Set<String> keyset = menuHashMap.keySet();
		for(String key : keyset) {
			if(menuHashMap.get(key).getTopMenuCode()==null) {
				LinkedHashMap<String, MenuVO> downMenuList1 = menuHashMap.get(key).getMenuLinkedMap();
				if(downMenuList1!=null) {
					for(String key1 : downMenuList1.keySet()) {
						LinkedHashMap<String, MenuVO> downMenuList2 = downMenuList1.get(key1).getMenuLinkedMap();
						
						if(downMenuList2!=null) {
							for(String key2 : downMenuList2.keySet()) {
							}
						}
					}
				}
			}
		
		}
		return menuHashMap;
	}


	@Override
	public LinkedHashMap<String, MenuVO> getUserMenuAll() {
		List<MenuVO> userMenuList= menuMapper.getUserMenuAll();
		
		LinkedHashMap<String, MenuVO> menuHashMap = new LinkedHashMap<>();
		for(MenuVO vo : userMenuList) {
			menuHashMap.put(vo.getMenuCode(), vo);
		}
		
		for(MenuVO vo : userMenuList) {
			String topMenuCode=vo.getTopMenuCode();
			String menuCode=vo.getMenuCode();
			
			if(topMenuCode==null || "".equals(topMenuCode) || menuHashMap.get(topMenuCode) == null)
				continue;
			if(menuHashMap.get(topMenuCode).getMenuLinkedMap()==null) {
				menuHashMap.get(topMenuCode).setMenuLinkedMap(new LinkedHashMap<>());
			}
			menuHashMap.get(topMenuCode).getMenuLinkedMap().put(menuCode,vo);
		}
		
		// 사용자 메뉴 출력
		Set<String> keyset = menuHashMap.keySet();
		for(String key : keyset) {
			if(menuHashMap.get(key).getTopMenuCode()==null) {
				LinkedHashMap<String, MenuVO> downMenuList1 = menuHashMap.get(key).getMenuLinkedMap();
				if(downMenuList1!=null) {
					for(String key1 : downMenuList1.keySet()) {
						LinkedHashMap<String, MenuVO> downMenuList2 = downMenuList1.get(key1).getMenuLinkedMap();
						
						if(downMenuList2!=null) {
							for(String key2 : downMenuList2.keySet()) {
							}
						}
					}
				}
			}
		
		}
		return menuHashMap;
	}

	
	@Override
	public LinkedHashMap<String, MenuVO> getUserMenuCompany(String userId) {
		List<MenuVO> userMenuList= menuMapper.getUserMenuCompany(userId);
		
		LinkedHashMap<String, MenuVO> menuHashMap = new LinkedHashMap<>();
		for(MenuVO vo : userMenuList) {
			menuHashMap.put(vo.getMenuCode(), vo);
		}
		
		for(MenuVO vo : userMenuList) {
			String topMenuCode=vo.getTopMenuCode();
			String menuCode=vo.getMenuCode();
			
			if(topMenuCode==null || "".equals(topMenuCode) || menuHashMap.get(topMenuCode) == null)
				continue;
			if(menuHashMap.get(topMenuCode).getMenuLinkedMap()==null) {
				menuHashMap.get(topMenuCode).setMenuLinkedMap(new LinkedHashMap<>());
			}
			menuHashMap.get(topMenuCode).getMenuLinkedMap().put(menuCode,vo);
		}
		
		// 사용자 메뉴 출력
		Set<String> keyset = menuHashMap.keySet();
		for(String key : keyset) {
			if(menuHashMap.get(key).getTopMenuCode()==null) {
				LinkedHashMap<String, MenuVO> downMenuList1 = menuHashMap.get(key).getMenuLinkedMap();
				if(downMenuList1!=null) {
					for(String key1 : downMenuList1.keySet()) {
						LinkedHashMap<String, MenuVO> downMenuList2 = downMenuList1.get(key1).getMenuLinkedMap();
						
						if(downMenuList2!=null) {
							for(String key2 : downMenuList2.keySet()) {
							}
						}
					}
				}
			}
		
		}
		return menuHashMap;
	}
	
}
