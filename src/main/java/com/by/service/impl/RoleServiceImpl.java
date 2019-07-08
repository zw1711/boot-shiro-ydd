package com.by.service.impl;


import com.by.mapper.PermissionMapper;
import com.by.mapper.RoleMapper;
import com.by.model.Permission;
import com.by.model.Role;
import com.by.service.RoleService;
import com.by.vo.RolePermissionVo;
import com.by.vo.RoleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;


    @Override
    public List<RoleVO>  findAll(Map<String, Object> pageMap) {
        return roleMapper.findAllAndPermission(pageMap);

    }

    @Transactional
    @Override
    public void deleteRoleById(Integer id) {
        roleMapper.deleteRoleById(id);
    }

    @Transactional
    @Override
    public void addRole(Role role) {
        roleMapper.addRole(role);
    }

    @Override
    public Map<String, Object> rolePermissions(Integer roleId) {
        Map<String, Object> map = new HashMap<>();
        //查询全部permission
        List<Permission> permissions = permissionMapper.findAll();
        //通过roleId 查询权限
        List<Integer> permissionIds= roleMapper.findPermissionsByRoleId(roleId);

        map.put("permissions",permissions);
        map.put("permissionIds",permissionIds);

        return map;
    }

    @Transactional
    @Override
    public void rolePermissionsGive(RolePermissionVo vo) {

        //删除之前的

        roleMapper.deleteRPByRoleId(vo.getRoleId());
        roleMapper.rolePermissionsGive(vo);
    }


}
