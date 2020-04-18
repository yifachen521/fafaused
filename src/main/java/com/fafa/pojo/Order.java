package com.fafa.pojo;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @author 炜哥哥
 * @date 2020/2/5 12:08
 */
@Component
public class Order implements Serializable {
    private Integer id;
    private Integer sellerId;
    private Integer buyerId;
    private Integer goodsId;
    private String comment;
    private  Integer status;
    private  String orderTime;

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSellerId() {
        return sellerId;
    }

    public void setSellerId(Integer sellerId) {
        this.sellerId = sellerId;
    }

    public Integer getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(Integer buyerId) {
        this.buyerId = buyerId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", sellerId=" + sellerId +
                ", buyerId=" + buyerId +
                ", goodsId=" + goodsId +
                ", comment='" + comment + '\'' +
                ", status=" + status +
                ", orderTime='" + orderTime + '\'' +
                '}';
    }
}
