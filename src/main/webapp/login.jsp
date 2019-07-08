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
    <title>login</title>

    <jsp:include page="/util.jsp"></jsp:include>
</head>
<body>


    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md6 layui-col-md-offset3" align="center">
                <h1>登录页面</h1>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md6 layui-col-md-offset3">


                <%-- 登录 注册--%>

                    <div  id="loginFormDiv">
                        <form class="layui-form" action="">

                            <div class="layui-form-item">
                                <label class="layui-form-label">用户名：</label>
                                <div class="layui-input-block">
                                    <input type="text" name="userName" required  lay-verify="required"
                                           placeholder="请输入用户名" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">密码：</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="userPswd" required lay-verify="required"
                                           placeholder="请输入密码" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid layui-word-aux">密码6-18位</div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="loginSubmit">登录</button>
                                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn layui-btn-normal"  id="toRegPage">注册</button>
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


            //点击注册按钮，触发的事件
            $("#toRegPage").on("click",function(){
                location.href = "register.jsp";
            });


            //登录
            form.on('submit(loginSubmit)', function(data){

                $.post("/user/login",data.field,function(data){
                    if(data.success){


                        layer.open({
                            title: '提示'
                            ,content: '登录成功'
                        });

                        location.href = "/main";

                    }else{
                        layer.open({
                            title: '提示'
                            ,content: '失败'+data.msg
                        });

                    }
                    layer.closeAll();
                },"json")

                return false;//防止表单自动提交
            });


        });

    </script>

</body>
</html>
