package com.by.controller;

import com.by.model.Permission;
import com.by.service.PermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;


    @GetMapping("permissions")
    public Map<String,Object> permissions(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<Permission> permissions = permissionService.findAll();
        PageInfo<Permission> info = new PageInfo<>(permissions);

        //按照需要响应的格式，添加数据
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",info.getTotal());
        map.put("data",info.getList());
        return map;
    }

    @PostMapping("permission")
    public Map<String,Object> permission(Permission permission){
        Map<String, Object> map = new HashMap<>();
        try {
            permissionService.addPermission(permission);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @DeleteMapping("permission/{id}")
    public Map<String,Object> delete(@PathVariable("id") Integer permissionId){
        Map<String, Object> map = new HashMap<>();
        try {
            permissionService.deletePermission(permissionId);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

}
