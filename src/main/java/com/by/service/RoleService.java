package com.by.service;

import com.by.model.Role;
import com.by.vo.RolePermissionVo;
import com.by.vo.RoleVO;

import java.util.List;
import java.util.Map;

public interface RoleService {


    List<RoleVO> findAll(Map<String, Object> pageMap);

    void deleteRoleById(Integer id);

    void addRole(Role role);

    Map<String, Object> rolePermissions(Integer roleId);

    void rolePermissionsGive(RolePermissionVo vo);
}
