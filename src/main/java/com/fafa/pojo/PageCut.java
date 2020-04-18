package com.fafa.pojo;

import java.io.Serializable;

/**
 * @author 炜哥哥
 * @date 2020/2/8 11:30
 */
public class PageCut implements Serializable {

    private Integer page=1;
    private Integer rows=5;
    private Integer total;
    private  Integer start=0;

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }


    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "PageCut{" +
                "page=" + page +
                ", rows=" + rows +
                ", total=" + total +
                ", start=" + start +
                '}';
    }
}
