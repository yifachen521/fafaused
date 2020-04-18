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
    <title>个人中心</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.min.js"></script>
    <script type="text/javascript">

        function viewPersonal(id) {
            $.ajax({
                url: '<%=basePath%>admin/getUser',
                type: 'GET',
                data: {id: id},
                dataType: 'json',
                success: function (json) {
                    if (json) {
                        $('#myviewform').find("input[name='phone']").val(json.phone);
                        $('#myviewform').find("input[name='username']").val(json.username);
                        $('#myviewform').find("input[name='qq']").val(json.qq);
                        $('#myviewform').find("input[name='power']").val(json.power);
                        $('#myviewform').find("input[name='createAt']").val(json.createAt);
                        $('#viewModal').modal('toggle');
                    }
                },
                error: function () {
                    alert('请求超时或系统出错!');
                    $('#viewModal').modal('hide');
                }
            });
        }

        function sendContext() {
            var context = $("#mycontext").text();
            $.ajax({
                url: '<%=basePath%>user/insertSelective',
                type: 'POST',
                data: {context: context},
                dataType: 'json',
                success: function (json) {
                    alert(json.msg);
                    location.reload();
                },
                error: function () {
                    alert('请求超时或系统出错!');
                }
            });

        }

        $(function () {
            var options = {
                bootstrapMajorVersion: 1,    //版本
                currentPage: 1,    //当前页数
                numberOfPages: 5,    //最多显示Page页
                totalPages: 10,    //所有数据可以显示的页数
                onPageClicked: function (e, originalEvent, type, page) {
                    console.log("e");
                    console.log(e);
                    console.log("originalEvent");
                    console.log(originalEvent);
                    console.log("type");
                    console.log(type);
                    console.log("page");
                    console.log(page);
                }
            }
            $("#page").bootstrapPaginator(options);
        })
    </script>
    <style>
        th {
            text-align: center;
        }
    </style>
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
                <img src="../img/home_header.png" style="margin-left: 20px;">
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
                <span style="font-size: 35px;color: #0bb9f8;text-align: center">
                       订单详情
                    </span>
                <a href="<%=basePath%>order/orderList">待确认订单</a>
                <a href="<%=basePath%>order/lostOrderList">已完成订单</a>
                <!--

                    描述：订单展示
                -->
                <form id="myform"
                      action="#">
                    <!--以下显示表格-->
                    <div class="container" style="margin-top: 20px;text-align: center;width: 700px">

                        <table style="text-align: center; margin-right: 10px; width: 99%"
                               class="table table-striped table-hover table-bordered">
                            <thead style="text-align: center;">
                            <tr>
                                <th>序号</th>
                                <th>商品</th>
                                <th>商品价格</th>
                                <th>图片</th>
                                <th>买家信息</th>
                                <th>买家备注</th>
                                <c:if test="${lostOrder=='0'}">
                                    <th>订单完成时间</th>
                                </c:if>
                                <th>订单状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${Order}" var="orders" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${orders.goodsName}</td>
                                    <td>${orders.goodsPrice}</td>
                                    <td><img src="http://localhost:8080/upload/${orders.image}" alt="haha"
                                             class="img-rounded"
                                             height="50px" width="50px"/></td>

                                    <td>${orders.buyerName}</td>
                                    <td>${orders.buyerComment}</td>
                                    <input type="hidden" id="goodsId" value="${orders.goodsId}">
                                    <c:if test="${lostOrder=='0'}">
                                        <td>${orders.orderTime}</td>
                                    </c:if>
                                    <td>
                                        <c:if test="${orders.status==1}">
                                            <button type="button" id="sureBut" class="btn btn-info"
                                                    onclick="sureSell('${orders.goodsId}','${orders.buyerId}')">确定卖出
                                            </button>
                                        </c:if>
                                        <c:if test="${orders.status==0}">
                                            <button type="button" class="btn btn-info"
                                                    disabled><span
                                                    style="color: #5bb75b">已售出</span>
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<script>

    //确定卖出订单里的商品的ajax
    function sureSell(goodsId, buyerId) {
        $.ajax({
            url: '<%=basePath%>order/sureSell',
            data: {goodsId: goodsId, buyerId: buyerId},
            type: 'POST',
            dataType: 'json',
            success: function (json) {
                if (json.info == "success") {
                    window.location.reload();
                    alert("恭喜您完成一笔交易")
                }

            },
            error: function () {
                alert("系统出现问题，不要慌");
            }
        })
    }
</script>
</body>
</html>