package com.by.mapper;

import com.by.model.Permission;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PermissionMapper {

    @Select("select * from t_permission ")
    List<Permission> findAll();

    @Insert("insert into t_permission(permission_name,permission_url) values (#{permissionName},#{permissionUrl})")
    void addPermission(Permission permission);

    @Delete("delete from t_permission where permission_id = #{permissionId}")
    void deletePermissionById(@Param("permissionId") Integer permissionId);
}
