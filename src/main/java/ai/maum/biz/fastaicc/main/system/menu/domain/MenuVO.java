package ai.maum.biz.fastaicc.main.system.menu.domain;

import java.io.Serializable;
import java.util.LinkedHashMap;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class MenuVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3089541482184615208L;
	private String menuCode;
	private String menuNmKo;
	private String menuNmEn;
	private String bassCour;
	private String menuCour;
	private String topMenuCode;
	private String parntsMenuCode;
	private String menuDp;
	private String sortOrdr;
	private String mngrMenuUrl;
	private String userMenuUrl;
	private String menuTy;
	private String linkTy;	
	private String cntntsTy;
	private String menuOnImage;
	private String menuOffImage;
	private String registerId;
	private String registDt;
	private String updusrId;
	private String updtDt;
	private String deleteAt;
	private String deleteDt;
	private LinkedHashMap<String,MenuVO> menuLinkedMap;
}
