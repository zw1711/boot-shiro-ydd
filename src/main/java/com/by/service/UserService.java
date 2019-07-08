package com.by.service;

import com.by.model.User;
import com.by.vo.UserRoleVo;
import com.by.vo.UserVO;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserService {

    List<UserVO> findAll(Map<String,Object> pageMap);

    void deleteUserById(Integer id);

    void userRole(UserRoleVo userRoleVo);

    Map<String, Object> userRoles(Integer userId);

    Map<String,Object> addUser(User user);

    Map<String, Object> existUserName(String userName);

    User findUserByUserName(String username);

    Set<String> findRolesByUserName(String username);

    Set<String> findPermissionByUserName(String username);
}
