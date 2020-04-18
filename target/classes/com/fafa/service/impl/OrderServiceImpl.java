package com.fafa.service.impl;

import com.fafa.dao.*;
import com.fafa.pojo.*;
import com.fafa.service.OrderService;
import com.fafa.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5 12:27
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private ImageMapper imageMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CatelogMapper catelogMapper;



    //在此处装配好前台需要的数据
    @Override
    public List<OrderExtend> findAllOrderByUserId(Integer id) {
        List<Order> allOrderByUserId = orderMapper.findAllOrderByUserId(id);

        List<OrderExtend> orderExtends = new ArrayList<>();
        //遍历集合
        for (Order order : allOrderByUserId) {
            //创建一个订单延伸类
            OrderExtend orderExtend = new OrderExtend();
            //取出每一个订单
            //1.商品的信息
            Goods goods = goodsMapper.selectByPrimaryKey(order.getGoodsId());
            orderExtend.setGoodsName(goods.getName());
            orderExtend.setGoodsPrice(goods.getPrice());
            List<Image> images = imageMapper.selectByGoodsPrimaryKey(goods.getId());
            orderExtend.setImage(images.get(0).getImgUrl());
            //买家信息
            User userById = userMapper.getUserById(order.getBuyerId());
            orderExtend.setBuyerId(order.getBuyerId());
            orderExtend.setBuyerComment(order.getComment());
            orderExtend.setBuyerName(userById.getUsername());
            orderExtend.setGoodsId(goods.getId());
            orderExtend.setStatus(order.getStatus());
            //
            orderExtends.add(orderExtend);
        }
        return orderExtends;
    }

    //查看我的卖出订单 交易已完成
    @Override
    public List<OrderExtend> findAllLostOrderByUserId(Integer id) {

        List<Order> allOrderByUserId = orderMapper.findAllLostOrderByUserId(id);

        List<OrderExtend> orderExtends = new ArrayList<>();
        //遍历集合
        for (Order order : allOrderByUserId) {
            //创建一个订单延伸类
            OrderExtend orderExtend = new OrderExtend();
            //取出每一个订单
            //1.商品的信息
            Goods goods = goodsMapper.selectByPrimaryKey(order.getGoodsId());
            orderExtend.setGoodsPrice(goods.getPrice());
            orderExtend.setGoodsName(goods.getName());
            List<Image> images = imageMapper.selectByGoodsPrimaryKey(goods.getId());
            orderExtend.setImage(images.get(0).getImgUrl());
            //买家信息
            User userById = userMapper.getUserById(order.getBuyerId());
            orderExtend.setBuyerName(userById.getUsername());
            orderExtend.setStatus(order.getStatus());
            orderExtend.setBuyerComment(order.getComment());
            orderExtend.setGoodsId(goods.getId());
            //作为卖家
            orderExtend.setOrderTime(order.getOrderTime());
            //
            orderExtends.add(orderExtend);

        }
        return orderExtends;
    }

    //查看我的买入订单的状态
    @Override
    public List<OrderExtend> findAllBuyerOrderByUserId(Integer id) {

        List<Order> allOrderByUserId = orderMapper.findAllBuyerOrderByUserId(id);

        List<OrderExtend> orderExtends = new ArrayList<>();
        //遍历集合
        for (Order order : allOrderByUserId) {
            //创建一个订单延伸类
            OrderExtend orderExtend = new OrderExtend();
            //取出每一个订单
            //1.商品的信息
            Goods goods = goodsMapper.selectByPrimaryKey(order.getGoodsId());
            orderExtend.setGoodsPrice(goods.getPrice());
            orderExtend.setGoodsName(goods.getName());
            orderExtend.setGoodsStstus(goods.getStatus());
            List<Image> images = imageMapper.selectByGoodsPrimaryKey(goods.getId());
            orderExtend.setImage(images.get(0).getImgUrl());
            //卖家信息
            User userById = userMapper.getUserById(order.getSellerId());
            orderExtend.setStatus(order.getStatus());
            orderExtend.setSellerName(userById.getUsername());
            orderExtend.setBuyerComment(order.getComment());
            orderExtend.setGoodsId(goods.getId());
            //
            orderExtends.add(orderExtend);
        }
        return orderExtends;
    }


    @Override
    public Integer confirmAnOrder(Integer userId, Integer goodsId, Integer buyerid) {
        String orderTime = DateUtil.getNowDay();
        Integer integer = orderMapper.confirmAnOrder(orderTime, userId, goodsId, buyerid);
        return integer;
    }

    @Override
    public Integer addOrder(Order order) {
        Integer integer = orderMapper.addOrder(order);
        return integer;
    }

    @Override
    public List<OrderExtend> getPageOrders(Integer StartSearch, Integer pageSize, Integer SearchGoodsName, Integer SearchStatus) {
        //PageHelper.startPage(pageNum, pageSize);
        List<Order> list = orderMapper.getPageOrdersByOrders(StartSearch,pageSize,SearchGoodsName,SearchStatus);
        List<OrderExtend> OrderExtends = new ArrayList<>();
        //在这里装载list
        for (Order order : list) {
            OrderExtend orderExtend = new OrderExtend();
            User Seller = userMapper.getUserById(order.getSellerId());
            User Buyer = userMapper.getUserById(order.getBuyerId());
            orderExtend.setSellerName(Seller.getUsername());
            orderExtend.setBuyerName(Buyer.getUsername());
            //商品信息
            Goods goods = goodsMapper.selectById(order.getGoodsId());
            orderExtend.setGoodsStstus(goods.getStatus());
            orderExtend.setGoodsName(goods.getName());
            orderExtend.setStatus(order.getStatus());
            orderExtend.setOrderId(order.getId());
            orderExtend.setGoodsPrice(goods.getPrice());

            orderExtend.setCateLog(catelogMapper.selectByPrimaryKey(goods.getCatelogId()).getName());

            OrderExtends.add(orderExtend);
        }
        return OrderExtends;
    }

    @Override
    public int getOrdersNum(Integer SearchOrderId, Integer SearchStatus) {
        List<Order> orders = orderMapper.getAllOrder(SearchOrderId,SearchStatus);
        return orders.size();
    }

    @Override
    public List<Order> getOrderBySellIdAndGoodsId(Integer sellId, Integer goodsId) {
        List<Order> orderBySellIdAndGoodsId = orderMapper.getOrderBySellIdAndGoodsId(sellId, goodsId);
        return orderBySellIdAndGoodsId;
    }

    @Override
    public Integer updateLossersOrder(Integer buyerId, Integer goodsId) {
        Integer integer = orderMapper.updateLossersOrder(buyerId, goodsId);
        return integer;
    }

    //根据id来删除订单
    @Override
    public Integer delOrderByid(Integer id) {
        Integer integer = orderMapper.delOrderByid(id);
        return integer;
    }


}
