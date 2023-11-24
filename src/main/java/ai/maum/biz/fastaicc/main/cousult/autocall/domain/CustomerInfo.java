package ai.maum.biz.fastaicc.main.cousult.autocall.domain;

public class CustomerInfo {
  private Integer contractNo;

  public CustomerInfo(Integer contractNo) {
    this.contractNo = contractNo;
  }
  public Integer getContractNo() {
    return contractNo;
  }

  public void setContractNo(Integer contractNo) {
    this.contractNo = contractNo;
  }

}
