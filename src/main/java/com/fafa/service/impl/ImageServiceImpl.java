package com.fafa.service.impl;

import com.fafa.dao.ImageMapper;
import com.fafa.pojo.Image;
import com.fafa.service.ImageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Service("imageService")
public class ImageServiceImpl implements ImageService {
    @Resource
    private ImageMapper imageMapper;
    @Override
    public int insert(Image record) {
        return imageMapper.insert(record);
    }
    @Override
    public List<Image> getImagesByGoodsPrimaryKey(Integer goodsId) {
        List<Image> image = imageMapper.selectByGoodsPrimaryKey(goodsId);
        return image;
    }
    @Override
    public int deleteImagesByGoodsPrimaryKey(Integer goodsId) {
        return imageMapper.deleteImagesByGoodsPrimaryKey(goodsId);
    }

    @Override
    public int updateImgById(Image record) {
        int i = imageMapper.updateImgById(record);
        return i;
    }
}
