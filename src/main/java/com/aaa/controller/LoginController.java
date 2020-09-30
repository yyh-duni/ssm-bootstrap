package com.aaa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    //到达登录界面
    @GetMapping("/logjsp")
    public String toLoginJsp(){
        return "login";
    }

    //登录处理
    @PostMapping("/doLogin")
    public String doLogin(String userName,String userPwd, Model model, HttpSession session){
        if(userName.equals("admin") && userPwd.equals("admin")){
            session.setAttribute("loginUser",userName);
            return "redirect:/book/books";
        }else{
            model.addAttribute("msg","用户名或者密码不正确！");
            return "login";
        }

    }
}
