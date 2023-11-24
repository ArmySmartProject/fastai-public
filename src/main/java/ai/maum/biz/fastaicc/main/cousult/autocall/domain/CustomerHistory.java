package ai.maum.biz.fastaicc.main.cousult.autocall.domain;

public class CustomerHistory {

  private int CD_HISTORY_ID;
  private int CONTRACT_NO;
  private int CAMPAIGN_ID;
  private String VALID_YN;

  public int getCD_HISTORY_ID() {
    return CD_HISTORY_ID;
  }

  public void setCD_HISTORY_ID(int CD_HISTORY_ID) {
    this.CD_HISTORY_ID = CD_HISTORY_ID;
  }

  public int getCONTRACT_NO() {
    return CONTRACT_NO;
  }

  public void setCONTRACT_NO(int CONTRACT_NO) {
    this.CONTRACT_NO = CONTRACT_NO;
  }

  public int getCAMPAIGN_ID() {
    return CAMPAIGN_ID;
  }

  public void setCAMPAIGN_ID(int CAMPAIGN_ID) {
    this.CAMPAIGN_ID = CAMPAIGN_ID;
  }

  public String getVALID_YN() {
    return VALID_YN;
  }

  public void setVALID_YN(String VALID_YN) {
    this.VALID_YN = VALID_YN;
  }
}
