<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" uri="http://yanzhenwei.com/common/" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>

        .modal-header {
            text-align: center;
        }

        table td {
            text-align: center;
            border: 0px;
        }


    </style>
    <title>用户列表</title>
    <!-- 分页 -->
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
<div id="content" style="margin-right: 100px;margin-top: 40px;">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<%=basePath%>admin/indexs" title="主页"
               class="tip-bottom"><i class="icon-home"></i>主页</a> <a title="用户列表"
                                                                     class="tip-bottom">用户列表</a>
        </div>
    </div>
    <!--End-breadcrumbs-->

    <!-- Page table -->
    <div class="container" style="width: 100%;">
        <!-- &lt;!&ndash; Marketing Icons Section &ndash;&gt;-->

        <div class="col-lg-12">
            <h2 class="page-header"
                style="margin-top:10px;text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
                用户行为喜好展示</h2>
        </div>

        <!--搜索栏-->
        <form class="form-horizontal" id="myserchform" name="myform" action="<%=basePath%>admin/userLike"
              method="post">
            <div class="form-group">
                <div class="col-sm-8" style="text-align:center;">
                    <span>手机：</span>
                    <input type="number" placeholder="请输入正确的手机号~" name="phone" value="${searchuser.phone}"/>
                    <span>昵称：</span>
                    <input type="text" name="username" value="${searchuser.username}"/>
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-success btn-sm" type="submit">查找</button>
                </div>
            </div>
        </form>

        <!--表格显示-->
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>序号</th>
                <th>手机号</th>
                <th>昵称</th>
                <th>用户行为大数据分析结果</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.rows}" var="item" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${item.phone}</td>
                    <td>${item.username}</td>
                    <c:if test="${item.userlist.size()>2}">
                    <td>该用户偏爱<span
                            style="color: #00acc1">${item.userlist[0].catelogName}.${item.userlist[1].catelogName}</span>类物品
                        </c:if>
                        <c:if test="${item.userlist.size()<=2}">
                    <td>暂未分析出该用户喜好</td>
                    </c:if>
                    </td>
                   <%-- <td>
                        <button type="button" class="btn btn-primary btn-sm" onclick="doView(${item.id})">查看</button>
                    </td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!--分页条-->
        <div class="container">
            <div class="navbar-right" style="padding-right: 250px">
                <common:page url="${pageContext.request.contextPath}/admin/userLike"></common:page>
            </div>
        </div>


<!--==================================================================================================================-->
<jsp:include page="../main_bottom.jsp"></jsp:include>
<!-- 查看 模态框（Modal） -->
<%--<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">用户喜好详情</h4>
            </div>
            <div class="modal-body" style="height:400px; ">
                <div class="form-group">
                    <label class="col-sm-3 control-label" id="a0">闲置数码:</label>
                    <div class="col-sm-9">
                        <div class="progress">
                            <div class="progress-bar" id="a1" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;">
                                0%
                            </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">校园代步:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="my_username" name="username" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">电器日用:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="my_qq" name="qq" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">图书教材:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="my_createAt" name="createAt" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">美妆衣物:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="email" name="email" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">运动棋牌:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="email" name="email" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">票券小物:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="email" name="email" readonly
                               style="margin-top: 8px;"/>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>--%>
</body>

<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript" src="<%=basePath%>js/custom/base.js"></script>

<script type="text/javascript">
    //初始化时间
    $(".form_datetime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        todayHighlight: true,
        language: 'zh-CN',
        autoclose: true
    });

    /* 查看ajax */
    /*function doView(id) {
        $.ajax({
            url: 'admin/getUserLike',
            type: 'GET',
            data: {id: id},
            dataType: 'json',
            success: function (json) {
                if (json) {
                    $('#a0').html("闲置数码:"+json.userLikeById[0].number);
                    alert(json.userLikeById[0].number)
                    alert(json.userLikeById[0].baiFenBi)


                    /!*$('#myviewform').find("input[name='power']").val(json.power);
                    $('#myeditform').find("input[name='goodsNum']").val(json.goodsNum);
                    $('#myviewform').find("input[name='phone']").val(json.phone);
                    $('#myviewform').find("input[name='username']").val(json.username);
                    $('#myviewform').find("input[name='qq']").val(json.qq);
                    $('#myviewform').find("input[name='createAt']").val(json.createAt);
                    $('#myviewform').find("input[name='email']").val(json.email);*!/
                    $('#viewModal').modal('toggle');
                }
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });
    }*/
</script>

</html>
