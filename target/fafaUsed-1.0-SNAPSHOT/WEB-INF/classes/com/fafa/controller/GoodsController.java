package com.fafa.controller;

import com.fafa.pojo.*;
import com.fafa.service.CatelogService;
import com.fafa.service.GoodsService;
import com.fafa.service.ImageService;
import com.fafa.service.UserService;
import com.fafa.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Controller
@RequestMapping(value = "/goods")
public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ImageService imageService;
	@Autowired
	private CatelogService catelogService;
	@Autowired
	private UserService userService;

	

	/**  ok
	 * 首页显示商品，每一类商品查询6件，根据最新上架排序 key的命名为catelogGoods1、catelogGoods2....
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/homeGoods")
	public ModelAndView homeGoods() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		// 商品种类数量
		int catelogSize = 7;
		// 每个种类显示商品数量
		int goodsSize = 6;

		List<Goods> goodsList = null;
		List<GoodsExtend> goodsAndImage = null;

		/* 获取最新发布列表 */
		goodsList = goodsService.getGoodsOrderByDate(goodsSize);
		goodsAndImage = new ArrayList<GoodsExtend>();
		for (int j = 0; j < goodsList.size(); j++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(j);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setImages(images);
			goodsExtend.setGoods(goods);
			goodsAndImage.add(j, goodsExtend);

		}
		String key0 = "catelog" + "Goods";
		modelAndView.addObject(key0, goodsAndImage);

		/* 获取其他列表物品信息 */
		for (int i = 1; i <= catelogSize; i++) {
			goodsList = goodsService.getGoodsByCatelogOrderByDate(i, goodsSize);
			goodsAndImage = new ArrayList<GoodsExtend>();
			for (int j = 0; j < goodsList.size(); j++) {
				// 将用户信息和image信息封装到GoodsExtend类中，传给前台
				GoodsExtend goodsExtend = new GoodsExtend();
				Goods goods = goodsList.get(j);
				List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
				goodsExtend.setGoods(goods);
				goodsExtend.setImages(images);
				goodsAndImage.add(j, goodsExtend);

			}
			String key = "catelog" + "Goods" + i;
			modelAndView.addObject(key, goodsAndImage);
		}
		modelAndView.setViewName("goods/homeGoods");
		return modelAndView;
	}

	/**
	 * 搜索商品
	 * 
	 * @param str          //ajax传值
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/search")
	public ModelAndView searchGoods(@RequestParam(value = "str", required = false) String str) throws Exception {
		List<Goods> goodsList = goodsService.searchGoods(str, str);
		List<GoodsExtend> goodsExtendList = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(i);
			List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(imageList);
			goodsExtendList.add(i, goodsExtend);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("search", str);
		modelAndView.addObject("goodsExtendList", goodsExtendList);
		modelAndView.setViewName("/goods/searchGoods");
		return modelAndView;
	}

	/**
	 * 查询该类商品  最新发布
	 * 
	 * @param
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/catelog")
	public ModelAndView homeGoods(HttpServletRequest request, @RequestParam(value = "str", required = false) String str)
			throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		// 每个种类显示商品数量
		int goodsSize = 12;
		List<Goods> goodsList = null;
		List<GoodsExtend> goodsAndImage = null;
		/* 获取最新发布列表 */
		goodsList = goodsService.getGoodsByStr(goodsSize, str, str);
		goodsAndImage = new ArrayList<GoodsExtend>();
		for (int j = 0; j < goodsList.size(); j++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(j);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setImages(images);
			goodsExtend.setGoods(goods);
			goodsAndImage.add(j, goodsExtend);
		}
		modelAndView.addObject("goodsExtendList", goodsAndImage);
		modelAndView.addObject("search", str);
		modelAndView.setViewName("/goods/catelogGoods");
		return modelAndView;
	}

	/** ok
	 * 查询该类商品  详细的分类下的
	 * 
	 * @param id
	 *            要求该参数不为空
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/catelog/{id}")
	public ModelAndView catelogGoods(@PathVariable("id") Integer id,
			@RequestParam(value = "str", required = false) String str) throws Exception {
		List<Goods> goodsList = goodsService.getGoodsByCatelog(id, str, str);
		//返回一个类型的对象
		Catelog catelog = catelogService.selectByPrimaryKey(id);

		List<GoodsExtend> goodsExtendList = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(i);
			List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setImages(imageList);
			goodsExtend.setGoods(goods);
			goodsExtendList.add(i, goodsExtend);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("goodsExtendList", goodsExtendList);
		modelAndView.addObject("catelog", catelog);
		modelAndView.addObject("search", str);
		modelAndView.setViewName("/goods/catelogGoods");
		return modelAndView;
	}

	/** ok
	 * 根据商品id查询该商品详细信息  查看一个商品详细信息
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goodsId/{id}")
	public ModelAndView getGoodsById( @PathVariable("id") Integer id,
			@RequestParam(value = "str", required = false) String str) throws Exception {


		//商品信息
		Goods goods = goodsService.getGoodsByPrimaryKey(id);

		//卖家信息
		User seller = userService.selectByPrimaryKey(goods.getUserId());
		//商品类别
		Catelog catelog = catelogService.selectByPrimaryKey(goods.getCatelogId());
		//创建一个商品信息的扩展类 加入商品的其他的详细的信息
		GoodsExtend goodsExtend = new GoodsExtend();
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		//评论信息(不是集合？)
		CommentExtend CommentExtend=goodsService.selectCommentsByGoodsId(id);
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("CommentExtend",CommentExtend);
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.addObject("seller", seller);
		modelAndView.addObject("search", str);
		modelAndView.addObject("catelog", catelog);
		//modelAndView.setViewName("/WEB-INF/pages/goods/detailGoods.jsp");
		modelAndView.setViewName("goods/detailGoods");

		return modelAndView;

	}
	
	 /**  ok
     * 发布评论
     * @return 
     */
    @RequestMapping(value = "/addComments",method=RequestMethod.POST)
    public void deleteFocus(HttpServletRequest request,Comments comments) {
    	User cur_user = (User)request.getSession().getAttribute("cur_user");
        comments.setUser(cur_user);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date createAt =new Date();
		comments.setCreateAt(sdf.format(createAt));
        goodsService.addComments(comments);
       
	}

	/** ok
	 * 去修改商品信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editGoods/{id}")
	public ModelAndView editGoods(HttpServletRequest request,@PathVariable("id") Integer id) throws Exception {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		GoodsExtend goodsExtend = new GoodsExtend();
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);
		ModelAndView modelAndView = new ModelAndView();
		// 将商品信息添加到model
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.setViewName("/goods/editGoods");
		return modelAndView;
	}

	/** ok
	 * 提交商品更改信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editGoodsSubmit")
	public String editGoodsSubmit(HttpServletRequest request, Goods goods ,MultipartFile imgpath,String imgUrl) throws Exception {
		//修改基础信息
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());
		String polish_time = DateUtil.getNowDay();
		goods.setPolishTime(polish_time);
		goods.setStatus(1);
		goodsService.updateGoodsByPrimaryKeyWithBLOBs(goods.getId(), goods);
		//修改商品图片
		//获取用户选取上传的图片的名称
		String originalFilename = imgpath.getOriginalFilename();
		// 如未选择获取到的就是  ""  只要用户选择了图片我们就给他修改
		if(originalFilename==null || "".equals(originalFilename)){
			//未选择修改图片 我们就不管他
			return "redirect:/user/allGoods";
		}
		//服务器的图片文件夹的地址
		File file = new File("E:\\Software\\tomcat\\apache-tomcat-9.0.0.M20-file\\webapps\\upload");
		String s = UUID.randomUUID().toString() + originalFilename;
		try {
			imgpath.transferTo(new File(file,s));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		//删除服务器上存储的被修改的图片
		String oldFileUrl = file.getAbsoluteFile() +"\\"+imgUrl;
		File file1 = new File(oldFileUrl);
		boolean delete = file1.delete();
		//修改数据库存储的图片的名称
		Image ima = new Image();
		ima.setGoodsId(goods.getId());
		ima.setImgUrl(s);
		// 在image表中插入商品图片
		imageService.updateImgById(ima);
		return "redirect:/user/allGoods";
	}

	/**
	 * 商品下架
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/offGoods")
	public ModelAndView offGoods() throws Exception {

		return null;
	}

	/**
	 * 用户删除商品 我们这里就将状态修改为下架 真正删除商品的信息由管理员来做
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteGoods/{id}")
	public String deleteGoods(HttpServletRequest request, @PathVariable("id") Integer id) throws Exception {
		//查出本件商品
		Goods goods = goodsService.getGoodsByPrimaryKey(id);

		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());

		Integer calelog_id = goods.getCatelogId();
		Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
		catelogService.updateCatelogNum(calelog_id, catelog.getNumber() - 1);
		//而不是真的删除商品  下架
		goodsService.deleteGoodsByPrimaryKey(id);
		return "redirect:/user/allGoods";
	}

	/** ok
	 * 发布商品
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/publishGoods")
	public ModelAndView publishGoods(HttpServletRequest request) {
		// 可以校验用户是否登录
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("goods/pubGoods");
		return mv;
	}

	/**
	 * 提交发布的商品信息 ok
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/publishGoodsSubmit")
	public String publishGoodsSubmit(HttpServletRequest request, Goods goods, MultipartFile imgPath)
			throws Exception {
		// 查询出当前用户cur_user对象，便于使用id
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());
		goodsService.addGood(goods, 10);
		// 返回插入的该物品的id
		int goodsId = goods.getId();
		String Filename = imgPath.getOriginalFilename();
		//随机的生成一个不会重复的图片名称
		String s = UUID.randomUUID().toString() + Filename;
		//从上传图片到图片的服务器
		File file = new File("E:\\Software\\tomcat\\apache-tomcat-9.0.0.M20-file\\webapps\\upload");
		try {
			imgPath.transferTo(new File(file,s));

		} catch (IOException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		//把图片地址保存到数据库
		Image ima = new Image();
		ima.setGoodsId(goodsId);
		ima.setImgUrl(s);
		// 在image表中插入商品图片
		imageService.insert(ima);
		// 发布商品后，catlog的number+1，更新session的值

		Integer calelog_id = goods.getCatelogId();
		Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
		catelogService.updateCatelogNum(calelog_id, catelog.getNumber() + 1);
		// 修改session值
		request.getSession().setAttribute("cur_user", cur_user);
		return "redirect:/user/allGoods";
	}

/*
	@RequestMapping(value = "/buyId/{id}")
	public ModelAndView getGoodsdetailById(HttpServletRequest request, @PathVariable("id") Integer id)
			throws Exception {
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		GoodsExtend goodsExtend = new GoodsExtend();
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);
		User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.setViewName("/WEB-INF/pages/user/pay.jsp.bak");
		return modelAndView;
	}*/


	
}