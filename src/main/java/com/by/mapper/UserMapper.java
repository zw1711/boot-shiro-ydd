package com.by.mapper;

import com.by.model.User;
import com.by.vo.UserRoleVo;
import com.by.vo.UserVO;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Mapper
public interface UserMapper {

    /*@Select("select * from t_user ")*/
    List<UserVO> findAll(Map<String,Object> pageMap);

    @Delete("delete from t_user where user_id = #{id}")
    void deleteUserById(@Param("id") Integer id);

    @Delete("delete from t_user_role where user_id = #{userId}")
    void deleteUserRoleByUserId(@Param("userId") Integer userId);

    void insertUserRole(@Param("urvo") UserRoleVo userRoleVo);

    @Select("select role_id from t_user_role where user_id = #{userId}")
    List<Integer> findRoleIdsByUserId(@Param("userId") Integer userId);

    @Select("select * from t_user where user_name = #{userName}")
    User findUserByUserName(@Param("userName") String userName);

    @Insert("insert into t_user(user_name,user_pswd) values(#{userName},#{userPswd})")
    void addUser(User user);

    Set<String> findRolesByUserName(@Param("userName")String username);

    Set<String> findPermissionByUserName(@Param("userName") String username);
}
