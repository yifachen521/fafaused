
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!--

描述：左侧个人中心栏
-->
<div id="user_nav">
    <div class="user_info">
        <%-- <div class="head_img">
             <img src="../img/p_logo.jpg">
         </div>--%>
        <%--可设置头像--%>
        <%--<div class="big_headimg">
            <img src="../img/photo1.jpg">
        </div>--%>
        <table style="margin: 40px 0px 40px 20px;font-size: 13px;">
            <tr>
                <td>昵称:</td>
                <td>${cur_user.username}</td>
            </tr>
            <tr>
                <td>Tel:</td>
                <td>${cur_user.phone}</td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>${cur_user.email}</td>
            </tr>
        </table>

        <hr>
    </div>
    <div class="home_nav">
        <ul>
            <a href="<%=basePath%>order/orderList">
                <li class="notice">
                    <div></div>
                    <span>待售订单</span>
                    <strong></strong>
                </li>
            </a>
            <a href="<%=basePath%>user/allFocus">
                <li class="fri">
                    <div></div>
                    <span>关注列表</span>
                    <strong></strong>
                </li>
            </a>
            <a href="<%=basePath%>goods/publishGoods">
                <li class="store">
                    <div></div>
                    <span>发布物品</span>
                    <strong></strong>
                </li>
            </a>
            <a href="<%=basePath%>user/allGoods">
                <li class="second">
                    <div></div>
                    <span>我的闲置</span>
                    <strong></strong>
                </li>
            </a>
            <a href="<%=basePath%>user/basic">
                <li class="set">
                    <div></div>
                    <span>个人设置</span>
                    <strong></strong>
                </li>
            </a>
            <a href="<%=basePath%>order/buyerOrderList">
                <li class="store">
                    <div></div>
                    <span>购物小车</span>
                    <strong></strong>
                </li>
            </a>
        </ul>
    </div>
</div>
</body>
</html>
