<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google font -->
    <%--<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">--%>

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/error.css"/>

</head>

<body>

<div id="notfound">
    <div class="notfound">
        <div class="notfound-404">
            <div></div>
            <h1>${errorCode}</h1>
        </div>
        <%--<h2>Page not found</h2>--%>
        <a onclick="reLogin()">home page</a>
    </div>
</div>

<script type="text/javascript">
  function reLogin() {
    var referrer = document.referrer;
    if (referrer.includes('redtie/mobileCbCsMain') || referrer.includes('redtie/mobileChatting')) {
      location.href = "${pageContext.request.contextPath}/mobile/redtie/login"
    } else if (referrer.includes('mobileCbCsMain') || referrer.includes('mobileChatting')) {
      location.href = "${pageContext.request.contextPath}/mobile/login"
    } else {
      location.href = "${pageContext.request.contextPath}/"
    }
  }
</script>
</body>

</html>
