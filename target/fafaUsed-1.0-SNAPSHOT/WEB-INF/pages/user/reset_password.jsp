<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>/css/base.css">

    <link rel="icon" href="favicon.png" type="image/png">
    <link rel="stylesheet" href="<%=basePath%>/css/forget_password.css">
    <title>忘记密码</title>
    <script src="$<%=basePath%>/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript">
         function commitForm(){
                var pass01= $("#password").val();
                var pass02= $("#password02").val();
                if(null==pass01 || ""==pass01 || null==pass02 || ""==pass02){
                    $("#passMsg").text("密码不能为空").css("color","red");
                    return false;
                }else{
                    if(pass01!=pass02){
                        
                        $("#passMsg").text("两次密码输入不一致，请重新输入").css("color","red");
                        return false;
                    }else{
                       
                        $("#passMsg").text("");
                         return true;
                    }
                }
         }
    </script>
</head>

<body>
    <main>
        <center>
        <div class="container">
            <form class="ma" action="<%=basePath%>/user/resetPassword">
               <input type="hidden" name="email" value="${email}"/>
                <div class="form_header">
                    <div class="form_title">
                        <h3>重置密码</h3>
                    </div>
                    
                </div>
                <div class="form_body">
                    <input type="password" placeholder="请输入新密码" id="password" name="password">
                    <input type="password" style="width:100%" placeholder="再次输入新密码" id="password02" name="password02"><span id="passMsg"></span>
                    <input type="submit" style="margin:0px;width:100%" value="提交" onclick="return commitForm()";>
                </div>
                
            </form>
        </div>
        </center>
    </main>
</body>

</html>