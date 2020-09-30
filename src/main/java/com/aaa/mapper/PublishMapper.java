package com.aaa.mapper;

import com.aaa.pojo.Publish;

import java.util.List;

public interface PublishMapper {
    int insert(Publish record);

    List<Publish> selectAll();
}