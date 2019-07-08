package com.by.service.impl;



import com.by.mapper.PermissionMapper;
import com.by.model.Permission;
import com.by.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> findAll() {
        return permissionMapper.findAll();
    }

    @Transactional
    @Override
    public void addPermission(Permission permission) {
        permissionMapper.addPermission(permission);
    }

    @Transactional
    @Override
    public void deletePermission(Integer permissionId) {
        permissionMapper.deletePermissionById(permissionId);

    }
}
