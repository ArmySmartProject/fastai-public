package ai.maum.biz.fastaicc.main.cousult.autocall.domain;

import java.util.List;

public class MsgTalkInfo {
	private Integer campaignId;
	private Integer conditionId;
	private List<Integer> contractIds;
	private List<String> custNms;
	private List<String> custTelNos;
	private List<String> contractNums;
	  

	public MsgTalkInfo(Integer campaignId, Integer conditionId, List<Integer> contractIds, List<String> custNms, List<String> custTelNos, List<String> contractNums) {
	  this.campaignId = campaignId;
	  this.conditionId = conditionId;
	  this.contractIds = contractIds;
	  this.custNms = custNms;
	  this.custTelNos = custTelNos;
	  this.contractNums = contractNums;
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
	
	public List<String> getCustNms() {
		return custNms;
	}
	
	public void setCustNms(List<String> custNms) {
		this.custNms = custNms;
	}
	
	public void addCustNm(String custNm) {
		this.custNms.add(custNm);
	}
	
	public List<String> getCustTelNos() {
		return custTelNos;
	}
	
	public void setCustTelNos(List<String> custTelNos) {
		this.custTelNos = custTelNos;
	}
	
	public void addCustTelNo(String custTelNo) {
		this.custTelNos.add(custTelNo);
	}
	
	public List<String> getContractNums() {
		return contractNums;
	}
	
	public void setContractNums(List<String> contractNums) {
		this.contractNums = contractNums;
	}
	
	public void addContractNum(String contractNum) {
		this.custTelNos.add(contractNum);
	}
}
