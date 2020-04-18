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
    <title>我的关注</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>

    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>
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
            <a href="<%=basePath%>goods/homeGoodse">
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
                    描述：关注商品展示
                -->
                <h1 style="text-align: center">关注列表</h1>

                <hr/>
                <div class="share_content">
                    <c:if test="${empty goodsAndImage}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${!empty goodsAndImage}">
                        <div>
                            <span>在售：${on_sale_count}件</span>
                            <span>失效：${sold_out_count}件</span>
                            <button type="button" class="btn btn-info" onclick="delAllSoldOut()">一键清理所有下架</button>
                        </div>
                        <c:forEach var="items" items="${goodsAndImage}" varStatus="s">
                            <div>
                                <span style="font-size: 20px">${s.count}.</span>

                                <c:if test="${items.goods.status==1}">
                                    <div class="story">
                                        <a href="<%=basePath%>goods/goodsId/${items.goods.id}" class="head_img">
                                            <img src="http://localhost:8080/upload/${items.images[0].imgUrl}"
                                                 width="60px" height="60px">
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
                                                <img src="http://localhost:8080/upload/${items.images[0].imgUrl}"
                                                     width="445px" height="445px" index="2">
                                                <span class="com" style="display: none;left: 396.733px;"></span>
                                            </div>
                                            <div class="interact">
                                            <span class="fa fa-heart-o fa-lg"><a
                                                    href="<%=basePath%>user/deleteFocus/${items.goods.id}">&nbsp;&nbsp;取消关注</a></span>&nbsp;&nbsp;&nbsp;


                                                <span class="fa fa-mobile fa-lg"  onclick="showLogin('${items.goods.name}','${items.goods.userId}')">&nbsp;&nbsp;联系卖家</span>&nbsp;&nbsp;&nbsp;


                                                <span class="fa fa-smile-o fa-lg"><a
                                                        href="<%=basePath%>goods/goodsId/${items.goods.id}">&nbsp;&nbsp;详细信息</a></span>&nbsp;&nbsp;&nbsp;
                                                <span class="fa fa-fire fa-lg"><a
                                                        href="#">&nbsp;&nbsp;热度(${items.goods.heatnum})</a></span>
                                            </div>
                                            <br>
                                            <div class="like_detail">
                                                <div class="like_content">
                                                    <span>上架时间：${items.goods.startTime}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <c:if test="${items.goods.status==0}">
                                                        <span>目前状态:<strong style="color: #aaaaaa">已下架</strong></span>
                                                    </c:if>
                                                    <c:if test="${items.goods.status==1}">
                                                        <span>目前状态:<strong style="color: #5bb75b">在售</strong></span>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--
                                    描述：买家留言
                                    -->
                                    <div ng-controller="loginController" class="ng-scope">
                                        <div id="login-show" class="login stark-components">
                                            <div class="publish-box z-depth-4" style="width: 500px;height: 330px">
                                                <div class="row" style="width: 480px;margin-left: 10px;">
                                                    <a onclick="showLogin(null,null)">
                                                        <span style="font-size: 20px;color: #aaa;width: 500px"><center>给买家留言:</center></span>
                                                    </a>
                                                    <form action="<%=basePath%>notice/addBuyerMessage" method="post">
                                                        <%--商品 名称--%>
                                                        <input type="hidden" name="sellId" id="sellId" value="">
                                                        <input type="hidden" name="goodsName" id="goodsName" value="">

                                                        <textarea style="width:450px;margin: 40px 0px 0px 15px" placeholder="写下你想对卖家说的话......" name="context"  cols="30" rows="10"></textarea>
                                                        <center>
                                                        <input type="submit" class="btn" value="发送消息">
                                                        <input type="button" onclick="showLogin(null,null)" class="btn" value="取消发送">
                                                        </center>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </c:if>
                                    <%--下架--%>
                                <c:if test="${items.goods.status==0}">
                                    <div class="story" style="background: #DCDCDC">
                                        <a href="<%=basePath%>goods/goodsId/${items.goods.id}" class="head_img">
                                            <img src="http://localhost:8080/upload/${items.images[0].imgUrl}"
                                                 width="60px" height="60px">
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
                                                <img src="http://localhost:8080/upload/${items.images[0].imgUrl}"
                                                     width="445px" height="445px" index="2">
                                                <span class="com" style="display: none;left: 396.733px;"></span>
                                            </div>
                                            <div class="interact">
                                                <span class="fa fa-heart-o fa-lg"><a
                                                    href="<%=basePath%>user/deleteFocus/${items.goods.id}">&nbsp;&nbsp;取消关注</a></span>&nbsp;&nbsp;&nbsp;

                                                <span class="fa fa-mobile fa-lg"  >&nbsp;&nbsp;联系卖家</span>&nbsp;&nbsp;&nbsp;


                                                <span class="fa fa-smile-o fa-lg"><a
                                                        href="<%=basePath%>goods/goodsId/${items.goods.id}"
                                                        disabled="true">&nbsp;&nbsp;详细信息</a></span>&nbsp;&nbsp;&nbsp;
                                                <span class="fa fa-fire fa-lg">
                                                        &nbsp;&nbsp;热度&nbsp;0</span>
                                            </div>
                                            <br>
                                            <div class="like_detail">
                                                <div class="like_content" style="background-color: #DCDCDC">
                                                    <span>上架时间：${items.goods.startTime}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <c:if test="${items.goods.status==0}">
                                                        <span>目前状态:<strong style="color: #aaaaaa">已下架</strong></span>
                                                    </c:if>
                                                    <c:if test="${items.goods.status==1}">
                                                        <span>目前状态:<strong style="color: #5bb75b">在售</strong></span>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                            </div>
                        </c:forEach>
                    </c:if>
                </div>




            </div>

        </div>


    </div>
</div>
<script>
    //一键清理失效商品
    function delAllSoldOut() {
        window.location.href = "<%=basePath%>user/deleteFocus/-1";
    }


    function showLogin(name,id) {
        if ($("#login-show").css("display") == 'none') {
            $("#login-show").css("display", "block");
            $("#sellId").val(id);
            $("#goodsName").val(name);
        } else {
            $("#login-show").css("display", "none");
        }
    }

</script>
</body>
</html>