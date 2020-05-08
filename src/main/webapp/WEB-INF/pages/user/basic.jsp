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
    <title>个人设置</title>
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
                <form:form action="../user/updateInfo" method="post" role="form"><%-- 前边标签中摘出来的 commandName="user"--%>
                    <h1>完善个人信息</h1>
                    <a href="<%=basePath%>user/basic"><strong>修改个人信息</strong></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=basePath%>user/updatePwdPage"><strong>修改密码</strong></a>
                    <hr/>

                    <div class="changeinfo">
                        <span>昵称：</span>
                        <input class="in_info" style="margin-left: 71px" type="text" name="username" placeholder="请输入昵称"
                               value="${cur_user.username}"/>
                    </div>
                    <hr/>
                    <div class="changeinfo">
                        <span>email：</span>
                        <input class="in_info" style="margin-left: 64px" type="email" name="email"
                               value="${cur_user.email}" placeholder="邮箱地址"/>
                    </div>
                    <hr/>
                    <div class="changeinfo">
                        <span>手机号码：</span>
                        <input class="in_info" style="margin-left: 43px;background-color: #a8a8a8" type="text" name="phone"
                               value="${cur_user.phone}" readonly="true"/>
                        <span id="checkphone">已验证</span>
                    </div>
                    <hr/>
                    <div class="changeinfo">
                        <span>QQ：</span>
                        <input class="in_info" style="margin-left: 77px" type="text" name="qq" placeholder="请输入QQ"
                               value="${cur_user.qq}"/>
                    </div>

                    <div style="width: 550px;height: 70px;margin-top: 50px">
                        <input type="submit" class="setting-save" style="margin-left: 40px;" value="修改信息"/>
                        <input type="button" onclick="quitSetting()" style="margin-right: 90px;" class="setting-save1"
                               value="返回"/>
                    </div>

                </form:form>
            </div>

        </div>
    </div>
</div>
<script>
    //quitSetting
    function quitSetting() {
        window.location.href = "<%=basePath%>user/home";
    }
</script>
</body>
</html>