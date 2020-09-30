package com.aaa.controller;

import com.aaa.pojo.*;
import com.aaa.service.BookService;
import com.aaa.service.PublishService;
import com.aaa.util.BaseController;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bs")
public class TestController extends BaseController {
    @Autowired
    BookService bookService;

    @Autowired
    PublishService publishService;

    @GetMapping("/index")
    public String toIndex(){
        return "index";
    }

    //分页条件查询所有的图书
    @GetMapping("findall")
    @ResponseBody
    public void findPg(SelectBook book, HttpServletResponse resp) throws IOException {
        if(null == book){
            book = new SelectBook();
        }
        resp.setContentType("application/json;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();
        Integer pageNum = book.getPageNum();
        Integer pageSize = book.getPageSize();
        String bookName = book.getBookName();
        Integer publishId = book.getPublishId();
        bookName = bookName == null || bookName==""?null:bookName;
        pageNum = pageNum == null || pageNum == 0?1:pageNum;
        pageSize = pageSize == null?5:pageSize;
        if(null != publishId){
            publishId = publishId == -1?null:publishId;
        }

        book.setStart((pageNum-1)*pageSize);
        book.setPageNum(pageNum);
        book.setPageSize(pageSize);
        book.setBookName(bookName);
        book.setPublishId(publishId);
        List<BookVo> bs = bookService.findByPage(book);
        long num = bookService.findByPageNum(book);
        Integer intnum = Integer.valueOf(num+"");
        Message msg = new Message();
        msg.setRows(bs);
        msg.setTotal(intnum);
        out.print(JSON.toJSONStringWithDateFormat(msg,"yyyy-MM-dd hh:mm:ss", SerializerFeature.WriteDateUseDateFormat));

    }
    @GetMapping("/pubs")
    public void pubs(HttpServletResponse response) throws IOException {
        List<Publish> pubs = publishService.selectAll();
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(pubs));

    }
    @PostMapping("/doUpload")
    @ResponseBody
    public void doUpload(MultipartFile photo, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();
        Map<String,String> result = new HashMap<>();
        //判断是否为空
        if(null ==photo){
            result.put("type","error");
            result.put("msg","请选择上传的图片");
            out.print(JSON.toJSONString(result));
            return;
        }
        //判断大小
        long size = photo.getSize();
        if(size > 2000000){
            result.put("type","error");
            result.put("msg","上传的图片超过限定大小，请上传2M以内的图片！");
            out.print(JSON.toJSONString(result));
            return;
        }
        //拿到图片的后缀
        int index = photo.getOriginalFilename().lastIndexOf(".");
        String suffix = photo.getOriginalFilename().substring(index);
        //判断后缀是否是图片
        if(!".jpg,.jpeg,.pgn,.gif".toUpperCase().contains(suffix.toUpperCase())){
            result.put("type","error");
            result.put("msg","必须上传指定格式的图片.jpg,.jpeg,.pgn,.gif");
            out.print(JSON.toJSONString(result));
            return;
        }
        //修改文件的名字
        String newFileName = System.currentTimeMillis()+""+suffix;
        //建立文件
        File file = new File(this.REAL_PATH,newFileName);
        //写入磁盘
        photo.transferTo(file);//把文件写入到指定的路径中；
        //返回给前端数据
        result.put("type","success");
        result.put("msg","上传成功！");
        result.put("fileName",newFileName);
        result.put("filePath",this.VISIT_PATH);
        out.print(JSON.toJSONString(result));
    }

    @PutMapping("/doUpdate")
    public String doUpdate(Book book){
            bookService.update(book);
            return "redirect:/bs/index";
    }
    @DeleteMapping("/doDel")
    @ResponseBody
    public void  doDel(Integer bookId,HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();
        bookService.del(bookId);
        out.print(JSON.toJSONString("ok"));

    }
    @PostMapping("/doAdd")
    public String doAdd(Book book){
        bookService.insert(book);
        return "redirect:/bs/index";
    }

    @DeleteMapping("/doDelAll")
    public void doDelAll(@RequestParam("ids[]") Integer[] ids,HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=utf-8");
        resp.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();
        bookService.delAll(ids);
        out.print(JSON.toJSONString("ok"));
    }


}
