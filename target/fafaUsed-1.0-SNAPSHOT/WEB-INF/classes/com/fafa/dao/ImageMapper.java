package com.fafa.dao;

import com.fafa.pojo.Image;

import java.util.List;

public interface ImageMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteImagesByGoodsPrimaryKey(Integer goodsId);

    int insert(Image record);

    int updateImgById(Image record);

    int insertSelective(Image record);

    Image selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Image record);

    int updateByPrimaryKeyWithBLOBs(Image record);

    int updateByPrimaryKey(Image record);

    List<Image> selectByGoodsPrimaryKey(Integer goodsId);
}