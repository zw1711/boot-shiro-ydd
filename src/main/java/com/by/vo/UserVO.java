package com.by.vo;

import com.by.model.Role;
import com.by.model.User;
import lombok.Data;

import java.util.List;

@Data
public class UserVO extends User {

    // role对象 多个
    private List<Role> roles;
}
