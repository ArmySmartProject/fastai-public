package ai.maum.biz.fastaicc.main.system.menu.service;

import java.util.LinkedHashMap;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;


@Service
public interface MenuService{

    public LinkedHashMap<String, MenuVO> getUserMenu(String userTy,String userId);
    public LinkedHashMap<String, MenuVO> getMenu();
    public LinkedHashMap<String, MenuVO> getUserMenuAll();
    public LinkedHashMap<String, MenuVO> getUserMenuCompany(String userId);
    public String getUserMeneCours(String lang,String menuCode);
}
