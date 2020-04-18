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
<jsp:include page="../main_top.jsp"></jsp:include>
<jsp:include page="../main_left.jsp"></jsp:include>
<!--=============================================================================================================================================================================-->
<!--main-container-part-->
<div id="content" style="margin-right: 100px; margin-top: 40px;">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<%=basePath%>admin/indexs" title="主页" class="tip-bottom"><i
                    class="icon-home"></i>主页</a> <a title="订单列表" class="tip-bottom">订单列表</a>
        </div>
    </div>
    <!--End-breadcrumbs-->
    <!-- Page table -->
    <div class="container" style="width: 100%;">
        <div class="col-lg-12">
            <h2 class="page-header"
                style="margin-top: 10px; text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
                订单列表显示</h2>
        </div>

        <!--搜索栏-->
        <form class="form-horizontal" id="myserchform" name="myform"
              action="<%=basePath%>admin/searchOrders" method="post">
            <div class="form-group">
                <div class="col-sm-8" style="text-align: center;">
                    <span>商品订单编号：</span>
                    <input type="text" name="orderId" value="${searchorders.orderId}" placeholder="编号必须正确哦~"/>
                    <span>状态：</span>
                    <select name="status" id="myselected">
                        <c:if test="${searchorders.status=='' or searchorders.status==null}">
                            <option value="" selected>请选择订单状态</option>
                            <option value="1" >待确认单</option>
                            <option value="0">交易成功</option>
                            <option value="2">交易失败</option>
                        </c:if>
                        <c:if test="${searchorders.status==1}">
                            <option value="1" selected>待确认单</option>
                            <option value="" >请选择订单状态</option>
                            <option value="0">交易成功</option>
                            <option value="2">交易失败</option>
                        </c:if>

                        <c:if test="${searchorders.status==2}">
                            <option value="2" selected>交易失败</option>
                            <option value="">请选择订单状态</option>
                            <option value="1">待确认单</option>
                            <option value="0">交易成功</option>
                        </c:if>
                        <c:if test="${searchorders.status==0}">
                            <option value="0" selected>交易成功</option>
                            <option value="">请选择订单状态</option>
                            <option value="1">待确认单</option>
                            <option value="2">交易失败</option>
                        </c:if>

                    </select>
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-success btn-sm" type="submit">查找</button>
                    <button class="btn btn-danger btn-sm" type="button"
                            id="deleteOrdersButton">删除
                    </button>
                </div>
            </div>
        </form>

        <!--表格显示-->
        <table class="table table-bordered">
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAllButton"></th>
                <th>序号</th>
                <th>订单号</th>
                <th>卖家</th>
                <th>买家</th>
                <th>商品名称</th>
                <th>成交价</th>
                <th>商品类别</th>
                <th>订单状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.rows}" var="item" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="itemIds" value="${item.orderId}"></td>
                    <td>${s.count}</td>
                    <td>${item.orderId}</td>
                    <td>${item.sellerName}</td>
                    <td>${item.buyerName}</td>
                    <td>${item.goodsName}</td>
                    <td>${item.goodsPrice}</td>
                    <td>${item.cateLog}</td>
                    <td>
                        <c:if test="${item.status == 1}">
                            🔵<span style="color: limegreen">卖家未处理</span>
                        </c:if>
                        <c:if test="${item.status == 0}">
                            ✔<span style="color: red">已完成订单</span>
                        </c:if>
                        <c:if test="${item.status == 2}">
                            ⚫<span style="color: #a8a8a8">失效订单</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!--分页条-->
        <div class="container">
            <div class="navbar-right" style="padding-right: 250px">
               <common:page url="${pageContext.request.contextPath}/admin/searchOrders"></common:page>
            </div>
        </div>
<!--==================================================================================================================-->
<jsp:include page="../main_bottom.jsp"></jsp:include>
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

<script type="text/javascript">
    //初始化时间
    $(".form_datetime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii:ss',
        todayHighlight: true,
        language: 'zh-CN',
        autoclose: true
    });


    //根据值 动态选中
    $("#myselected option[value='${searchorders.status}']").attr("selected", "selected");


</script>

</html>
