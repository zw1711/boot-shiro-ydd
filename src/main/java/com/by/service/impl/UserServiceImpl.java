package com.by.service.impl;


import com.by.mapper.RoleMapper;
import com.by.mapper.UserMapper;
import com.by.model.Role;
import com.by.model.User;
import com.by.service.UserService;
import com.by.vo.UserRoleVo;
import com.by.vo.UserVO;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<UserVO> findAll(Map<String,Object> pageMap) {
        return userMapper.findAll(pageMap);
    }

    @Transactional
    @Override
    public void deleteUserById(Integer id) {
        userMapper.deleteUserById(id);
    }

    @Transactional
    @Override
    public void userRole(UserRoleVo userRoleVo) {
        //删除所有和userid有关的数据
        userMapper.deleteUserRoleByUserId(userRoleVo.getUserId());

        //添加数据
        userMapper.insertUserRole(userRoleVo);

    }

    @Override
    public Map<String, Object> userRoles(Integer userId) {
        Map<String, Object> map = new HashMap<>();
        //查询全部的 roles
        List<Role> roles = roleMapper.findAll();
        //通过id查询role对象

        List<Integer> roleIds = userMapper.findRoleIdsByUserId(userId);

        map.put("roles",roles);
        map.put("roleIds",roleIds);
        return map;
    }

    @Transactional
    @Override
    public Map<String,Object> addUser(User user) {
        Map<String,Object> map = new HashMap<>();
        //通过用户名查询数据是否存在

        User findUserByUserName = userMapper.findUserByUserName(user.getUserName());
        if(findUserByUserName == null){
            //加密
            //通过用户名创建盐值
            ByteSource credentialsSalt = ByteSource.Util.bytes(user.getUserName());
            String md5 = new SimpleHash("MD5", user.getUserPswd(), credentialsSalt, 3).toString();
            user.setUserPswd(md5);
            userMapper.addUser(user);
            map.put("success",true);
        }else{
            map.put("msg","当前用户已存在");
            map.put("success",false);
            return map;
        }

        return map;

    }

    @Override
    public Map<String, Object> existUserName(String userName) {

        Map<String,Object> map = new HashMap<>();
        User userByUserName = userMapper.findUserByUserName(userName);
        if(userByUserName == null){
            map.put("msg","用户名可以用！");
        }else{
            map.put("msg","用户名已存在！");
        }
        return map;
    }

    //通过用户名查询数据
    @Override
    public User findUserByUserName(String username) {
        return userMapper.findUserByUserName(username);
    }

    @Override
    public Set<String> findRolesByUserName(String username) {
        return userMapper.findRolesByUserName(username);
    }

    @Override
    public Set<String> findPermissionByUserName(String username) {
        return userMapper.findPermissionByUserName(username);
    }
}
