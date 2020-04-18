package com.fafa.service;

import com.fafa.pojo.User;
import com.fafa.pojo.UserLike;

import java.util.List;

public interface UserService {
    void addUser(User user);

    User getUserByPhone(String phone);

    void updateUserName(User user);

    //int updateGoodsNum(Integer id, Integer goodsNum);

    User selectByPrimaryKey(Integer id);

    List<User> getPageUser(String phone, String username, int start, int rows);

    int getUserNum(String phone, String username, String qq);

    //int getUserNum(String username);

    //List<User> getPageUser(int pageNum, int pageSize, String username);

    User getUserById(int id);

    void deleteUserById(String idArr);

    List<User> getPageUserByUser(String phone, String username, String qq, int start, int rows);

    //List<User> getUserOrderByDate(int size);

    int updatePwdByEmail(User user);

    List<UserLike> getUserLikeById(int id);

}