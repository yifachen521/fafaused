package com.fafa.pojo;

/**
 * @author 炜哥哥
 * @date 2020/2/5 12:30
 */
public class OrderExtend {
    //订单编号
    private Integer orderId;
    //商品名称
    private  String goodsName;
    //商品价格
    private  Float goodsPrice;
    //商品图片
    private  String image;
    //买家姓名
    private  String buyerName;
    private  Integer buyerId;
    //买家备注
    private  String buyerComment;
    //商品id
    private  Integer goodsId;
    //订单状态
    private  Integer status;

    private  String orderTime;

    private  String sellerName;
    private  Integer sellerId;

    private  String cateLog;

    public String getCateLog() {
        return cateLog;
    }

    public void setCateLog(String cateLog) {
        this.cateLog = cateLog;
    }

    //
    private  Integer goodsStstus;

    public Integer getGoodsStstus() {
        return goodsStstus;
    }

    public void setGoodsStstus(Integer goodsStstus) {
        this.goodsStstus = goodsStstus;
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

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

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

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Float getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(Float goodsPrice) {
        this.goodsPrice = goodsPrice;
    }



    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerComment() {
        return buyerComment;
    }

    public void setBuyerComment(String buyerComment) {
        this.buyerComment = buyerComment;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "OrderExtend{" +
                "orderId=" + orderId +
                ", goodsName='" + goodsName + '\'' +
                ", goodsPrice=" + goodsPrice +
                ", image='" + image + '\'' +
                ", buyerName='" + buyerName + '\'' +
                ", buyerId=" + buyerId +
                ", buyerComment='" + buyerComment + '\'' +
                ", goodsId=" + goodsId +
                ", status=" + status +
                ", orderTime='" + orderTime + '\'' +
                ", sellerName='" + sellerName + '\'' +
                ", sellerId=" + sellerId +
                ", cateLog='" + cateLog + '\'' +
                ", goodsStstus=" + goodsStstus +
                '}';
    }
}
