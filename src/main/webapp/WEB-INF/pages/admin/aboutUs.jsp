<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" uri="http://yanzhenwei.com/common/" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <style>
        .modal-header {
            text-align: center;
        }

        table td {
            text-align: center;
            border: 0px;
        }
    </style>
    <title>订单列表</title>
    <!-- 分页 -->
    <%--<link href="<%=basePath%>css/mypage.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"
          rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/confirm.js"></script>


</head>

<body>
<jsp:include page="main_top.jsp"></jsp:include>
<jsp:include page="main_left.jsp"></jsp:include>
<!--=============================================================================================================================================================================-->
<!--main-container-part-->
<div id="content" style="margin-right: 100px; margin-top: 40px;">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<%=basePath%>admin/indexs" title="主页" class="tip-bottom"><i
                    class="icon-home"></i>主页</a> <a title="关于我们" class="tip-bottom">关于我们</a>
        </div>
    </div>
    <!--End-breadcrumbs-->
    <!-- Page table -->
    <div class="container" style="width: 100%;">
        <div class="col-lg-12">
            <h2 class="page-header"
                style="margin-top: 10px; text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
                关于我们</h2>
        </div>
        <center>
        <div style="text-align: center;width: 50%">
            <div style="text-align: left;font-size: 15px">
                <p>Hello：</p>
                <p>欢迎来到发发闲置的校园二手信息平台。临近毕业季的</p>
                <p >你，是否有太多的闲置与校友分享，为了追求更好的校园服</p>
                <p >务，我们打造了一个全新的校园平台——<span>发发闲置</span></p>
                <p >这里有更多的闲置分享，更自由的校园话题讨论，你想要的，都在这里。</p>
                <p >加入我们，你的大学，应更精彩。</p>
            </div>
        </div>
        </center>

<!--==================================================================================================================-->
<jsp:include page="main_bottom.jsp"></jsp:include>
</body>

<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript"
        src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
        src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript" src="<%=basePath%>js/custom/base.js"></script>



</html>
