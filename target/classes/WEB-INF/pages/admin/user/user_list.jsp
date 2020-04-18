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
                用户列表显示</h2>
        </div>

        <!--搜索栏-->
        <form class="form-horizontal" id="myserchform" name="myform" action="<%=basePath%>admin/searchUser"
              method="post">
            <div class="form-group">
                <div class="col-sm-8" style="text-align:center;">
                    <span>手机：</span>
                    <input type="number" placeholder="请输入正确的手机号~" name="phone" value="${searchuser.phone}"/>
                    <span>昵称：</span>
                    <input type="text" name="username" value="${searchuser.username}"/>
                    <span>QQ：</span>
                    <input type="text" name="qq" value="${searchuser.qq}"/>
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-success btn-sm" type="submit">查找</button>
                    <button class="btn btn-danger btn-sm" type="button" id="deleteUserButton">删除</button>
                </div>
            </div>
        </form>

        <!--表格显示-->
        <table class="table table-bordered">
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAllButton"></th>
                <th>序号</th>
                <th>手机号</th>
                <th>昵称</th>
                <th>QQ</th>
                <th>创建时间</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.rows}" var="item" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="itemIds" value="${item.id}"></td>
                    <td>${s.count}</td>
                    <td>${item.phone}</td>
                    <td>${item.username}</td>
                    <td>${item.qq}</td>
                    <td>${item.createAt}</td>
                    <td>${item.email}</td>
                    <td>
                        <button type="button" class="btn btn-primary btn-sm" onclick="doView(${item.id})">查看</button>
                        <button type="button" class="btn btn-info btn-sm" onclick="doEdit(${item.id})">修改</button>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!--分页条-->
        <div class="container">
            <div class="navbar-right" style="padding-right: 250px">
                <common:page url="${pageContext.request.contextPath}/admin/searchUser"></common:page>
            </div>
        </div>


<!--==================================================================================================================-->
<jsp:include page="../main_bottom.jsp"></jsp:include>

<!--修改  模态框（Modal） -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
            </div>
            <div class="modal-body" style="height:300px; ">
                <form class="form-horizontal" id="myeditform" name="myform">
                    <input type="hidden" id="id" name="id" value=""/>
                    <%--<input type="hidden" id="power" name="power" value=""/>
                    <input type="hidden" id="goodsNum" name="goodsNum" value=""/>--%>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">手机号:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_phone" name="phone"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">昵称:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_username" name="username"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">QQ:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_qq" name="qq" style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">创建时间:</label>
                        <div class="col-sm-8">
                            <input type="text" id="datetimepicker" name="createAt" class="form-control form_datetime"  readonly="readonly"
                                   style="margin-top: 8px;">
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">email:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="email" name="email"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="doSave()">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 查看 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">查看用户信息</h4>
            </div>
            <div class="modal-body" style="height:300px; ">
                <form class="form-horizontal" id="myviewform" name="myform">
                    <input type="hidden" id="id" name="id" value=""/>
                    <input type="hidden" id="power" name="power" value=""/>
                    <input type="hidden" id="goodsNum" name="goodsNum" value=""/>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">手机号:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_phone" name="phone" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">昵称:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_username" name="username" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">QQ:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_qq" name="qq" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">创建时间:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_createAt" name="createAt" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">email:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="email" name="email" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
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
    function doView(id) {
        $.ajax({
            url: '<%=basePath%>admin/getUser',
            type: 'GET',
            data: {id: id},
            dataType: 'json',
            success: function (json) {
                if (json) {
                    $('#myviewform').find("input[name='id']").val(json.id);
                    $('#myviewform').find("input[name='power']").val(json.power);
                    $('#myeditform').find("input[name='goodsNum']").val(json.goodsNum);
                    $('#myviewform').find("input[name='phone']").val(json.phone);
                    $('#myviewform').find("input[name='username']").val(json.username);
                    $('#myviewform').find("input[name='qq']").val(json.qq);
                    $('#myviewform').find("input[name='createAt']").val(json.createAt);
                    $('#myviewform').find("input[name='email']").val(json.email);
                    $('#viewModal').modal('toggle');
                }
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });
    }

    /* 修改之展示数据 */
    function doEdit(id) {
        $.ajax({
            url: '<%=basePath%>admin/getUser',
            type: 'GET',
            data: {id: id},
            dataType: 'json',
            success: function (json) {
                if (json) {
                    $('#myeditform').find("input[name='id']").val(json.id);
                    $('#myeditform').find("input[name='goodsNum']").val(json.goodsNum);
                    $('#myeditform').find("input[name='power']").val(json.power);
                    $('#myeditform').find("input[name='phone']").val(json.phone);
                    $('#myeditform').find("input[name='username']").val(json.username);
                    $('#myeditform').find("input[name='qq']").val(json.qq);
                    $('#myeditform').find("input[name='createAt']").val(json.createAt);
                    $('#myeditform').find("input[name='email']").val(json.email);
                    $('#editModal').modal('toggle');
                }
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });

    }

    /* 修改之保存 */
    function doSave() {
        $.ajax({
            url: '<%=basePath%>admin/updateUser',
            type: 'POST',
            data: $('#myeditform').serialize(),// 序列化表单值
            dataType: 'json',
            success: function (json) {
                alert(json.msg);
                $('#editModal').modal('toggle');
                location.reload();
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#editModal').modal('toggle');
            }
        });

    }

</script>

</html>
