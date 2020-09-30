package com.aaa.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
    private Integer bookId;

    private String bookName;

    private Integer publishId;

    private Date createDate;

    private String pic;

}