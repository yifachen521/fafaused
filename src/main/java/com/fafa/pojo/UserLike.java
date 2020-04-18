package com.fafa.pojo;

/**
 * @author 炜哥哥
 * @date 2020/2/6 21:11
 */
public class UserLike {
    private String catelogName;
    private Integer catelogId;
    private Integer number;
    private Integer baiFenBi;


    public Integer getBaiFenBi() {
        return baiFenBi;
    }

    public void setBaiFenBi(Integer baiFenBi) {
        this.baiFenBi = baiFenBi;
    }

    public String getCatelogName() {
        return catelogName;
    }

    public void setCatelogName(String catelogName) {
        this.catelogName = catelogName;
    }

    public Integer getCatelogId() {
        return catelogId;
    }

    public void setCatelogId(Integer catelogId) {
        this.catelogId = catelogId;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "UserLike{" +
                "catelogName='" + catelogName + '\'' +
                ", catelogId=" + catelogId +
                ", number=" + number +
                ", baiFenBi=" + baiFenBi +
                '}';
    }
}
