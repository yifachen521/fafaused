
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">


    <nav class="white nav1">

        <div class="nav-wrapper">
            <a href="<%=basePath%>goods/homeGoods" class="logo">
                <img src="<%=basePath%>img/logo.jpg">

                <em class="em1">发发闲置</em>

                <em class="em3">——校园二手信息平台</em>
            </a>
            <div class="nav-wrapper search-bar">
                <form class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜点什么吧..." style="height: 40px;"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <input type="submit" class="btn" value="搜索" style="height: 40px;">
                        <label for="search" class="active">
                            <i ng-click="search()" class="iconfont"></i>
                        </label>
                    </div>
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button onclick="showLogin()" data-toggle="tooltip"
                                title="您需要先登录哦！" class="#00BFFF lighten-1 waves-effect waves-light btn">
                            我要发布
                        </button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li >
                        <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/basic">${cur_user.username}</a>
                    </li>
                    <%--  <li class="notification">
                    <i ng-click="showNotificationBox()" class="iconfont"></i>
                    </li> --%>
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="<%=basePath%>user/home">个人中心</a></li>
                                <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                                <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
<!--
    描述：登录
-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title">
                        <div style="height: 10px;width: auto"></div>
                        <span style="font-size: 30px;color: #aaa;"><center>欢迎登录</center></span>
                    </div>
                </a>
                <form action="#" method="post" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="login_phone" required="required" pattern="^1[0-9]{10}$"
                               value="15037752845"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机&nbsp;&nbsp;<div id="login_errorPhone" style="color:red;display:inline;"></div>
                        </label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" id="login_password" name="password" required="required" value="1"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码&nbsp;&nbsp;<div id="errorPassword" style="color:red;display:inline;"></div>
                        </label>
                        <a onclick="forgetPwd()" class="forget-btn">忘记密码？</a>
                    </div>
                    <button type="button" id="loginIn" onclick="clicklogin()"
                            class="waves-effect waves-light btn login-btn red lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--

    描述：注册
-->
<div ng-controller="signupController" class="ng-scope">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showSignup()">
                    <div class="col s12 title">
                        <div style="height: 15px;width: auto"></div>
                        <span style="font-size: 30px;color: #aaa;"><center>快速注册</center></span>
                    </div>
                </a>
                <form action="<%=basePath%>user/addUser" method="POST" role="form" id="signup_form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机&nbsp;&nbsp;<div id="errorPhone" style="color:red;display:inline;"></div>
                        </label>

                    </div>

                    <div class="input-field col s12">
                        <input type="email" name="email" id="email" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>邮箱&nbsp;&nbsp;<div id="errorEmail" style="color:red;display:inline;"></div>
                        </label>

                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" id="pwd1" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password2" id="pwd2" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>确认密码
                            <div id="errorPwd" style="color:red;display:inline;"></div>
                        </label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="button" onclick="submitZuChe()" id="register"
                                class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


</body>
</html>
