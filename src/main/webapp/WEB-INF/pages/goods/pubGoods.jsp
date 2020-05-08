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
    <title>发布商品</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
   <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <!-- 图片上传即使预览插件 -->
    <link rel="stylesheet" href="<%=basePath%>css/fileinput.min.css">
    <script type="text/javascript" src="<%=basePath%>js/fileinput.min.js"></script>
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
            <a href="<%=basePath%>user/home">
                 <img src="<%=basePath%>img/home_header.png"  style="margin-left: 20px;" >
            </a>
            <a href="<%=basePath%>user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--

         描述：左侧个人中心栏
     -->
        <jsp:include page="../user/main-left.jsp"/>
        <!--

	            描述：发布物品
        -->
        <div id="user_content">
            <div class="basic">
                <form:form action="../goods/publishGoodsSubmit" method="post" role="form" enctype="multipart/form-data">
                    <h1 style="margin-left: 210px;">发布物品</h1><hr/>
                    <div class="changeinfo">
                        <span>物品名：</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input class="in_info" id="goodsName" type="text" name="name" placeholder="请输入物品名"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span>出售价格：</span>
                        <input class="in_info" id="goodsPrice" type="text" name="price" placeholder="请输入出售价格"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span>原价：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input class="in_info" type="text" name="realPrice" placeholder="请输入商品原价"/>
                        <span id="checkphone">(*选填,请如实填写)</span>
                    </div>
                    <div class="changeinfo">
                        <span>物品类别：</span>
                        <select class="in_info" name="catelogId">
                            <option value="1">闲置数码</option>
                            <option value="2">校园代步</option>
                            <option value="3">电器日用</option>
                            <option value="4">图书教材</option>
                            <option value="5">美妆衣物</option>
                            <option value="6">运动棋牌</option>
                            <option value="7">票券小物</option>
                        </select>
                    </div>
                    <div class="changeinfo" id="dir">
                        <span>商品描述：</span>
                        <br>
                     <div class="sha">
                            <div class="publ">
                                <div class="pub_con">
                                    <div class="text_pu">
                                        <input type="text" name="describle" class="emoji-wysiwyg-editor"/>
                                    </div>
                                </div>
                            </div>
                     </div>
                    </div>
                    <br />
                    <hr />
                    <div class="changeinfo">
                        <span>商品图片：</span>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <%--<input type="file" name="myfile" data-ref="imgUrl" class="col-sm-10 myfile" value=""/>--%>
                                                <input type="file" name="imgPath" id="fileimg"
                                                       onchange="change(this)" accept="image/*">
                                                <img src="<%=basePath%>img/uplodeimg.jpg" alt="..."
                                                     id="imgs" class="img-thumbnail" height="130px" width="130px">
                                                <input type="hidden" name="imgUrl" value="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="submit" onclick="return pubGoods()" class="setting-save" value="发布物品" style="margin-top: 20px;background-color: blue;"/>
                </form:form>
            </div>
        </div>
    </div>
</div>

<script>
    var img_change=false;

    //判断用户填写的商品信息  信息不全不予发布
    function pubGoods() {
        var goodsName=$("#goodsName").val();
        var goodsPrice=$("#goodsPrice").val();
        if (goodsName!="" && goodsPrice!=""){
            if (img_change){
                return true
            }else {
                alert("选择图片描述哦亲")
                return false;
            }
        } else {
            alert("必填项不要漏唷")
            return false;
        }
    }

    function change(obj) {
        var reader = new FileReader();	// 实例化一个FileReader对象，用于读取文件
        var img = document.getElementById("imgs");
        //读取File对象的数据
        reader.onload = function(evt){
            img.src = evt.target.result;
            //修改状态
            img_change=true;
        }
        reader.readAsDataURL(obj.files[0]);
    }
</script>
</body>
</html>