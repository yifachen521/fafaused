package com.fafa.util;

import com.fafa.pojo.User;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */

@XmlRootElement
public class UserGrid {
    private int current;//当前页马
    private int rowCount;//页容量
    private int total;//总数据量
    private List<User> rows;//每页的数据

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<User> getRows() {
        return rows;
    }

    public void setRows(List<User> rows) {
        this.rows = rows;
    }
}
