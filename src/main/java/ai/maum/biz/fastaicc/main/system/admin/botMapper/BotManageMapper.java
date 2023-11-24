package ai.maum.biz.fastaicc.main.system.admin.botMapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface BotManageMapper {
	List<Map> selectAccountList();

	List<Map> selectAccountListByNo(Map<String, String> map);
}
