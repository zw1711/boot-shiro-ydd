package com.by.controller;

import com.by.model.Role;
import com.by.service.RoleService;
import com.by.vo.RolePermissionVo;
import com.by.vo.RoleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /*
        {“code”:0,”msg”:””,”data”:[{},{}],”count”:100}
     */
    @GetMapping("roles")
    public Map<String, Object> roles(Integer page,Integer limit){
        Map<String, Object> pageMap = new HashMap<>();
        pageMap.put("start",(page - 1)*limit);
        pageMap.put("limit",limit);

        List<RoleVO> roles = roleService.findAll(pageMap);
        Map<String, Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("data",roles);
        map.put("count",0);

        return map;
    }

    @DeleteMapping("/role/{id}")
    public Map<String ,Object> deleteRoleById(@PathVariable("id") Integer id){

        Map<String,Object> map = new HashMap<>();
        try {
            roleService.deleteRoleById(id);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    @PostMapping("role")
    public Map<Object, Object> role(Role role){
        Map<Object, Object> map = new HashMap<>();
        try {
            roleService.addRole(role);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }


    @GetMapping("rolePermissions")
    public Map<String,Object> rolePermissions(Integer roleId){
        Map<String,Object> map = new HashMap<>();

        map = roleService.rolePermissions(roleId);

        return map;
    }

    @PostMapping("rolePermissionsGive")
    public Map<String,Object> rolePermissionsGive(RolePermissionVo vo){
        Map<String,Object> map = new HashMap<>();
        try {
            roleService.rolePermissionsGive(vo);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }
}
