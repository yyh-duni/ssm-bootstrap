package com.aaa.service;

import com.aaa.pojo.Publish;

import java.util.List;

public interface PublishService {
    int insert(Publish record);

    List<Publish> selectAll();
}
