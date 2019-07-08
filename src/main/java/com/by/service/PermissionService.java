package com.by.service;

import com.by.model.Permission;

import java.util.List;

public interface PermissionService {


    List<Permission> findAll();

    void addPermission(Permission permission);

    void deletePermission(Integer permissionId);
}
