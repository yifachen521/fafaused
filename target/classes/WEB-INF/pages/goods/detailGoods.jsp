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
    <link rel="stylesheet" href="<%=basePath%>css/detail.css"/>

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
    描述：注册
-->
<jsp:include page="main-info.jsp"></jsp:include>
<!--显示商品详情-->
<div ng-controller="detailBoxController" class="detail-box stark-components z-depth-1 row ng-scope">
    <div class="col s12 path">
        <a href="<%=basePath%>goods/catelog/${catelog.id}">${catelog.name}</a>
        <em>></em>
        <a>${goodsExtend.goods.name}</a>
    </div>
    <div class="col s6">
        <div class="slider" style="height: 440px;">
            <ul class="slides" style="height: 400px;">
                <img src="http://localhost:8080/upload/${goodsExtend.images[0].imgUrl}" width="400px" height="400px"/>
            </ul>
            <ul class="indicators">
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
            </ul>
        </div>
    </div>
    <div class="col s6">
        <h1 class="item-name">${goodsExtend.goods.name}</h1>
        <h2 class="item-price">${goodsExtend.goods.price}</h2>
        <h2 class="publisher-info-title">原价：<span
                style="text-decoration:line-through;">${goodsExtend.goods.realPrice}</span></h2>
        <div class="item-public-info">
            <p class="bargain">可讲价</p>
            <p>
                <i class="iconfont"></i>
                <em class="item-location">黄淮学院</em>
            </p>
        </div>
        <div class="publisher-info-title">
            <em>卖家信息</em>
            <hr>
        </div>
        <c:if test="${empty cur_user}">
            <div class="item-contact">
                <p class="not-login">
                    <a onclick="showLogin()">登录</a>
                    <em>或</em>
                    <a onclick="showSignup()">注册</a>
                    <em>后查看联系信息</em>
                </p>
            </div>
        </c:if>
        <c:if test="${!empty cur_user}">
            <div class="item-contact">
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.username}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.phone}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <c:if test="${seller.qq!=null}">
                        <div class="value">${seller.qq}</div>
                    </c:if>
                    <c:if test="${seller.qq==null}">
                        <div class="value">该同学没留下QQ</div>
                    </c:if>

                </div>
                <div>

                    <input type="button" value="加入收藏" class="blue lighten-1 waves-effect waves-light btn"
                           onclick="addFocus(${goodsExtend.goods.id})">
                    <input type="button" value="联系卖家" class="blue lighten-1 waves-effect waves-light btn"
                           onclick="">
                    <input type="button" value="带我回家" class="blue lighten-1 waves-effect waves-light btn"
                           onclick="orderDetail(${goodsExtend.goods.id})">  <%--id="btn_cart"--%>
                    &nbsp;&nbsp;<span style="font-size: 12px"><strong>${goodsExtend.goods.heatnum}</strong>人想要</span>

                </div>

            </div>
        </c:if>
        <h1 class="item-pub-time">发布于 ${goodsExtend.goods.startTime}</h1>
    </div>
</div>
<div class="detail-box stark-components z-depth-1 row">
    <h1 class="title">商品描述</h1>
    <hr class="hr1"/>
    <hr class="hr2"/>
    <p class="section">描述：${goodsExtend.goods.describle}</p>
    <p class="section"></p>
    <p class="section">
        ps:联系我的时候，请说明是在“发发闲置”上看见的哦~
    </p>
</div>
<div class="row detail-area">
    <div class="clo s12">
        <div ng-controller="commentController" class="comment stark-components z-depth-1 ng-scope">
            <h1 class="title">评论</h1>
            <hr class="hr1"/>
            <hr class="hr2"/>
            <c:forEach var="item" items="${CommentExtend.comments}">
                <div class="comment-collection">
                    <div class="comment-item ng-scope">
                        <div class="comment-main-content">
                            <em class="name ng-binding">${item.user.username}:</em>
                            <em class="ng-hide">回复</em>
                            <em class="name ng-binding ng-hide">@:</em>
                            <em class="ng-binding">${item.content}</em>
                        </div>
                        <div class="comment-function">
                            <em class="time ng-biinding">${item.createAt}</em>

                            <!--  <a class="reply-or-delete">删除</a>
                             <a class="reply-or-delete">回复</a> -->
                        </div>
                    </div>
                </div>
            </c:forEach>
            <form id="addCommentForm" class="form-horizontal">
                <div class="comment-add row">
                    <div class="input-field col s12">
                        <i class="iconfont prefix"></i>
                        <input id="goodsId" name="goods.id" value="${goodsExtend.goods.id}" type="hidden"/>
                        <input id="commentbox" type="text" name="content"
                               class="validate ng-pristine ng-untouched ng-valid ng-empty"/>
                        <label for="commentbox">这里写下评论</label>
                        <c:if test="${!empty cur_user}">
                            <button type="button" class="waves-effect wave-light btn comment-submit"
                                    onclick="addComments()">确认
                            </button>
                        </c:if>
                        <%--   <c:if test="${!empty cur_user} && ${cur_user.id!=goodsExtend.comments.userId}">
                         <button type="submit" class="waves-effect wave-light btn comment-submit">确认</button>
                         </c:if>
                          <c:if test="${!empty cur_user} && ${cur_user.id==goodsExtend.comments.userId}">
                         <button data-toggle="tooltip"  title="您已经评论过了哦！" disabled="disabled"  class="waves-effect wave-light btn comment-submit">确认</button>
                         </c:if> --%>
                        <c:if test="${empty cur_user}">
                            <button href="javacript:void(0);" data-toggle="tooltip" title="您需要先登录哦！" disabled="disabled"
                                    class="waves-effect wave-light btn comment-submit">确认
                            </button>
                        </c:if>

                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    /* 评论 */
    function addComments() {
        $.ajax({
            url: '<%=basePath%>goods/addComments',
            type: 'POST',
            data: $('#addCommentForm').serialize(),// 序列化表单值
            dataType: 'json',
            /* 	success:function(json){
                    alert(1)
                    alert(json.msg)
                },
                error:function(){
                    alert('请求超时或系统出错!');
                } */
        });
        alert("您已评论成功~")
        window.location.reload();
    }

    //orderDetail
    function orderDetail(data) {
        window.location.href="<%=basePath%>order/orderDetail/"+data;
    }



    //加入收藏的
    function addFocus(goodsId) {
        //获取当前的商品的id 传后台和当前用户的id绑定添加到数据库中
        $.ajax({
            url:'<%=basePath%>user/addFocus',
            data:{goodsId:goodsId},
            type: 'POST',
            dataType: 'json',
            success:function(json){
                if (json.info == "success") {
                    alert("收藏成功");
                }if (json.info == "msg") {
                    alert("您已经收藏过该商品了哦");
                }
            },
            error:function(){
                alert('请求超时或系统出错!');
            }
        })
    }
</script>
</html>