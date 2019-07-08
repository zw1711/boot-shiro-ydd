<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/2
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/webjars/layui/2.4.5/css/layui.css">
    <script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="/webjars/layui/2.4.5/layui.js"></script>
</head>
<body>
    <table id="permissionTable" lay-filter="permissionTableFilter"></table>

    <%-- 权限增加 --%>
    <div style="display: none;" id="addPermissionLayer">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">权限名</label>
                <div class="layui-input-block">
                    <input type="text" name="permissionName" required  lay-verify="required"
                           placeholder="权限名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">权限路径</label>
                <div class="layui-input-block">
                    <input type="text" name="permissionUrl" required  lay-verify="required"
                           placeholder="权限名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="addPermissionSubmit">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <%-- 权限增加 --%>

    <script>
        layui.use(['table','layer','form','jquery'], function(){
            var table = layui.table;
            var layer = layui.layer;
            var $ = layui.jquery;
            var form = layui.form;

            //第一个实例
            table.render({
                elem: '#permissionTable'//对应table载体的id
                ,height: 'full-60'
                ,url: '/permission/permissions' //加载json数据
                ,page: true //开启分页
                ,toolbar: '#tableToolBar'
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}//复选框
                    ,{field: 'permissionId', title: 'ID', sort: true, fixed: 'left'}
                    ,{field: 'permissionName', title: '权限名' }
                    ,{field: 'permissionUrl', title: '权限路径' }
                    ,{fixed: 'right', title:'操作', toolbar: '#permissionToolBar', width:150}
                ]]
            });

            //对表格顶部工具栏的监听 toolbar
            table.on('toolbar(permissionTableFilter)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'add':
                        active.addPermission();
                        break;

                };
            });
            //对表格顶部工具栏的监听 toolbar
            table.on('tool(permissionTableFilter)', function(obj){
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象

                if(layEvent === 'del'){//说明是删除操作\
                    layer.confirm('真的删除行么', function(index){
                        $.post("/permission/permission/"+data.permissionId,{"_method":"delete"},function(data){
                            if(data.success){
                                obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                            }else{
                                layer.msg('删除失败！');
                            }
                        },"json");
                        layer.close(index);
                        //向服务端发送删除指令
                    });
                }
            });

            var active = {
                "addPermission":function(){
                    layer.open({
                        type: 1,
                        area: ['500px', '300px'],
                        content: $('#addPermissionLayer')
                    });
                }
            }

            //增加
            form.on('submit(addPermissionSubmit)', function(data){

                $.post("/permission/permission",data.field,function(data){
                    if(data.success){

                        table.reload("permissionTable", {page:{curr:1}});//从第一页加载
                    }else{
                        layer.msg('失败！');
                    }
                    layer.closeAll();
                },"json")

                return false;//防止表单自动提交
            });
        })
    </script>

    <script type="text/html" id="permissionToolBar">
        <shiro:hasPermission name="/permission/delete">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </shiro:hasPermission>
    </script>

    <script type="text/html" id="tableToolBar">
        <shiro:hasPermission name="/permission/add">
        <a class="layui-btn layui-btn-xs" lay-event="add">增加</a>
        </shiro:hasPermission>
    </script>
</body>
</html>
