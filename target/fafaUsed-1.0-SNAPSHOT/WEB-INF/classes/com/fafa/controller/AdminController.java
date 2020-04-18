package com.fafa.controller;

import com.fafa.pojo.*;
import com.fafa.service.AdminService;
import com.fafa.service.GoodsService;
import com.fafa.service.OrderService;
import com.fafa.service.UserService;
import com.fafa.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Properties;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource
	private UserService userService;

	@Resource
	private GoodsService goodsService;

	@Resource
	private AdminService adminService;

	@Resource
	private OrderService orderService;

	@RequestMapping("")
	public String login(HttpSession session) {
		// 清除session
		session.invalidate();
		return "admin/login";
	}

	@RequestMapping("/aboutUs")
	public String aboutUs() {
		return "admin/aboutUs";
	}

	/**  ok
	 * 管理员登陆验证
	 * @param request
	 * @param admins
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public String index(HttpServletRequest request, Admin admins) {
		Admin myadmin = adminService.findAdmin(admins.getPhone(), admins.getPassword());
		if (myadmin != null) {
			request.getSession().setAttribute("admin", myadmin);
			return "admin/index";
		}
		return "admin/login";

	}
	//点击首页  更新session
	@RequestMapping(value = "/indexs")
	public String indexs(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (admin != null) {
			Integer id = admin.getId();
			Admin myadmin = adminService.findAdminById(id);
			request.getSession().setAttribute("admin", myadmin);
			return "/admin/index";
		}
		return "/admin/login";

	}
	/*********************************************************
	 * 管理员信息操作
	 **********************************************************/
	
	/* 个人信息 */
	@RequestMapping(value = "/info")
	@ResponseBody
	public ModelAndView getInfo(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("admin", admin);
		modelAndView.setViewName("admin/info");
		return modelAndView;
	}
	
	/* 个人密码 */
	@RequestMapping(value = "/modify")
	@ResponseBody
	public ModelAndView getModify(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("admin", admin);
		modelAndView.setViewName("admin/modify");
		return modelAndView;
	}
	/*验证旧密码*/
	@RequestMapping("/checkOldPwd")
	@ResponseBody
	public Properties checkOldPwd(HttpServletRequest request, String oldpassword) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		Properties json = new Properties();
		if(admin.getPassword().equals(oldpassword)){
			//对
			json.setProperty("info","success");
			return json;
		}
		json.setProperty("info","error");
		return json;
	}

	/* 修改密码 */
	@RequestMapping(value = "/changePassword")
	@ResponseBody
	public ModelAndView changePassword(HttpServletRequest request,String newpassword2) {
		//修改管理员密码
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		admin.setPassword(newpassword2);
		adminService.updateAdmin(admin);
		//去登录
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/admin");
		return modelAndView;
	}

	/*********************************************************
	 *用户管理 1.查找用户 2.查看用户 3.修改用户 4.删除用户 5.用户行为分析
	 **********************************************************/

	/* 查找用户 */
	@RequestMapping("/searchUser")
	public ModelAndView searchUser(User searchuser, PageCut pageCut) {
		ModelAndView mv = new ModelAndView();
		//取查询条件
		String phone = searchuser.getPhone();
		String username = searchuser.getUsername();
		String qq = searchuser.getQq();
		int total = userService.getUserNum(phone,username,qq);
		int start =(pageCut.getPage()-1)*pageCut.getRows();
		List<User> rows = userService.getPageUserByUser(phone, username, qq, start, pageCut.getRows());
		Page<User> page = new Page<>();
		page.setPage(pageCut.getPage());
		page.setSize(pageCut.getRows());
		page.setRows(rows);
		page.setTotal(total);
		mv.addObject("page", page);
		mv.addObject("searchuser", searchuser);
		mv.setViewName("admin/user/user_list");
		return mv;
	}

	/* 查看用户 ok*/
	@RequestMapping(value = "/getUser")
	@ResponseBody
	public User getUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		User user = userService.getUserById(Integer.parseInt(id));
		return user;
	}
	/* 修改用户 ok*/
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	@ResponseBody
	public String updateUser(User user) {
		try {
			userService.updateUserName(user);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"保存失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"保存成功!\"}";
	}

	/* 删除用户 */
	@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
	@ResponseBody
	public String deleteUser(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				userService.deleteUserById(ids[i]);
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}



	/* 用户分析 可根据搜索的关键词  以及收藏的商品类型来分析 */
	@RequestMapping("/userLike")
	public ModelAndView userLike(User searchgoods, PageCut pageCut) {
		//获取所有的用户
		ModelAndView modelAndView = new ModelAndView();
		//参数
		String phone = searchgoods.getPhone();
		String username = searchgoods.getUsername();
		//查询用户的总数
		int total = userService.getUserNum(phone,username,null);
		int start =(pageCut.getPage()-1)*pageCut.getRows();
		//返回user的集合 传入的参数为第几页和数据的总数 这样我们就可以算出limit的两个参数了
		List<User> rows = userService.getPageUser(phone,username,start,pageCut.getRows());
		Page<User> page = new Page<>();
		page.setPage(pageCut.getPage());
		page.setSize(pageCut.getRows());
		page.setRows(rows);
		page.setTotal(total);

		modelAndView.addObject("searchgoods", searchgoods);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("admin/user/user_like");
		return modelAndView;

	}



	/* 查看用户喜好分析 ok*/
/*	@RequestMapping(value = "/getUserLike")
	@ResponseBody
	public List<UserLike> getUserLike(HttpServletRequest request) {
		String id = request.getParameter("id");
		List<UserLike> userLikeById = userService.getUserLikeById(Integer.parseInt(id));
		//遍历出所有的number  计算每一项占百分比
		int sum=0;
		for (UserLike userLike : userLikeById) {
			sum+=userLike.getNumber();
		}
		for (int i = 0; i < userLikeById.size(); i++) {
			userLikeById.get(i).setBaiFenBi(userLikeById.get(i).getNumber()/sum*100);
		}
		return userLikeById;
	}*/


	/*********************************************************
	 * 商品管理 1.查找所有商品 2.查看商品 3.修改商品 4.删除商品
	 * 
	 **********************************************************/
	/* 按条件查询商品 */
	@RequestMapping("/searchGoods")
	public ModelAndView searchGoods(Goods searchgoods, PageCut pageCut) {
		//orderExtend  获取查询的条件   pageCut获取分页的页码和页容量
		ModelAndView mv = new ModelAndView();
		Integer id = searchgoods.getId();
		String name = searchgoods.getName();
		Integer status = searchgoods.getStatus();

		int total = goodsService.getGoodsNum(id, name, status);
		int start =(pageCut.getPage()-1)*pageCut.getRows();
		List<Goods> rows = goodsService.getPageGoodsByGoods(id, name, status, start, pageCut.getRows());
		Page<Goods> page = new Page<>();
		page.setPage(pageCut.getPage());
		page.setSize(pageCut.getRows());
		page.setRows(rows);
		page.setTotal(total);
		mv.addObject("page", page);
		mv.addObject("searchgoods", searchgoods);
		mv.setViewName("admin/goods/goods_list");
		return mv;
	}

	/* 查看商品 ok*/
	@RequestMapping(value = "/getGoods")
	@ResponseBody
	public Goods getGoods(HttpServletRequest request) {
		String id = request.getParameter("id");
		Goods goods = goodsService.getGoodsById(Integer.parseInt(id));
		return goods;
	}

	/* 修改商品 ok*/
	@RequestMapping(value = "/updateGoods", method = RequestMethod.POST)
	@ResponseBody
	public String updateGoods(Goods goods) {

		int id = goods.getId();
		Goods oldGoods = goodsService.getGoodsById(id);
		goods.setUserId(oldGoods.getUserId());
		goods.setPolishTime(oldGoods.getPolishTime());
		goods.setEndTime(oldGoods.getEndTime());
		try {
			goodsService.updateGoodsByPrimaryKeyWithBLOBs(goods.getId(), goods);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"保存失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"保存成功!\"}";
	}


	/* 删除商品 */
	@RequestMapping(value = "/deleteGoods", method = RequestMethod.POST)
	@ResponseBody
	public String deleteGoods(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				goodsService.deleteGoodsByPrimaryKeys(Integer.parseInt(ids[i]));
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}



	/*********************************************************
	 * 订单管理 1.查找订单 2.删除订单  ok
	 **********************************************************/

/* 按条件查询订单 */

	@RequestMapping("/searchOrders")
	public ModelAndView searchOrders(OrderExtend searchorders, PageCut pageCut ) {
		ModelAndView mv = new ModelAndView();
		//拿出查询条件
		Integer SearchOrderId = searchorders.getOrderId();
		Integer SearchStatus = searchorders.getStatus();

		int total = orderService.getOrdersNum(SearchOrderId, SearchStatus);
		//查询的起始位置
		int StartSearch=(pageCut.getPage()-1)*pageCut.getRows();
		List<OrderExtend> rows = orderService.getPageOrders( StartSearch, pageCut.getRows(),SearchOrderId, SearchStatus);
		//返回的数据
		Page<OrderExtend> page = new Page<>();
		page.setPage(pageCut.getPage());
		page.setSize(pageCut.getRows());
		page.setRows(rows);
		page.setTotal(total);
		mv.addObject("page", page);
		mv.addObject("searchorders", searchorders);
		mv.setViewName("admin/orders/orders_list");
		return mv;
	}
	/* 删除订单 */
	@RequestMapping(value = "/deleteOrders", method = RequestMethod.POST)
	@ResponseBody
	public String deleteOrders(@RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				orderService.delOrderByid(Integer.parseInt(ids[i]));
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}
	
}