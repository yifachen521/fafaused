package com.fafa.dao;


import com.fafa.pojo.Notice;
import com.fafa.pojo.Revert;
import com.fafa.pojo.User;

import java.util.List;

public interface NoticeMapper {

    //添加用户留言
    Integer addBuyerMessage(Notice notice);

    //添加卖家回复
    Integer addSellerMessage(Revert revert);


    //卖家查询用户留言
    List<Notice> findNoticeMessage(Integer sellId);

    //查询卖家回复
    List<Revert> findRevertMessage(Integer buyerId);


    //查询所有的买家  根据当前卖家的id
    List<Integer> findAllBuyer(Integer sellId);

    //查询所有的买家的最新的留言   根据当前买家的id

    Notice findAllNewMsg(Integer buyerId);

    //查看对话 根据买家id和卖家的id来查询两个表  整合到对话扩展类
    //1.卖家回复
    List<Notice> dialogueNoticeMessage(Integer sellId,Integer buyerId);

    //2.买家留言
    List<Revert> dialogueRevertMessage(Integer sellId,Integer buyerId);





}