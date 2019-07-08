package com.by.mapper;

import com.by.model.Role;
import com.by.vo.RolePermissionVo;
import com.by.vo.RoleVO;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface RoleMapper {

    @Select("select * from t_role ")
    List<Role> findAll();

    List<RoleVO> findAllAndPermission(Map<String, Object> pageMap);

    @Delete("delete from t_role where role_id = #{id}")
    void deleteRoleById(@Param("id") Integer id);

    @Insert("insert into t_role(role_name) values (#{roleName})")
    void addRole(Role role);

    @Select("select permission_id from t_role_permission where role_id = #{roleId}")
    List<Integer> findPermissionsByRoleId(@Param("roleId") Integer roleId);

    void rolePermissionsGive(@Param("rpvo") RolePermissionVo vo);

    @Delete("delete from t_role_permission where role_id = #{roleId}")
    void deleteRPByRoleId(@Param("roleId") Integer roleId);
}
