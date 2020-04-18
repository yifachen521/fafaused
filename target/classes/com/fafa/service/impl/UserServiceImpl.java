package com.fafa.service.impl;

import com.fafa.dao.AdminMapper;
import com.fafa.dao.UserMapper;
import com.fafa.pojo.User;
import com.fafa.pojo.UserLike;
import com.fafa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void addUser(User user) {
        userMapper.insert(user);
    }

    @Override
    public User getUserByPhone(String phone) {
        User user  = userMapper.getUserByPhone(phone);
        return  user;
    }
   @Override
    public void updateUserName(User  user) {
        userMapper.updateByPrimaryKey(user);
    }

  /*  @Override
    public int updateGoodsNum(Integer id,Integer goodsNum) {
        return userMapper.updateGoodsNum(id,goodsNum);
    }*/
    @Override
    public User selectByPrimaryKey(Integer id) {
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }


    //获取出当前页用户
    @Override
    public List<User> getPageUser(String phone,String username,int start, int rows) {
        List<User> list= userMapper.getUserListByUser(phone,username,null,start,rows);
        //遍历user装载  用户喜好
        for (User user : list) {
            user.setUserlist(adminMapper.findUserLike(user.getId()));
        }
        return list;
    }

    //获取出用户的数量
    @Override
    public int getUserNum(String phone,String username,String qq) {
        List<User> users = userMapper.getUserList(phone,username,qq);
        return users.size();
    }


    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {}
        return session;
    }

    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest();
    }
 /*   @Override
	public int getUserNum(String username) {
		// TODO Auto-generated method stub
		return 0;
	}*/

/*	public InputStream getInputStream1SS() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}*/
/*    @Override
	public List<User> getPageUser(int pageNum, int pageSize, String username) {
		// TODO Auto-generated method stub
		return null;
	}*/

	@Override
	public User getUserById(int id) {
        return userMapper.getUserById(id);
	}
    @Override
    public List<UserLike> getUserLikeById(int id) {
        List<UserLike> userLike = adminMapper.findUserLike(id);
        return userLike;
    }


	@Override
	public void deleteUserById(String ids) {
		this.userMapper.deleteByPrimaryKey(Integer.parseInt(ids));
		
	}

	@Override
	public List<User> getPageUserByUser(String phone, String username, String qq, int start, int rows) {
	 List<User> list= userMapper.getUserListByUser(phone,username,qq,start,rows);
	 return list;
	
	}

/*	@Override
	public List<User> getUserOrderByDate(int size) {
		PageHelper.startPage(1, size);
		 List<User> list = userMapper.getUserListOrderByCreateAt();
		return list;
	}*/
	//根据邮箱修改密码 忘记密码功能
    @Override
    public int updatePwdByEmail(User user) {
        int i = userMapper.updatePwdByEmail(user);
        return i;
    }


}