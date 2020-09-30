package com.aaa.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestInterceper implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
       //进入处理器前做的工作
        //return false表示不放行
        //可以进行登录认证
        System.out.println("1----------------preHandle");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        //进入处理器后做的工作
        //可以进行统一的公共工作，切面编程
        System.out.println("1----------------postHandle");
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

        //执行完毕后要做的工作
        //可以进行日志统一处理
        System.out.println("1----------------afterCompletion");
    }
}
