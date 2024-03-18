package ai.maum.biz.fastaicc.main.statistic.domain.enums;

public enum CategoryType {

    INTELLECT("지능형 업무지원"),
    CREATION("생성형 지식지원"),
    TOTALPLATFORM("통합플랫폼 활용지원");

    final private String name;

    public String getName() {
        return name;
    }

    private CategoryType(String name){
        this.name = name;
    }
}
