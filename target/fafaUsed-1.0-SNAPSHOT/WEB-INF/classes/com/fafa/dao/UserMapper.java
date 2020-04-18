package com.fafa.dao;

import com.fafa.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper{
    int deleteByPrimaryKey(Integer id);
    //注册用户
    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    //修改用户信息 通过id
    int updateByPrimaryKey(User record);

    User getUserByPhone(String phone);//通过手机号查询用户

    //int updateGoodsNum(@Param("id") Integer id, @Param("goodsNum") Integer goodsNum);//更改用户的商品数量

    List<User> getUserList(@Param("phone") String phone, @Param("username") String username, @Param("qq") String qq);//获取所有用户

	//int findCount();

	//修改密码通过邮箱
    int updatePwdByEmail(User user);

	User getUserById(int id);

	List<User> getUserListByUser(@Param("phone") String phone, @Param("username") String username, @Param("qq") String qq, @Param("start") int start, @Param("rows") int rows);

	List<User> getUserListOrderByCreateAt();



}