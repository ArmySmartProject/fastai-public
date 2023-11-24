function openSso() {
    // const url = "https://hq.maum.ai:10080/hq/oauth/authorize?response_type=code&client_id=DataEditTool&redirect_uri=https://www.naver.com/&scope=read_profile&state=223e9635-083d-4462-96c4-2dad5979a3e4";
    // window.open(url);

    $.ajax({
        url : "/api/sso/properties/request",
        type : "GET"
    }).done(function(data){
        var url =
            data.maumLoginUrl
        window.open(url, "_self");
    }).fail(function(data){
        alert('<spring:message code="message.add.failure"/>');
        return false;
    });

}
