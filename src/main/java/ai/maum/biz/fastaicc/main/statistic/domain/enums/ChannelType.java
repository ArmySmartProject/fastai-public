package ai.maum.biz.fastaicc.main.statistic.domain.enums;

public enum ChannelType {

    HOMEPAGE("HOMEPAGE"),
    MOBILE("MOBILE"),
    KIOSK("KIOSK");

    final private String name;

    public String getName() {
        return name;
    }

    private ChannelType(String name){
        this.name = name;
    }
}
