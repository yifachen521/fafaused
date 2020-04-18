package com.fafa.service;

import com.fafa.pojo.Catelog;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
public interface CatelogService {
    public List<Catelog> getAllCatelog();
    public int getCount(Catelog catelog);
    Catelog selectByPrimaryKey(Integer id);
    int updateByPrimaryKey(Catelog record);
    int updateCatelogNum(Integer id, Integer number);
}
