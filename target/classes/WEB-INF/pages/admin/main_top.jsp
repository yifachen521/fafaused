<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
</head>
<link rel="stylesheet" href="<%=basePath%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="<%=basePath%>/css/matrix-style.css" />
<link rel="stylesheet" href="<%=basePath%>/css/matrix-media.css" />
<link rel="stylesheet" href="<%=basePath%>/font-awesome/css/font-awesome.css" />
<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/confirm.js"></script>

<body>
	<!--Header-part-->
	<div id="headers" >
		<%--float:letf;--%>
	   	<div style="height:50px;background-color:#323232;">
	    	<div style="float:left;background-color:#FFB53E;height:50px;width:220px;">
	   	        <a href="<%=basePath%>admin/indexs">
	   	        <p style="font-size:30px;text-align:center;">首页</p>
	   	        </a>
	   	    </div>
            <div class="dropdown" style="float: left;height: 50px">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="height: 50px;width: 100px;margin-left: 10px">
                    ${sessionScope.admin.userName}
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" style="width: 100px" aria-labelledby="dropdownMenu1">
                    <li><a href="<%=basePath%>admin/info" style="height: 30px">个人信息</a></li>
                    <li><a href="<%=basePath%>admin/modify" style="height: 30px">修改个人信息</a></li>
                    <li><a href="<%=basePath%>admin/">退出登录</a></li>

                </ul>
            </div>
	   	        <h1 style="text-align:center;margin-top: 10px;margin-bottom: 0px;">发发闲置管理系统</h1>
	   	</div>


	</div>
	<!--close-Header-part-->
	<!--top-Header-menu-->

	<!-- 实现左边动画 -->
	<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
	<script src="<%=basePath%>js/matrix.js"/>
	<!-- 实现上边动画 -->
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>




</body>
</html>
