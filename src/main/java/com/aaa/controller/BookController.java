package com.aaa.controller;

import com.aaa.pojo.Book;
import com.aaa.pojo.BookVo;
import com.aaa.pojo.Publish;
import com.aaa.service.BookService;
import com.aaa.service.PublishService;
import com.aaa.util.BaseController;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController extends BaseController {
    @Autowired
    BookService bookService;

    @Autowired
    PublishService publishService;

   @GetMapping("/pubs")
    public void pubs(HttpServletResponse response) throws IOException {
        List<Publish> pubs = publishService.selectAll();
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(pubs));

    }

    @RequestMapping(value = "/books",method = RequestMethod.GET)
    @ResponseBody
    public void Books(Model model, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out = response.getWriter();
        List<BookVo> bs = bookService.selectAll();
        model.addAttribute("bs",bs);
        List<Publish> ps = publishService.selectAll();
        model.addAttribute("ps",ps);
        out.print(JSON.toJSONString(bs));

    }

    @RequestMapping(value = "/goAddJsp",method = RequestMethod.GET)
    public String goAddJsp(Model model){
        List<Publish> ps = publishService.selectAll();
        model.addAttribute("ps",ps);
        return "add";
    }

    @RequestMapping(value = "/doAdd",method = RequestMethod.POST)
    public String doAdd(Book book){
        bookService.insert(book);
        return "redirect:books";
    }

    @RequestMapping(value = "/goUpdateJsp/{bookId}",method = RequestMethod.GET)
    public String goUpdateJsp(@PathVariable("bookId") Integer bookId, Model model){
        Book book = bookService.findByID(bookId);
        model.addAttribute("book",book);
        List<Publish> ps = publishService.selectAll();
        model.addAttribute("ps",ps);
        return "update";
    }
    @RequestMapping(value = "/doUpdate",method = RequestMethod.PUT)
    public  String doUpdate(Book book){
        bookService.update(book);
        return "redirect:books";
    }

    @RequestMapping(value = "/doDel/{bookId}",method = RequestMethod.GET)
    public  String doDel(@PathVariable("bookId") Integer bookId){
        bookService.del(bookId);
        return "redirect:../books";
    }



}
