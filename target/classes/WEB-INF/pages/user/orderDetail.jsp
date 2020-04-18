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
    <meta charset="UTF-8">
    <title>订单确认</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/zh.js"></script>

    <style>
        .container{padding-top:10px}
    </style>
</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="/user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--

         描述：左侧个人中心栏
     -->
        <jsp:include page="main-left.jsp"/>
        <!--

	            描述：订单确认
        -->
        <div id="user_content">
            <div class="basic">
                <form:form action="../../order/orderSubmit" method="post" role="form" enctype="multipart/form-data">
                    <h1 style="margin-left: 210px;">订单信息</h1><hr />
                    <div class="changeinfo">
                        <span>卖家：</span>
                        <span>${sellUser.username}</span>
                    </div>
                    <div class="changeinfo">
                        <span>物品名：</span>
                        <span>${goodsExtend.goods.name}</span>
                    </div>
                    <div class="changeinfo">
                        <span>出售价格：</span>
                       <span>${goodsExtend.goods.price}</span>
                   </div>
                     <div class="changeinfo">
                        <span>物品类别：</span>
                         <c:if test="${goodsExtend.goods.catelogId==1}"><span>闲置数码</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==2}"><span>校园代步</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==3}"><span>电器日用</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==4}"><span>图书教材</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==5}"><span>美妆衣物</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==6}"><span>运动棋牌</span></c:if>
                         <c:if test="${goodsExtend.goods.catelogId==7}"><span>票券小物</span></c:if>
                    </div>
                    <br />
                    <hr />
                    <div class="changeinfo">
                        <span>图片：</span>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <img src="http://localhost:8080/upload/${goodsExtend.images[0].imgUrl}" id="imgs" style="width:100px;higth:100px;"/>
                                            <input type="hidden" name="goodsId" value="${goodsExtend.goods.id}">
                                            <input type="hidden" name="sellerId" value="${goodsExtend.goods.userId}">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="changeinfo" id="dir">
                        <span>买家留言：</span>
                        <div class="sha">
                            <div class="publ">
                                <div class="pub_con">
                                    <div class="text_pu">
                                        <input type="text" name="comment"  class="emoji-wysiwyg-editor"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <input type="submit" class="setting-save" value="确认订单" style="margin-top: 20px;background-color: blue;"/>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script>

</script>
</body>
</html>