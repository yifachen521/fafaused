package com.fafa.pojo;

import java.io.Serializable;

/**
 * 买家留言
 */
public class Notice implements Serializable {
    private Integer id;
    private Integer sellId;
    private Integer buyerId;
    private String buildTime;
    private String goodsName;
    private String context;

    private String sellerName;
    private String buyerName;

	@Override
	public String toString() {
		return "Notice{" +
				"id=" + id +
				", sellId=" + sellId +
				", buyerId=" + buyerId +
				", buildTime='" + buildTime + '\'' +
				", goodsName='" + goodsName + '\'' +
				", context='" + context + '\'' +
				", sellerName='" + sellerName + '\'' +
				", buyerName='" + buyerName + '\'' +
				'}';
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSellId() {
		return sellId;
	}

	public void setSellId(Integer sellId) {
		this.sellId = sellId;
	}

	public Integer getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}

	public String getBuildTime() {
		return buildTime;
	}

	public void setBuildTime(String buildTime) {
		this.buildTime = buildTime;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}


}