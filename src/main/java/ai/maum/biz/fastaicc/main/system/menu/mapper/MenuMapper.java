package ai.maum.biz.fastaicc.main.system.menu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;

@Repository
@Mapper
public interface MenuMapper {
	
	public List<MenuVO> getMenu();
	
	public List<MenuVO> getUserMenuAll();
	
	public List<MenuVO> getUserMenuCompany(String userId);
	
    public List<MenuVO> getUserMenuSystem();
    
    public List<MenuVO> getUserMenuUserId(String userId);
    
    public List<MenuVO> getUserMenuCompanyId(String userId);
}
