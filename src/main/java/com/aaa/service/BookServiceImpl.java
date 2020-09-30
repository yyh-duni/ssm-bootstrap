package com.aaa.service;

import com.aaa.mapper.BookMapper;
import com.aaa.pojo.Book;
import com.aaa.pojo.BookVo;
import com.aaa.pojo.SelectBook;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BookServiceImpl implements BookService {

    @Autowired
    BookMapper bookMapper;
    @Override
    public int insert(Book record) {
        return bookMapper.insert(record);
    }

    @Override
    public List<BookVo> selectAll() {
        return bookMapper.selectAll();
    }

    @Override
    public int del(Integer bookId) {
        return bookMapper.del(bookId);
    }

    @Override
    public int update(Book book) {
        return bookMapper.update(book);
    }

    @Override
    public Book findByID(Integer bookId) {
        return bookMapper.findByID(bookId);
    }

    @Override
    public List<BookVo> findByPage(SelectBook book) {

        return bookMapper.findByPage(book);
    }

    @Override
    public Long findByPageNum(SelectBook book) {
        return bookMapper.findByPageNum(book);
    }

    @Override
    public boolean delAll(Integer[] ids) {
        boolean flag = true;
        for (Integer id : ids) {
            bookMapper.del(id);
        }
        return flag;
    }
}
