package com.fafa.service.impl;

import com.fafa.dao.FocusMapper;
import com.fafa.pojo.Focus;
import com.fafa.service.FocusService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("focusService")
public class FocusServiceImpl implements FocusService {
	
	 @Resource
	 private FocusMapper focusMapper;

	 /**
	  * 根据用户id获取我的关注
	  */
	 @Override
	 public List<Focus> getFocusByUserId(Integer user_id) {
		List<Focus> focusList = focusMapper.getFocusByUserId(user_id);
				
        return focusList;
	}
	 
	 /*
	  * 根据用户id和关注id删除
	  */
	 @Override
	public void deleteFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id) {
		
		focusMapper.deleteFocusByUserIdAndGoodsId(goods_id, user_id);
		
	}
	/*
	  * 添加我的关注
	  */
	@Override
	public void addFocusByUserIdAndId(Integer goods_id, Integer user_id) {
		
		focusMapper.addFocusByUserIdAndGoodsId(goods_id,user_id);
		
	}

}
