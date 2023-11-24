package ai.maum.biz.fastaicc.main.cousult.autocall.domain;

import java.util.List;

public class CallInfo {

  private Integer campaignId;
  private Integer conditionId;
  private List<Integer> contractIds;

  public CallInfo(Integer campaignId, Integer conditionId, List<Integer> contractIds) {
    this.campaignId = campaignId;
    this.conditionId = conditionId;
    this.contractIds = contractIds;
  }

  public Integer getCampaignId() {
    return campaignId;
  }

  public void setCampaignId(Integer campaignId) {
    this.campaignId = campaignId;
  }

  public Integer getConditionId() {
    return conditionId;
  }

  public void setConditionId(Integer conditionId) {
    this.conditionId = conditionId;
  }

  public List<Integer> getContractIds() {
    return contractIds;
  }

  public void setContractIds(List<Integer> contractIds) {
    this.contractIds = contractIds;
  }

  public void addContractId(Integer contractId) {
    this.contractIds.add(contractId);
  }
}
