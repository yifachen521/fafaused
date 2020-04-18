package com.fafa.service;

import com.fafa.pojo.Image;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
public interface ImageService {
    int insert(Image record);
    /**
     * 通过商品id获取该商品的图片
     * @param goodsId
     * @return
     */
    List<Image> getImagesByGoodsPrimaryKey(Integer goodsId);

    /**
     * 通过商品Id删除商品
     * @param goodsId
     * @return
     */
    int deleteImagesByGoodsPrimaryKey(Integer goodsId);


    int updateImgById(Image record);
}