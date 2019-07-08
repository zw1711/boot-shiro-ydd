<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/1
  Time: 17:43
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
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">八一IT后台管理</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <%--<ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>--%>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    <shiro:principal></shiro:principal>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="/user/logout">登出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item ">
                    <a class="" href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <shiro:hasPermission name="/user/select">
                        <dd><a href="javascript:;" class="tree-nav-class"
                               data_title='用户列表' data_url='/user/toUserListPage' data_id="yhlb">用户列表</a></dd>
                        </shiro:hasPermission>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">角色管理</a>
                    <dl class="layui-nav-child">
                        <shiro:hasPermission name="/role/select">
                        <dd><a href="javascript:;" class="tree-nav-class"
                               data_title='角色列表' data_url='/role/toRoleListPage' data_id="jslb">角色列表</a></dd>
                        </shiro:hasPermission>
                    </dl>
                </li>
                <li class="layui-nav-item ">
                    <a class="" href="javascript:;">权限管理</a>
                    <dl class="layui-nav-child">
                        <shiro:hasPermission name="/permission/select">
                        <dd><a href="javascript:;" class="tree-nav-class"
                               data_title='权限列表' data_url='/permission/toPermissionListPage' data_id="qxlb">权限列表</a></dd>
                        </shiro:hasPermission>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
            <%-- 选项卡主体  --%>
            <div class="layui-tab" lay-filter="myTabs" lay-allowclose="true">
                <ul class="layui-tab-title">
                    <li class="layui-this" lay-id="11">欢迎页面</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">内容1</div>
                </div>
            </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    //JavaScript 代码区域
    // use(["模块1","模块2"],function(){ layui.模块  })
    layui.use('element', function(){
        var element = layui.element;
        var $ = layui.jquery;

        //触发事件
        var active = {
            tabAdd: function(title,url,id){
                //新增一个Tab项
                element.tabAdd('myTabs', {
                    title: title //用于演示
                    , content: '<iframe style="width:100%;height:100%;position:relative;" src="'+url+'" frameborder="0" scrolling="true" ></iframe>'
                    ,id:id
                })
            }
            ,tabDelete: function(othis){
                //删除指定Tab项
                element.tabDelete('demo', '44'); //删除：“商品管理”
                othis.addClass('layui-btn-disabled');
            }
            ,tabChange: function(id){
                //切换到指定Tab项
                element.tabChange('myTabs', id); //切换到：用户管理
            }
        };


        $(".tree-nav-class").on("click",function () {
            var title = $(this).attr("data_title");
            var url = $(this).attr("data_url");
            var id = $(this).attr("data_id");
            //如果没有选项卡
            if($(".layui-tab-title li[lay-id]").length <= 0){

                active.tabAdd(title,url,id);
            }else{
                //判断是否重复
                var flag = false;//没有重复
                $(".layui-tab-title li[lay-id]").each(function(json){
                    if($(this).attr("lay-id") == id){
                        flag = true;
                    }
                })
                if(flag == false){
                    active.tabAdd(title,url,id);
                }
            }
            //切换到指定Tab项
            active.tabChange(id);
        })

    });

</script>
</body>
</html>
