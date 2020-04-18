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
    <title>我的闲置</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css"/>
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
            <div class="share">
                <!--

                    描述：闲置商品展示
                -->
                <h1 style="text-align: center">我的闲置</h1>
                <hr/>
                <div class="share_content">
                    <c:if test="${empty goodsAndImage}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${!empty goodsAndImage}">
                        <c:forEach var="items" items="${goodsAndImage}" varStatus="s">
                            <div>
                                <span style="font-size: 20px">${s.count}.</span>
                                <div class="story">
                                    <a href="<%=basePath%>goods/goodsId/${items.goods.id}" class="head_img">
                                        <img src="http://localhost:8080/upload/${items.images[0].imgUrl}" width="60px" height="60px">
                                    </a>
                                    <span class="name">${items.goods.name}</span>
                                    <span class="text"
                                          style="overflow: hidden; outline: none;">${items.goods.describle}</span>
                                    <div class="box">
                                        <div class="box_content">
                                            <div class="left_shadow"></div>
                                            <div class="left" index="1" style="display: none;"><</div>
                                            <div class="right_shadow"></div>
                                            <div class="left" index="3" style="display: none;">></div>
                                            <img src="http://localhost:8080/upload/${items.images[0].imgUrl}" width="445px" height="445px" index="2">
                                            <span class="com" style="display: none;left: 396.733px;"></span>
                                        </div>
                                        <div class="interact">
                                            <span class="fa fa-edit fa-lg">&nbsp;&nbsp;<a
                                                    href="<%=basePath%>goods/editGoods/${items.goods.id}">编辑</a></span>&nbsp;&nbsp;&nbsp;
                                            <span class="fa fa-trash fa-lg">&nbsp;&nbsp;<a
                                                    href="<%=basePath%>goods/deleteGoods/${items.goods.id}">删除</a></span>&nbsp;&nbsp;&nbsp;
                                            <span class="fa fa-smile-o fa-lg">&nbsp;&nbsp;<a
                                                    href="<%=basePath%>goods/goodsId/${items.goods.id}">详细信息</a></span>&nbsp;&nbsp;&nbsp;
                                            <span class="fa fa-fire fa-lg">&nbsp;&nbsp;<a
                                                    href="#">(${items.goods.heatnum})人想要</a></span>
                                        </div>
                                        <br>
                                        <div class="like_detail">
                                            <div class="like_content">
                                                <span>上架时间：${items.goods.startTime}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>