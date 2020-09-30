package com.aaa.service;

import com.aaa.pojo.Book;
import com.aaa.pojo.BookVo;
import com.aaa.pojo.SelectBook;

import java.util.List;

public interface BookService {
    int insert(Book record);

    List<BookVo> selectAll();

    int del(Integer bookId);

    int update(Book book);

    Book findByID(Integer bookId);

    List<BookVo> findByPage(SelectBook book);

    //分页查询总条数
    Long findByPageNum(SelectBook book);

    //批量删除
    boolean delAll(Integer[] ids);
}
