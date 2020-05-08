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
    <link rel="stylesheet" href="<%=basePath%>css/index.css"/>

    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.min.js"></script>
    <script type="text/javascript">

        /*  function viewPersonal(id) {
              $.ajax({
                  url: 'admin/getUser',
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
          }*/

        function sendContext() {
            var context = $("#mycontext").text();
            alert(context)
            $("#context").val(context);

            /*$.ajax({
                url: 'notice/addSellerMessage',
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
            });*/

        }

        //提交回复
        function submitForm() {
            $("#contextForm").submit();
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
              描述：对话模态框
              -->
<%--        <div ng-controller="loginController" class="ng-scope">
            <div id="login-show" class="login stark-components">
                <div class="publish-box z-depth-4" style="width: 500px;height: 330px">
                    <div class="row" style="width: 480px;margin-left: 10px;">
                        <a onclick="showLogin(null,null)">
                            <span style="font-size: 20px;color: #aaa;width: 500px"><center>给买家留言:</center></span>
                        </a>
                        <table>
                            &lt;%&ndash;行 就遍历生成 &ndash;%&gt;
                            <c:forEach items="${dialogues}" var="dia" varStatus="status">
                                <tr>
                                    <td >${dia.userName}</td>
                                    <td>${dia.buildTime}</td>
                                </tr>
                                <tr>
                                    <td>${dia.context}</td>
                                </tr>
                            </c:forEach>
                        </table>
                        &lt;%&ndash;分页先不做了&ndash;%&gt;
                    </div>
                </div>
            </div>
        </div>--%>
        <!--
            描述：右侧内容区域
        -->
        <div id="user_content">
            <div class="share">
                <!--
            <img src="<%=basePath%>img/Advertisement.png">
          -->
                <span style="font-size: 35px;color: #0bb9f8;">
                        <%--回复消息的锚点--%>
                        <a href="#" name="reply"></a>
                       <center> 回复消息</center>
                    </span>
                <div class="publish">
                    <form role="form" id="contextForm" action="<%=basePath%>notice/addSellerMessage" method="post">
                        <div class="pub_content">
                            <div class="text_pub lead emoji-picker-container">
                                <input type="hidden" id="buyerId" name="buyerId" value="">
                                <input type="hidden" id="goodsName" name="goodsName" value="">

                                <input type="text" name="context" data-emojiable="converted" class="form-control"
                                       data-type="original-input" style="display: none;" id="context" value="">
                                <div class="emoji-wysiwyg-editor form-control" data-type="input" id="mycontext"
                                     contenteditable="true" onblur="sendContext()"></div>
                                <div class="tag"></div>
                            </div>
                        </div>
                    </form>
                    <div class="button">
                        <div class="checkbox">
                            <button onclick="submitForm()">回复</button>
                        </div>
                    </div>

                </div>
                <!--
                    描述：交易交流信息
                -->
                <div class="share_content">
                    <a href="<%=basePath%>user/home?flag=buyer">买家留言</a>
                    <a href="<%=basePath%>user/home?flag=seller">卖家回复</a>

                    <c:if test="${notice==null}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${notice!=null}">
                        <%-- 在判断当前是买家留言    还是卖家回复 --%>
                        <div class="yes_share">
                            <h1 style="text-align: center;">求购信息</h1>
                            <h6 style="text-align: center;color: red">提示:单击买家昵称回复消息</h6>

                            <hr>
                            <c:forEach items="${notice}" var="item" varStatus="status">
                                <%-- '${item.buyerId}','${item.goodsName}','${item.buyerName}' --%>
                                <button type="button" class="btn btn-info"
                                        style="background-color: #c6f5f4;border:0px;outline:none;"><a
                                        href="#reply"
                                        onclick="huifu('${item.buyerId}','${item.goodsName}','${item.buyerName}')">${item.buyerName}</a>
                                </button>
                                <span>说：&nbsp;&nbsp;&nbsp;&nbsp;${item.context}</span><br>
                                <button type="button" class="btn btn-info" onclick="showLogin('${item.buyerId}','${item.buyerName}')"
                                        style="background-color: #c6f5f4;border:0px;outline:none;">查看对话
                                </button>
                                <p style="text-align:right;color:#4fbef6;">留言时间：${item.buildTime}</p>
                                <hr>
                                <br>
                            </c:forEach>
                           <%-- <div id="page" style="center"></div>
                            <!--  <h1> 1 2 3 4 5 下一页 上一页</h1> -->
                        </div>--%>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
</div>
</body>

<script>
    function huifu(buyerId, goodsName, buyerName) {
        $("#buyerId").val(buyerId);
        $("#goodsName").val(goodsName);
        $("#mycontext").attr("placeholder", '回复' + buyerName + ': ');

    }

    //对话模态框  传递当前买家的id
    function showLogin(id,name) {
           window.location.href="<%=basePath%>notice/dialogue?buyerId="+id+"&buyerName="+name;
    }


</script>
</html>