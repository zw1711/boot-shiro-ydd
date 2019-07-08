<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/2
  Time: 15:20
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
    <table id="roleTable" lay-filter="roleTableFilter"></table>

    <%-- 角色增加 --%>
    <div style="display: none;" id="addRoleLayer">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">角色名</label>
                <div class="layui-input-block">
                    <input type="text" name="roleName" required  lay-verify="required"
                           placeholder="角色名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="addRoleSubmit">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <%-- 角色增加 --%>


    <div style="display: none;" id="givePermission">
        <form class="layui-form" >

            <input type="hidden" name="roleId" id="roleId">
            <div class="layui-form-item">
                <label class="layui-form-label">权限：</label>
                <div class="layui-input-block" id="permissionsId">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="givePermissionsSubmit">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>


    <script>
        layui.use(['table','layer','form'], function(){
            var table = layui.table;
            var form = layui.form;
            var layer = layui.layer;
            var $ = layui.jquery;


            //第一个实例
            table.render({
                elem: '#roleTable'//对应table载体的id
                ,height: 'full-60'
                ,url: '/role/roles' //加载json数据
                ,page: true //开启分页
                ,toolbar: '#tableToolBar'
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}//复选框
                    ,{field: 'roleId', title: 'ID', sort: true, fixed: 'left'}
                    ,{field: 'roleName', title: '角色名' }
                    ,{field: 'permissions', title: '权限名'
                        ,templet: function(d){
                            var permissions = d.permissions;
                            var  str = '';
                            for (var i = 0; i < permissions.length; i++) {
                                str += ','+permissions[i].permissionName;
                            }
                            str = str.substring(1);
                            return str;
                        }
                    }
                    ,{fixed: 'right', title:'操作', toolbar: '#roleToolBar', width:150}
                ]]
            });

            // 注：tool 对行进行监控 ，test是table原始容器的属性 lay-filter="对应的值"
            table.on('tool(roleTableFilter)',function(obj){
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象

                if(layEvent === 'del'){//说明是删除操作\
                    layer.confirm('真的删除行么', function(index){
                        $.post("/role/role/"+data.roleId,{"_method":"delete"},function(data){
                            if(data.success){
                                obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                            }else{
                                layer.msg('删除失败！');
                            }
                        },"json");
                        layer.close(index);
                        //向服务端发送删除指令
                    });
                }else if(layEvent === 'givePermission'){
                    var roleId = data.roleId;
                    $("#roleId").val(roleId);

                    //动态查询角色，加载数据，并选中
                    active.showPermissionByRoleId(roleId);

                    layer.open({
                        type: 1,
                        title:"赋权限",
                        content: $("#givePermission") //这里content是一个普通的String
                        ,area: ['500px', '300px']
                        ,icon: 0
                    });


                }
            });

            table.on('toolbar(roleTableFilter)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'add':
                        active.addRole();
                        break;

                };
            });

            var active = {
                addRole:function(){
                    layer.open({
                        type: 1,
                        area: ['500px', '150px'],
                        content: $('#addRoleLayer')
                    });
                },
                showPermissionByRoleId:function(roleId){
                    //查询到全部的 role，显示出来
                    //获取到当前用户的 role_id 选中
                    //{'roles':list<Role> ,'roleIds':1,3}
                    $.get("/role/rolePermissions",{'roleId':roleId},function (data) {
                        var permissions = data.permissions;
                        var permissionIds = data.permissionIds;

                        console.log(data);
                        $("#permissionsId").empty();//清除当前元素中的对象

                        for(var i = 0;i<permissions.length;i++){
                            var che = '';
                            //数组.indexOf(xxx)，判断数组中有没有xxx对象，如果没有是-1
                            if(permissionIds.indexOf(permissions[i].permissionId)>-1){//有重复的内容，则应该被选中
                                che = 'checked';
                            }
                            $("#permissionsId").append('<input type="checkbox" '+che+' name="permissions['+i+']" value="'+permissions[i].permissionId+'" title="'+permissions[i].permissionName+'"><br>');
                        }
                        form.render(); //更新全部
                    },'json');
                }
            }

            //增加角色表单监听
            form.on('submit(addRoleSubmit)', function(data){

                //ajax赋角色
                $.post("/role/role",data.field,function(data){
                    if(data.success){

                        table.reload("roleTable", {page:{curr:1}});//从第一页加载

                    }else{
                        layer.msg('失败！');
                    }
                    layer.closeAll();
                },"json")

                return false;//防止表单自动提交
            });




            //赋权限监听
            form.on('submit(givePermissionsSubmit)', function(data){

                //ajax赋角色
                $.post("/role/rolePermissionsGive",data.field,function(data){
                    if(data.success){

                        table.reload("roleTable", {page:{curr:1}});//从第一页加载

                    }else{
                        layer.msg('失败！');
                    }
                    layer.closeAll();
                },"json")

                return false;//防止表单自动提交
            });
        });

    </script>


    <script type="text/html" id="roleToolBar">
        
        <shiro:hasPermission name="/role/givePermission">
        <a class="layui-btn layui-btn-xs" lay-event="givePermission">赋权限</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="/role/delete">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </shiro:hasPermission>
    </script>

    <script type="text/html" id="tableToolBar">
        <shiro:hasPermission name="/role/add">
        <a class="layui-btn layui-btn-xs" lay-event="add">增加</a>
        </shiro:hasPermission>
    </script>
</body>
</html>
