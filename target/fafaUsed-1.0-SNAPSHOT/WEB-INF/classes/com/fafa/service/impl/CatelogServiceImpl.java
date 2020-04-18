package com.fafa.service.impl;

import com.fafa.dao.CatelogMapper;
import com.fafa.pojo.Catelog;
import com.fafa.service.CatelogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Service("catelogService")
public class CatelogServiceImpl implements CatelogService {

    @Resource
    private CatelogMapper catelogMapper;
    @Override
    public int getCount(Catelog catelog) {
        int count = catelogMapper.getCount(catelog);
        return count;
    }
    @Override
    public List<Catelog> getAllCatelog() {
        List<Catelog> catelogs = catelogMapper.getAllCatelog();
        return catelogs;
    }
    @Override
    public Catelog selectByPrimaryKey(Integer id){
        Catelog catelog = catelogMapper.selectByPrimaryKey(id);
        return catelog;
    }
    @Override
    public int updateByPrimaryKey(Catelog catelog) {
        return  catelogMapper.updateByPrimaryKey(catelog);
    }
    @Override
    public int updateCatelogNum(Integer id,Integer number) {
        return catelogMapper.updateCatelogNum(id,number);
    }
}
