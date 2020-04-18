package com.fafa.service;

import com.fafa.pojo.Order;
import com.fafa.pojo.OrderExtend;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
public interface OrderService {

    List<OrderExtend> findAllOrderByUserId(Integer id);

    List<OrderExtend> findAllLostOrderByUserId(Integer id);

    List<OrderExtend> findAllBuyerOrderByUserId(Integer id);

    //确认订单
    Integer confirmAnOrder(Integer userId, Integer goodsId, Integer buyerid);

    Integer addOrder(Order order);

    List<OrderExtend> getPageOrders(Integer StartSearch, Integer pageSize, Integer SearchGoodsName, Integer SearchStatus);

    int getOrdersNum(Integer SearchOrderId, Integer SearchStatus);

    List<Order> getOrderBySellIdAndGoodsId(Integer sellId, Integer goodsId);

    Integer updateLossersOrder(Integer buyerId, Integer goodsId);

    //根据id删除订单
    Integer delOrderByid(Integer id);
}
