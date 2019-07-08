package com.by.controller;

import com.by.model.User;
import com.by.service.UserService;
import com.by.vo.UserRoleVo;
import com.by.vo.UserVO;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * layui：分页默认传递 page=1&limit=30  page 代表当前页码、limit 代表每页数据量
     * 响应数据的格式：
     * {
     * "code": 0,
     * "msg": "",
     * "count": 1000,
     * "data": [{}, {}]
     * }
     *
     * @param page
     * @param limit
     * @return
     */
    @GetMapping("/users")
    public Map<String, Object> users(Integer page, Integer limit) {
        //使用mybatis分页插件，使用方法，在查询全部方法之前， PageHelper.startPage(当前页,每页条数);
        // PageHelper.startPage(page,limit);
        Map<String, Object> pageMap = new HashMap<>();
        pageMap.put("start", (page - 1) * limit);
        pageMap.put("limit", limit);
        List<UserVO> users = userService.findAll(pageMap);

        //获取分页的详细信息
        // PageInfo<UserVO> info = new PageInfo<>(users);

        //按照需要响应的格式，添加数据
        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", 50);
        map.put("data", users);

        return map;
    }

    /**
     * @param id
     * @return
     * @PathVariable("id") ：将路径中的id赋值给参数id
     */
    @DeleteMapping("/user/{id}")
    public Map<String, Object> deleteUser(@PathVariable("id") Integer id) {

        Map<String, Object> map = new HashMap<>();
        try {
            userService.deleteUserById(id);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    @PostMapping("userRole")
    public Map<String, Object> userRole(UserRoleVo userRoleVo) {
        Map<String, Object> map = new HashMap<>();
        try {
            userService.userRole(userRoleVo);

            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    @GetMapping("userRoles")
    public Map<String, Object> userRoles(Integer userId) {
        Map<String, Object> map = new HashMap<>();

        map = userService.userRoles(userId);

        return map;
    }

    //注册方法
    @RequestMapping("user")
    public Map<String, Object> addUser(User user) {
        Map<String, Object> map = userService.addUser(user);
        return map;
    }

    //判断username是否存在
    @RequestMapping("existUserName/{username}")
    public Map<String, Object> existUserName(@PathVariable("username") String userName) {
        Map<String, Object> map = userService.existUserName(userName);
        return map;
    }

    @PostMapping("login")
    public Map<String, Object> login(User user){
        Map<String, Object> map = new HashMap<>();

        map.put("success",false);
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(),user.getUserPswd());
            try {
                subject.login(token);
                map.put("success",true);
            } catch (UnknownAccountException e) {
                System.out.println("登陆失败：户名不存在");
                map.put("msg","户名不存在");
            } catch (IncorrectCredentialsException e){
                System.out.println("密码错误");
                map.put("msg","密码错误");
            }
        }
        return map;
    }

}
