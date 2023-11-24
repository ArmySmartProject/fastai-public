package ai.maum.biz.fastaicc.main.user.mapper;

import java.util.List;

import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;

@Repository
@Mapper
public interface AuthMapper {
    public UserVO getAccount(String username);

    public UserVO getAccountById(int id);

    public int insertUser(UserVO account);

    public int insertSsoUser(UserVO userVO);

    public  int checkDup(UserVO authVO);

    public int updateAccount(UserVO authVO);

    public int disableAccount(UserVO authVO);

    public int enableAccount(UserVO authVO);

    public List<UserVO> getUserList(FrontMntVO frontMntVO);

    public int getresultUserTotalCount();
    
    public int updateLoginDt(UserVO authVO);
    
    public String getSessionId(UserVO userVO);

    public void addPwError(Map map);
}
