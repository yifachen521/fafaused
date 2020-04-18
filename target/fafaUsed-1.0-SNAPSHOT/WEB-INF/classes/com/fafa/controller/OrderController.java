package com.fafa.controller;

import com.fafa.pojo.*;
import com.fafa.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Properties;

/**
 * @author 炜哥哥
 * @date 2020/2/5 15:09
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CatelogService catelogService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private UserService userService;

    /**
     * 获取订单
     * @param request
     * @return
     */
    @RequestMapping("/orderList")
    public ModelAndView orderList(HttpServletRequest request){
        //获取当前登录的用户 获取其的订单

        User cur_user =(User)request.getSession().getAttribute("cur_user");
        List<OrderExtend> allOrderByUserId = orderService.findAllOrderByUserId(cur_user.getId());

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("Order",allOrderByUserId);
        modelAndView.setViewName("user/orders1");
        return modelAndView;
    }

    /**
     *我卖出的订单查看
     * @param request
     * @return
     */
    @RequestMapping("/lostOrderList")
    public ModelAndView lostOrderList(HttpServletRequest request){

        //获取当前登录的用户 获取其的订单
        User cur_user =(User)request.getSession().getAttribute("cur_user");
        List<OrderExtend> allOrderByUserId = orderService.findAllLostOrderByUserId(cur_user.getId());

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("Order",allOrderByUserId);
        modelAndView.addObject("lostOrder","0");
        modelAndView.setViewName("user/orders1");
                return modelAndView;
    }

    /**
     * 用户买入的  购物小车
     * @param request
     * @return
     */
    @RequestMapping("/buyerOrderList")
    public ModelAndView buyerOrderList(HttpServletRequest request){
        //获取当前登录的用户 获取其的订单
        User cur_user =(User)request.getSession().getAttribute("cur_user");
        List<OrderExtend> allOrderByUserId = orderService.findAllBuyerOrderByUserId(cur_user.getId());

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("Order",allOrderByUserId);
        modelAndView.setViewName("user/buyerOrders");
        return modelAndView;
    }


    /**
     * 卖家用户操作订单 ok
     * @param request
     * @param goodsId
     * @return
     */
    @ResponseBody
    @RequestMapping("/sureSell")
    public Properties sureSell(HttpServletRequest request, Integer goodsId,Integer buyerId){
        //当卖家确认订单后  就在订单表删除这个订单  表示本笔，交易已完成 将商品的状态  修改为0  表示下架
        User cur_user =(User)request.getSession().getAttribute("cur_user");
        //根据用户的id和当前商品的id来修改订单表中 对应的订单状态数据
        orderService.confirmAnOrder(cur_user.getId(), goodsId,buyerId);
        //本商品的其他用户订单修改为2表示订单失效
        List<Order> orderBySellIdAndGoodsId = orderService.getOrderBySellIdAndGoodsId(cur_user.getId(), goodsId);
        for (Order order : orderBySellIdAndGoodsId) {
            //将除了要卖的那个用户的其他的订单的状态修改为2 表示订单失效
            if(!order.getBuyerId().equals(buyerId)){
                //根据买家的id和商品的id去失效这个订单
                orderService.updateLossersOrder(order.getBuyerId(),goodsId);
            }
        }
        //修改商品状态  先查出这个商品对象用于修改商品类型数量
        Goods goods = goodsService.getGoodsByPrimaryKey(goodsId);

        goods.setUserId(cur_user.getId());
        Integer calelog_id = goods.getCatelogId();
        Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
        catelogService.updateCatelogNum(calelog_id, catelog.getNumber() - 1);
        //而不是真的删除商品  下架
        goodsService.deleteGoodsByPrimaryKey(goodsId);

        Properties json = new Properties();
        json.setProperty("info","success");
        return json;
    }

    /**
     * 买家用户确认下订单 去订单页面
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/orderDetail/{id}")
    public ModelAndView orderDetail(HttpServletRequest request, @PathVariable("id") Integer id){
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Goods goods = goodsService.getGoodsByPrimaryKey(id);
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
        GoodsExtend goodsExtend = new GoodsExtend();
        goodsExtend.setImages(imageList);
        goodsExtend.setGoods(goods);
        ModelAndView modelAndView = new ModelAndView();
        // 将商品信息添加到model
        modelAndView.addObject("goodsExtend", goodsExtend);
        //卖家信息
        User userById = userService.getUserById(goods.getUserId());
        modelAndView.addObject("sellUser", userById);
        modelAndView.setViewName("user/orderDetail");
        return modelAndView;

    }

    /**
     * 提交订单  重定向到 我的剁手
     * @param request
     * @param order
     * @return
     */
    @RequestMapping(value = "/orderSubmit")
    public ModelAndView orderSubmit(HttpServletRequest request, Order order){
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        order.setBuyerId(cur_user.getId());
        orderService.addOrder(order);

        return new ModelAndView("redirect:/order/buyerOrderList");
    }




}
