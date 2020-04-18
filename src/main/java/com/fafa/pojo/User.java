package com.fafa.pojo;

import java.io.Serializable;
import java.util.List;


public class User implements Serializable {
    private Integer id;

    private String phone;

    private String username;

    private String password;

    private String qq;

    private String createAt;

    private String email;
    //用户的喜好
    private List<UserLike> userlist;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", phone='" + phone + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", qq='" + qq + '\'' +
                ", createAt='" + createAt + '\'' +
                ", email='" + email + '\'' +
                ", userlist=" + userlist +
                '}';
    }

    public List<UserLike> getUserlist() {
        return userlist;
    }

    public void setUserlist(List<UserLike> userlist) {
        this.userlist = userlist;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}