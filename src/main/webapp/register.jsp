<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/8
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>register</title>

    <jsp:include page="/util.jsp"></jsp:include>
</head>
<body>
    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md6 layui-col-md-offset3" align="center">
                <h1>注册页面</h1>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md6 layui-col-md-offset3">


                <%-- 登录 注册--%>

                <div  id="regFormDiv">
                    <form class="layui-form" action="">

                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名：</label>
                            <div class="layui-input-block">
                                <input type="text" name="userName" required  lay-verify="required"
                                       placeholder="请输入用户名" autocomplete="off" class="layui-input" id="userNameInput">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码：</label>
                            <div class="layui-input-inline">
                                <input type="password" name="userPswd" required lay-verify="required"
                                       placeholder="请输入密码" autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux" id="pswdMsg">密码6-18位</div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn layui-btn-normal"  lay-submit lay-filter="regSubmit" >注册</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" id="toLoginPage">登录</button>
                            </div>
                        </div>

                    </form>
                </div>

                <%-- 登录 注册--%>


            </div>
        </div>
    </div>

    <script>
        layui.use(['table','layer','form','jquery'], function() {
            var form = layui.form;
            var $ = layui.jquery;
            var layer = layui.layer;


            $("#toLoginPage").on("click",function () {
                location.href = "login.jsp";
            })


            $("#userNameInput").on("blur",function () {
                var username = $(this).val();
                $.get("/user/existUserName/"+username,function (data) {
                    console.log(data);
                    layer.msg('提示：'+ data.msg);
                },"json")
            })




            //监听提交
            form.on('submit(regSubmit)', function(data){
                console.log(data.field);

                $.post("/user/user",data.field,function(data){
                    if(data.success){

                        layer.msg('注册成功！');
                        location.href = "login.jsp";

                    }else{
                        $("#pswdMsg").html(data.msg);
                        layer.msg('失败！'+ data.msg);
                    }
                    layer.closeAll();
                },"json")

                return false;//防止表单自动提交
            });


        });

    </script>

</body>
</html>
