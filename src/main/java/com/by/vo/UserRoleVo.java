package com.by.vo;

import lombok.Data;

import java.util.List;

@Data
public class UserRoleVo {


    private Integer userId;
    //前台使用数组传递数据，后台mvc通过 List接收数据
    private List<Integer> roles;


}
