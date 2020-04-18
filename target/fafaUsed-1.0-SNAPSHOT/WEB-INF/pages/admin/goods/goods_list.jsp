<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  isELIgnored="false"%>
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
    <title>商品列表</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css"
          rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
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
               class="tip-bottom"><i class="icon-home"></i>主页</a> <a title="商品列表"
                                                                     class="tip-bottom">商品列表</a>
        </div>
    </div>
    <!--End-breadcrumbs-->

    <!-- Page table -->
    <div class="container" style="width: 100%;">
        <!-- &lt;!&ndash; Marketing Icons Section &ndash;&gt;-->

        <div class="col-lg-12">
            <h2 class="page-header"
                style="margin-top:10px;text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
                商品列表显示</h2>
        </div>

        <!--搜索栏-->
        <form class="form-horizontal" id="myserchform" name="myform" action="<%=basePath%>admin/searchGoods"
              method="post">
            <div class="form-group">
                <div class="col-sm-8" style="text-align:center;">
                    <span>商品ID：</span>
                    <input type="text" placeholder="请输入纯数字~" name="id" value="${searchgoods.id}"/>
                    <span>名称：</span>
                    <input type="text" name="name" value="${searchgoods.name}"/>
                    <span>状态：</span>
                    <select name="status" id="myselected">
                        <c:if test="${searchgoods.status=='' or searchgoods.status==null}">
                            <option value="" selected="selected">选择商品状态</option>
                            <option value="1">在售</option>
                            <option value="0">下架</option>
                        </c:if>
                        <c:if test="${searchgoods.status==0}">
                            <option value="0">下架</option>
                            <option value="" selected="selected">选择商品状态</option>
                            <option value="1">在售</option>
                        </c:if>
                        <c:if test="${searchgoods.status==1}">
                            <option value="1">在售</option>
                            <option value="" selected="selected">选择商品状态</option>
                            <option value="0">下架</option>
                        </c:if>



                    </select>
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-success btn-sm" type="submit">查找</button>
                    <button class="btn btn-danger btn-sm" type="button" id="deleteGoods">删除</button>
                </div>
            </div>
        </form>

        <!--表格显示-->

        <table class="table table-bordered">
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAllButton"></th>
                <th>序号</th>
                <th>名称</th>
                <th>类别</th>
                <th>价格</th>
                <th>创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.rows}" var="item" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="itemIds" value="${item.id}"></td>
                    <td>${s.count}</td>
                    <td>${item.name}</td>
                    <td>
                        <c:if test="${item.catelogId == 1}">
                            <span> 闲置数码</span>
                        </c:if>
                        <c:if test="${item.catelogId == 2}">
                            <span>校园代步 </span>
                        </c:if>
                        <c:if test="${item.catelogId == 3}">
                            <span> 电器日用  </span>
                        </c:if>
                        <c:if test="${item.catelogId == 4}">
                            <span> 图书教材  </span>
                        </c:if>
                        <c:if test="${item.catelogId == 5}">
                            <span>美妆衣物 </span>
                        </c:if>
                        <c:if test="${item.catelogId == 6}">
                            <span> 运动棋牌</span>
                        </c:if>
                        <c:if test="${item.catelogId == 7}">
                            <span> 票券小物</span>
                        </c:if>
                    </td>
                    <td>￥${item.realPrice}</td>
                    <td>${item.startTime}</td>
                    <td>
                        <c:if test="${item.status == 1}">
                            <span style="color:blue">在售</span>
                        </c:if>
                        <c:if test="${item.status == 0}">
                            <span style="color:red">下架</span>
                        </c:if>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary btn-sm" onclick="doView(${item.id})">详情
                        </button>
                        <button type="button" class="btn btn-info btn-sm" onclick="doEdit(${item.id})">修改</button>
                </tr>
            </c:forEach>
            </tbody>
        </table>


        <!--分页条-->

        <div class="container">
            <div class="navbar-right" style="padding-right: 250px">
                <common:page url="${pageContext.request.contextPath}/admin/searchGoods"></common:page>
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
                <h4 class="modal-title" id="myModalLabel">修改商品信息</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
                <form class="form-horizontal" id="myeditform" name="myform">
                    <input type="hidden" id="my_id" name="id" value=""/>

                    <div class="form-group">
                        <label class="col-sm-4 control-label">名称:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_name" name="name" style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">类别:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_catelogIdview"
                                   style="margin-top: 8px;"/>
                            <input type="hidden" id="my_catelogIdhidden" name="catelogId" value=""/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">原价:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_price" name="price"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">售价:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_realPrice" name="realPrice"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">创建时间:</label>
                        <div class="col-sm-8">
                            <input type="text" id="my_startTime" name="startTime" class="form-control form_datetime"
                                   style="margin-top: 8px;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">热度:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_heatnum" name="heatnum"
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">描述:</label>
                        <div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" style="margin-top: 8px;width:365px">
					</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">状态:</label>
                        <div class="col-sm-8">
                            <select name="status" style="margin-top: 8px;width: 372px;height: 27px;">
                                <option value="" selected="selected" id="status0"></option>
                                <option value="" id="status1"></option>
                            </select>
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
                <h4 class="modal-title" id="myModalLabel">查看商品信息</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
                <form class="form-horizontal" id="myviewform" name="myform">
                    <input type="hidden" id="id" name="id" value=""/>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">名称:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_name" name="name" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">类别:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_catelogId" name="catelogId" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">原价:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_price" name="price" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">售价:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_realPrice" name="realPrice" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">创建时间:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_startTime" name="startTime" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">热度:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_heatnum" name="heatnum" readonly
                                   style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">描述:</label>
                        <div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" readonly
                              style="margin-top: 8px;width:365px">
					</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">状态:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_status" name="status" readonly
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
        format: 'yyyy-mm-dd',
        todayHighlight: true,
        language: 'zh-CN',
        minView: "month",
        autoclose: true
    });


    /* 查看 */
    function doView(id) {
        $.ajax({
            url: '<%=basePath%>admin/getGoods',
            type: 'GET',
            data: {id: id},
            dataType: 'json',
            success: function (json) {
                if (json) {
                    $('#myviewform').find("input[name='id']").val(json.id);
                    $('#myviewform').find("input[name='name']").val(json.name);

                    if (json.catelogId == 1) {
                        $('#myviewform').find("input[name='catelogId']").val('闲置数码');
                    } else if (json.catelogId == 2) {
                        $('#myviewform').find("input[name='catelogId']").val('校园代步');
                    } else if (json.catelogId == 3) {
                        $('#myviewform').find("input[name='catelogId']").val('电器日用');
                    } else if (json.catelogId == 4) {
                        $('#myviewform').find("input[name='catelogId']").val('图书教材');
                    } else if (json.catelogId == 5) {
                        $('#myviewform').find("input[name='catelogId']").val('美妆衣物');
                    } else if (json.catelogId == 6) {
                        $('#myviewform').find("input[name='catelogId']").val('运动棋牌');
                    } else if (json.catelogId == 7) {
                        $('#myviewform').find("input[name='catelogId']").val('票券小物');
                    }
                    $('#myviewform').find("input[name='price']").val(json.price);
                    $('#myviewform').find("input[name='realPrice']").val(json.realPrice);
                    $('#myviewform').find("input[name='startTime']").val(json.startTime);
                    $('#myviewform').find("input[name='heatnum']").val(json.heatnum);
                    $('#myviewform').find("textarea[name='describle']").val(json.describle);

                    if (json.status == 1) {
                        $('#myviewform').find("input[name='status']").val('在售');
                    } else {
                        $('#myviewform').find("input[name='status']").val('已下架');
                    }
                    $('#viewModal').modal('toggle');
                }
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });
    }

    /* 修改 */
    function doEdit(id) {

        $.ajax({
            url: '<%=basePath%>admin/getGoods',
            type: 'GET',
            data: {id: id},
            dataType: 'json',
            success: function (json) {
                if (json) {
                    $('#myeditform').find("input[id='my_id']").val(json.id);

                    $('#myeditform').find("input[id='my_name']").val(json.name);

                    if (json.catelogId == 1) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('闲置数码');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('1');
                    } else if (json.catelogId == 2) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('校园代步');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('2');
                    } else if (json.catelogId == 3) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('电器日用');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('3');
                    } else if (json.catelogId == 4) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('图书教材');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('4');
                    } else if (json.catelogId == 5) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('美妆衣物');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('5');
                    } else if (json.catelogId == 6) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('运动棋牌');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('6');
                    } else if (json.catelogId == 7) {
                        $('#myeditform').find("input[id='my_catelogIdview']").val('票券小物');
                        $('#myeditform').find("input[id='my_catelogIdhidden']").val('7');
                    }
                    $('#myeditform').find("input[id='my_price']").val(json.price);
                    $('#myeditform').find("input[id='my_realPrice']").val(json.realPrice);
                    $('#myeditform').find("input[id='my_startTime']").val(json.startTime);
                    $('#myeditform').find("input[id='my_heatnum']").val(json.heatnum);
                    $('#myeditform').find("textarea[id='my_describle']").val(json.describle);
                    if (json.status == 1) {
                        $('#myeditform').find("option[id='status0']").val('1').html('在售');
                        $('#myeditform').find("option[id='status1']").val('0').html('下架');
                    } else {
                        $('#myeditform').find("option[id='status0']").val('0').html('下架');
                        $('#myeditform').find("option[id='status1']").val('1').html('在售');
                    }

                    $('#editModal').modal('toggle');
                }
            },
            error: function () {
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });

    }

    /* 保存 */
    function doSave() {
        $.ajax({
            url: '<%=basePath%>admin/updateGoods',
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

    //根据值 动态选中
    $("#myselected option[value='${searchgoods.status}']").attr("selected", "selected");

</script>

</html>
