package com.by.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyMvcConfig  implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("main").setViewName("main");

        registry.addViewController("/user/toUserListPage").setViewName("user/list");

        registry.addViewController("/role/toRoleListPage").setViewName("role/list");

        registry.addViewController("/permission/toPermissionListPage").setViewName("permission/list");
    }

}
