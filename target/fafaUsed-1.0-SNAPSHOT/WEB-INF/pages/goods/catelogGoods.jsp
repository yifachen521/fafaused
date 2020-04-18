<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>发发闲置</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <script>

        //可注册标记
        var flagpwd = false;
        var flagTel = false;
        var flagEmail = false;

        //未登录提示
        function showLogin() {
            if ($("#signup-show").css("display") == 'block') {
                $("#signup-show").css("display", "none");
            }
            if ($("#login-show").css("display") == 'none') {
                $("#login-show").css("display", "block");
            } else {
                $("#login-show").css("display", "none");
            }
        }

        //注册
        function showSignup() {
            if ($("#login-show").css("display") == 'block') {
                $("#login-show").css("display", "none");
            }
            if ($("#signup-show").css("display") == 'none') {
                $("#signup-show").css("display", "block");
            } else {
                $("#signup-show").css("display", "none");
            }
        }

        //登陆后修改用户名
        function ChangeName() {
            if ($("#changeName").css("display") == 'none') {
                $("#changeName").css("display", "block");
            } else {
                $("#changeName").css("display", "none");
            }
        }

        //注册表单提交
        function submitZuChe() {

            if (flagTel == true && flagpwd == true && flagEmail == true) {
                //注册
                $("#signup_form").submit();

            } else {
                //
                alert("请检查您的信息是否正确^_^");

            }
        }

        //登录验证性 loginIn
        function clicklogin() {
            //获取手机号 获取密码 进行登录的验证
            var pwd = $("#login_password").val();
            var tel = $("#login_phone").val();
            //
            $.ajax({
                url: '<%=basePath%>user/login',
                type: 'POST',
                data: {phone: tel, password: pwd},
                dataType: 'json',
                success: function (json) {
                    if (json.info == "success") {
                        //登录成功 登录状态
                        window.location.href = "<%=basePath%>goods/homeGoods";
                    } else {
                        //未登录状态
                        window.location.href = "<%=basePath%>goods/homeGoods";
                    }

                },
                error: function () {
                    alert('请求超时或系统出错!');
                    alert('账户或密码有误哟^_^');
                }

            });

        }


        //注册的异步验证 用户名是否重复
        $(document).ready(function () {

            // 验证邮箱
            $("#email").blur(function () {
                var email = $("#email").val();
                //正则表达式
                var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (RegExp(reg).test(email)) {
                    //修改标记  表示本项符合注册标准
                    $("#errorEmail").empty();
                    flagEmail = true;

                } else {
                    $("#errorEmail").html("邮箱地址不对哟!");
                }


            });


            //验证密码输入一致
            $("#pwd2").blur(function () {
                var phone1 = $("#pwd1").val();
                var phone2 = $("#pwd2").val();
                if (phone1 != phone2) {
                    //密码不一致 提示  errorPwd
                    $("#errorPwd").html("两次输入密码不一致哟!");
                } else {
                    //修改标记  表示本项符合注册标准
                    $("#errorPwd").empty();
                    flagpwd = true;
                }
            });


            //异步验证手机号
            $("#phone").blur(function () {
                var phone = $(this).val();
                $.ajax({
                    url: '<%=basePath%>user/register',
                    type: 'POST',
                    data: {phone: phone},
                    dataType: 'json',
                    success: function (json) {
                        if (json.info == 'success') {
                            $("#errorPhone").html("账号已被注册，请重新输入!");
                            //$("#register").attr("disabled",true);
                        } else {
                            $("#errorPhone").empty();
                            // $("#register").attr("disabled",false);
                            flagTel = true;
                        }
                    },
                    error: function () {
                        alert('请求超时或系统出错!');
                    }
                });

            });
        });


    </script>
<body ng-view="ng-view">
<!--
    描述：顶部
-->
<jsp:include page="main-info.jsp"></jsp:include>
<jsp:include page="main-left-info.jsp"></jsp:include>
<!--
    描述：右侧显示部分
-->
<div class="main-content">
    <!--
        描述：最新发布
    -->
    <div class="index-title">
        <c:if test="${empty catelog.name}"><a href="">最新发布</a></c:if>
         <c:if test="${!empty catelog.name}"><a href="">${catelog.name}</a></c:if>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${goodsExtendList}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>发发闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>