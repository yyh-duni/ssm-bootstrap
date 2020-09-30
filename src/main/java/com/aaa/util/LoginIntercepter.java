package com.aaa.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginIntercepter implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获取请求的RUi:去除http:localhost:8080这部分剩下的
       String uri = httpServletRequest.getRequestURI();
        System.out.println("uri======================="+uri);
        if(uri.indexOf("/login")>0){
            return true;
        }
        String userName = (String) httpServletRequest.getSession().getAttribute("loginUser");
        if(null == userName){
            httpServletRequest.setAttribute("msg","请先登录");
            httpServletRequest.getRequestDispatcher("/login/logjsp").forward(httpServletRequest,httpServletResponse);

            return false;
        }else{
            return true;
        }

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
