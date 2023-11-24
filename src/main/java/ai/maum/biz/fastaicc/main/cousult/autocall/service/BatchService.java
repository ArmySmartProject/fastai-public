package ai.maum.biz.fastaicc.main.cousult.autocall.service;

import ai.maum.biz.fastaicc.main.cousult.autocall.domain.CustomerHistory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Repository
@Service
public interface BatchService {
  int saveConditionHistory(int conditionId);
  String saveHistory(List<CustomerHistory> customerHistory);
  String getCondition(Date curTime);
  String getMsgTalkCondition(Date curTime);
}
