<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>/css/base.css">
    <link rel="stylesheet" href="<%=basePath%>/css/bootstrap3.css">
    <link rel="icon" href="favicon.png" type="image/png">
    <link rel="stylesheet" href="<%=basePath%>/css/forget_password.css">
    <title>忘记密码</title>
    <script src="<%=basePath%>/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#yzmBtn").click(function () {

                //ajax
                var email = $("input[name='email']");
                if (null != email.val() && email.val() != "") {
                    //alert("====");
                    var params = {"email": email.val()};
                    email.load("<%=basePath%>/user/sendEmail", params, function (data) {
                        if (data == "hasNoUser") {
                            alert("邮箱未注册")
                        } else if (data == "success") {
                            alert("邮件发送成功");
                            //倒计时
                            var time = 60;
                            var timer = setInterval(function () {
                                if (time > 0) {
                                    $("#yzmBtn").attr("disabled", "disabled");
                                    $("#yzmBtn").val(time + "s后重新获取");
                                    time--;
                                    // alert(time--);
                                } else {
                                    clearInterval(timer);
                                    $("#yzmBtn").removeAttr("disabled");
                                    $("#yzmBtn").val("获取验证码");
                                }

                            }, 1000);
                        } else {
                            alert("邮件发送失败");
                        }
                    });
                } else {
                    alert("邮箱不能为空");
                }
            });

        });
        //关闭错误提示框
        function delmsg() {
            $("#warning").remove();
        }
    </script>
</head>

<body>
<main>

    <div style="width: 1140px;margin: 0 auto;">
        <center>
            <form class="ma" action="<%=basePath%>/user/validateEmailCode">
                <div class="form_header">
                    <div class="form_title">
                        <center><h3>忘记密码</h3></center>
                        <span style="color: #aaaaaa"><span style="color: yellow;">💡</span>可通过注册的邮箱来找回</span>
                    </div>
                    <div class="form_back">

                        记起密码？<a href="<%=basePath%>/goods/homeGoods">返回登录</a>
                    </div>
                </div>
                <div class="form_body">
                    <input type="email" placeholder="请输入登录邮箱" name="email" value="${email}">
                    <input type="text" placeholder="请输入验证码" name="code"><input type="button" id="yzmBtn" value="获取验证码"/>
                    <input type="submit" value="提交">
                    <c:if test="${msg!=null}">
                        <div class="alert alert-warning alert-dismissible" id="warning" role="alert">
                            <button type="button" class="close" onclick="delmsg()" data-dismiss="alert"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            ${msg}
                        </div>
                    </c:if>
                </div>
                <div class="form_footer">
                    <div class="FAQ">
                        <span>收不到邮件？查看</span><a href="#">常见问题</a>
                    </div>
                </div>
            </form>
        </center>
    </div>
</main>
</body>

</html>