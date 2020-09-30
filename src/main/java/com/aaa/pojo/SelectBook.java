package com.aaa.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SelectBook {
    private Integer bookId;

    private String bookName;

    private Integer publishId;

    private Date createDate;

    private Integer pageNum;//当前页码

    private Integer pageSize;//每页的条数

    private int start;



}
