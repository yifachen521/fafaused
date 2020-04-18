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

        //忘记密码
        function forgetPwd() {
            window.location.href="<%=basePath%>user/forget_password";

        }





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

        描述：右侧banner（图片）部分
    -->
    <div class="slider-wapper">
        <div class="slider"
             style="height: 440px; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
            <ul class="slides" style="height: 400px;">
                <li class="active" style="opacity: 1;">
                    <a href="<%=basePath%>goods/homeGoods">
                        <div class="bannerimg" style="height: 400px;background: url('../img/findfun.png')">
                            <ul class="bannerul">
                                <p class="text1">Hello：</p>
                                <p class="text2">欢迎来到发发闲置的校园二手信息平台。临近毕业季的</p>
                                <p class="text3">你，是否有太多的闲置与校友分享，为了追求更好的校园服</p>
                                <p class="text4">务，我们打造了一个全新的校园平台——<span>发发闲置</span></p>
                                <p class="text5">这里有更多的闲置分享，更自由的校园话题讨论，你想要的，都在这里。</p>
                                <p class="text6">加入我们，你的大学，应更精彩。</p>
                            </ul>
                            <!--   <div class="logoimg">
                                  <img src="../img/p_logo.jpg" />
                              </div> -->
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!--

        描述：最新发布
    -->
    <div class="index-title">
        <a href="">最新发布</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <!--

        描述：闲置数码
    -->
    <div class="index-title">
        <a href="">闲置数码</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <!--

        描述：校园代步
    -->
    <div class="index-title">
        <a href="">校园代步</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}" height="400px" width="400px"/>
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
    <div class="index-title">
        <a href="">电器日用</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <div class="index-title">
        <a href="">图书教材</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <div class="index-title">
        <a href="">美妆衣物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <div class="index-title">
        <a href="">运动棋牌</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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
    <div class="index-title">
        <a href="">票券小物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">//
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="http://localhost:8080/upload/${item.images[0].imgUrl}"/>
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