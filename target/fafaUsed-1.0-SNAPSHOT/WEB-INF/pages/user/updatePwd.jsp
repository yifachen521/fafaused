<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif"
         class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="<%=basePath%>goods/homeGoods">
                <img src="<%=basePath%>img/home_header.png" style="margin-left: 20px;">
            </a>
            <a href="<%=basePath%>user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--
            描述：左侧个人中心栏
        -->
        <jsp:include page="main-left.jsp"/>
        <!--
            描述：右侧内容区域
        -->
        <div id="user_content">
            <div class="basic">
                <center>
                <form:form action="../user/updatePsw" method="post" role="form"><%-- 前边标签中摘出来的 commandName="user"--%>
                    <h1>修改个人密码</h1>
                    <a href="<%=basePath%>user/basic"><strong>修改个人信息</strong></a>
                    <hr/>
                    <div class="changeinfo">
                        <span>旧密码：</span>
                        <input class="in_info1" class="oldpassword" id="oldpassword" type="password" onblur="checkoldpwd()" name="oldpassword" placeholder="请输入旧密码"/>
                        <br>
                        <span id="errorOldpassword"></span>
                    </div>
                    <hr/>
                    <div class="changeinfo">
                        <span>新密码：</span>
                        <input class="in_info1" id="newpassword" type="password" name="newpassword" placeholder="请输入新密码"/>
                    </div>
                    <hr/>
                    <div class="changeinfo">
                        <span>确认密码：</span>
                        <input class="in_info1" id="newpassword2" type="password" name="newpassword2" placeholder="请确认新密码"/>
                        <br>
                        <span id="errorPwd"></span>

                    </div>
                    <hr/>
                    <input type="submit" class="setting-save" value="确认修改"/>
                </form:form>
                </center>
            </div>

        </div>
    </div>
</div>
<script>


    //ajax验证旧密码
   function checkoldpwd() {
       var jQuery = $('#oldpassword').val();

       $.ajax({
           url: '<%=basePath%>user/checkOldPwd',
           type: 'POST',
           data: {oldpassword: jQuery},
           dataType: 'json',
           success: function (json) {
               if (json.info == "success") {
                   $("#errorOldpassword").empty();
               } else {
                   $("#errorOldpassword").html("提示：密码不正确哟!").css("color","red");
               }
           },
           error: function () {
               alert('请求超时或系统出错!');
           }
       });

   }

    //验证密码输入一致
    $("#newpassword2").blur(function () {
        var phone1 = $("#newpassword").val();
        var phone2 = $("#newpassword2").val();
        if (phone1 != phone2) {
            //密码不一致 提示  errorPwd
            $("#errorPwd").html("提示：两次输入密码不一致哟!").css("color","red");
        } else {
            //修改标记  表示本项符合注册标准
            $("#errorPwd").empty();
        }
    });


</script>
</body>
</html>