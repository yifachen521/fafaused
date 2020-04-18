package com.fafa.dao;

import com.fafa.pojo.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5 12:12
 */
@Repository
public interface OrderMapper {
    //查询出所有的待确认订单  根据当前用户id
    List<Order> findAllOrderByUserId(Integer id);


    List<Order> findAllLostOrderByUserId(Integer id);

    //查询我买入的订单 根据用户id 作为买家
    List<Order> findAllBuyerOrderByUserId(Integer id);

    //确认订单
    Integer confirmAnOrder(String orderTime, Integer userId, Integer goodsId, Integer buyerid);


    //添加订单
    Integer addOrder(Order order);

    //查询所有的订单
    List<Order> getAllOrder(@Param("orderId") Integer orderId, @Param("status") Integer status);
    //根据条件去查询相应的订单
    List<Order> getPageOrdersByOrders(@Param("StartSearch") Integer StartSearch, @Param("pageSize") Integer pageSize, @Param("orderId") Integer orderId, @Param("status") Integer status);

    //根据卖家的id和商品的id去查询出相应的订单（想买该商品的所偶有的订单）
    List<Order> getOrderBySellIdAndGoodsId(Integer sellerId, Integer goodsId);

    Integer updateLossersOrder(Integer buyerId, Integer goodsId);

    Integer delOrderByid(Integer id);
}
