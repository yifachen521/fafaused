package com.fafa.service.impl;

import com.fafa.dao.NoticeMapper;
import com.fafa.dao.UserMapper;
import com.fafa.pojo.Dialogue;
import com.fafa.pojo.Notice;
import com.fafa.pojo.Revert;
import com.fafa.pojo.User;
import com.fafa.service.NoticeService;
import com.fafa.util.DateSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeMapper NoticeMapper;

    @Autowired
    private UserMapper userMapper;

    //买家留言
    @Override
    public Integer addBuyerMessage(Notice notice) {
        Integer integer = NoticeMapper.addBuyerMessage(notice);
        return integer;
    }

    @Override
    public Integer addSellerMessage(Revert revert) {
        Integer integer = NoticeMapper.addSellerMessage(revert);
        return integer;
    }

    @Override
    public List<Notice> findNoticeMessage(Integer sellId) {
        List<Notice> noticeMessage = NoticeMapper.findNoticeMessage(sellId);
        //装配user
        for (Notice notice : noticeMessage) {
            //卖家名字
            System.out.println(notice.toString());
            notice.setSellerName(userMapper.getUserById(notice.getSellId()).getUsername());

            //买家名称
            notice.setBuyerName(userMapper.getUserById(notice.getBuyerId()).getUsername());
        }

        return noticeMessage;
    }

    @Override
    public List<Revert> findRevertMessage(Integer buyerId) {
        List<Revert> revertMessage = NoticeMapper.findRevertMessage(buyerId);
        for (Revert revert : revertMessage) {
            //卖家名字
            revert.setSellerName(userMapper.getUserById(revert.getSellId()).getUsername());
            //买家名称
            revert.setBuyerName(userMapper.getUserById(revert.getBuyerId()).getUsername());
        }

        return revertMessage;
    }

    @Override
    public List<Notice> findAllNewMsg(Integer sellId) {
        //拿到 当前我所有的买家的id
        List<Integer> allBuyer = NoticeMapper.findAllBuyer(sellId);
        ArrayList<Notice> notices = new ArrayList<>();
        for (Integer integer : allBuyer) {
            //根据买家查找最新的留言数据
            Notice allNewMsg = NoticeMapper.findAllNewMsg(integer);
            //卖家名字
            allNewMsg.setSellerName(userMapper.getUserById(allNewMsg.getSellId()).getUsername());
            //买家名称
            allNewMsg.setBuyerName(userMapper.getUserById(allNewMsg.getBuyerId()).getUsername());

            notices.add(allNewMsg);
        }
        return notices;
    }

    //买卖双方对话信息集合
    @Override
    public List<Dialogue> dialogueMsg(Integer sellId, Integer buyerId) {
        List<Notice> notices = NoticeMapper.dialogueNoticeMessage(sellId, buyerId);
        List<Revert> reverts = NoticeMapper.dialogueRevertMessage(sellId, buyerId);
        //遍历出来全部装到集合中 并按时间进行排序
        List<Dialogue> dialogues = new ArrayList<>();
        //遍历买家留言
        for (Notice notice : notices) {
            Dialogue dialogue = new Dialogue();
            dialogue.setBuildTime(notice.getBuildTime());
            dialogue.setContext(notice.getContext());
            String buyerName = userMapper.getUserById(notice.getBuyerId()).getUsername();
            dialogue.setUserName(buyerName);
            dialogues.add(dialogue);
        }
        //遍历卖家回复
        for (Revert revert : reverts) {
            Dialogue dialogue = new Dialogue();
            dialogue.setBuildTime(revert.getBuildTime());
            dialogue.setContext(revert.getContext());
            String buyerName = userMapper.getUserById(revert.getSellId()).getUsername();
            dialogue.setUserName(buyerName);
            dialogues.add(dialogue);
        }
        //排序
        DateSort.ListSort(dialogues);
        for (Dialogue dialogue : dialogues) {
            System.out.println(dialogue.toString()+"1111------");
        }
        return dialogues;
    }


}
