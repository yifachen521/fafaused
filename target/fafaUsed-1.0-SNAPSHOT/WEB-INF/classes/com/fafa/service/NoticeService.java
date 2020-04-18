package com.fafa.service;

import com.fafa.pojo.Dialogue;
import com.fafa.pojo.Notice;
import com.fafa.pojo.Revert;
import com.fafa.pojo.User;

import java.util.List;

public interface NoticeService {

	//添加用户留言
	Integer addBuyerMessage(Notice notice);

	//添加卖家回复
	Integer addSellerMessage(Revert revert);


	//卖家查询用户留言
	List<Notice> findNoticeMessage(Integer sellId);

	//查询卖家回复
	List<Revert> findRevertMessage(Integer buyerId);


	//查询所有的买家的最新的留言   根据当前买家的id

	List<Notice> findAllNewMsg(Integer sellId);



	public List<Dialogue> dialogueMsg(Integer sellId, Integer buyerId) ;

}
