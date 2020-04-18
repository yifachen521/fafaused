package com.fafa.service.impl;

import com.fafa.dao.GoodsMapper;
import com.fafa.pojo.CommentExtend;
import com.fafa.pojo.Comments;
import com.fafa.pojo.Goods;
import com.fafa.service.GoodsService;
import com.fafa.util.DateUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;
@Override
    public int addGood(Goods goods , Integer duration) {
        String startTime = DateUtil.getNowDay();
        String endTime = DateUtil.getLastTime(startTime, duration);
        String polishTime = startTime;
        //添加上架时间，下架时间，擦亮时间
        goods.setPolishTime(polishTime);
        goods.setEndTime(endTime);
        goods.setStartTime(startTime);
        return goodsMapper.insert(goods);
    }
    @Override
    public Goods getGoodsByPrimaryKey(Integer goodsId) {
        Goods goods = goodsMapper.selectByPrimaryKey(goodsId);
        return goods;
    }
    @Override
    public Goods getGoodsById(Integer goodsId) {
        Goods goods = goodsMapper.selectById(goodsId);
        return goods;
    }
    @Override
    public void deleteGoodsByPrimaryKey(Integer id) {
        goodsMapper.deleteByPrimaryKey(id);
    }
    @Override
    public void deleteGoodsByPrimaryKeys(Integer id) {
        goodsMapper.deleteByPrimaryKeys(id);
    }
    @Override
    public List<Goods> getAllGoods() {
        List<Goods> goods = goodsMapper.selectAllGoods();
        return goods;
    }
    @Override
    public List<Goods> searchGoods(String name, String describle) {
        List<Goods> goods = goodsMapper.searchGoods(name,describle);
        return  goods;
    }
    @Override
    public List<Goods> getGoodsByStr(Integer limit,String name,String describle) {
        List<Goods> goods = goodsMapper.selectByStr(limit, name, describle);
        return goods;
    }
    @Override
    public List<Goods> getGoodsByCatelog(Integer id,String name,String describle) {
        List<Goods> goods = goodsMapper.selectByCatelog(id,name,describle);
        return goods;
    }
    @Override
    public void updateGoodsByPrimaryKeyWithBLOBs(int goodsId,Goods goods) {
        goods.setId(goodsId);
        this.goodsMapper.updateByPrimaryKeyWithBLOBs(goods);
    }
    @Override
    public List<Goods> getGoodsByCatelogOrderByDate(Integer catelogId,Integer limit) {
        List<Goods> goodsList = goodsMapper.selectByCatelogOrderByDate(catelogId , limit);
        return goodsList;
    }
    @Override
    public List<Goods> getGoodsOrderByDate(Integer limit) {
        List<Goods> goodsList = goodsMapper.selectOrderByDate(limit);
        return goodsList;
    }
    @Override
    public List<Goods> getGoodsByUserId(Integer user_id) {
        List<Goods> goodsList = goodsMapper.getGoodsByUserId(user_id);
        return goodsList;
    }
    @Override
	public void updateGoodsByGoodsId(Goods goods) {
		
		goodsMapper.updateGoodsByGoodsId(goods);
		
	}

	@Override
	public int getGoodsNum(Integer id,String name,Integer status) {
		 //获取出商品的数量
		List<Goods> goods = goodsMapper.getGoodsList(id,name,status);
	    return goods.size();
	    }

/*	@Override
	public List<Goods> getPageGoods(int pageNum, int pageSize) {

		List<Goods> list =goodsMapper.getGoodsList();
		return list;
	}*/

	@Override
	public List<Goods> getPageGoodsByGoods(Integer id,String name,Integer form, int pageNum, int pageSize) {
		List<Goods> list =goodsMapper.getPageGoodsByGoods(id,name,form,pageNum,pageSize);
		return list;
	}
	
	@Override
	public CommentExtend selectCommentsByGoodsId(Integer id) {
		return goodsMapper.selectCommentsByGoodsId(id);
	}

	@Override
	public void addComments(Comments comments) {
		goodsMapper.addComments(comments);
	}


	//查询热度
    @Override
    public Goods getGoodsHeatnumById(Integer id) {

        Goods goodsHeatnumById = goodsMapper.getGoodsHeatnumById(id);

        return goodsHeatnumById;
    }

    @Override
    public Integer updataGoodsHeatnumById(Integer id, Integer heatnum) {
        Integer integer = goodsMapper.updataGoodsHeatnumById(id, heatnum);
        return integer;
    }
}

