package com.aaa.service;

import com.aaa.mapper.PublishMapper;
import com.aaa.pojo.Publish;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PublishServiceImpl implements PublishService {

    @Autowired
    PublishMapper publishMapper;
    @Override
    public int insert(Publish record) {
        return publishMapper.insert(record);
    }

    @Override
    public List<Publish> selectAll() {
        return publishMapper.selectAll();
    }
}
