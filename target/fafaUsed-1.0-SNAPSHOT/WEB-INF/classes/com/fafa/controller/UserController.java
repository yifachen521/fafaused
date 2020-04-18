package com.fafa.controller;

import com.fafa.pojo.*;
import com.fafa.service.*;
import com.fafa.service.impl.NoticeServiceImpl;
import com.fafa.util.DateUtil;
import com.fafa.util.MailUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private ImageService imageService;

    @Resource
    private FocusService focusService;


    @Autowired
    private NoticeServiceImpl noticeService;

    /**
     * 用户注册   ok
     *
     * @param user1
     * @return
     */
    @RequestMapping("/addUser")
    public String addUser(HttpServletRequest request, @ModelAttribute("user") User user1) {
        String url = request.getHeader("Referer");
        String t = DateUtil.getNowDate();
        // 创建账户时间
        user1.setCreateAt(t);
        userService.addUser(user1);
        return "redirect:" + url;
    }

    /**
     *  忘记密码 forget_password
     *
     * @return
     */
    @RequestMapping("/forget_password")
    public ModelAndView forget_password() {
        return new ModelAndView("user/forget_password");
    }


    /**
     * 注册验证手机号  ajax动态验证  ok
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Properties register(HttpServletRequest request) {
        String phone = request.getParameter("phone");
        User user = userService.getUserByPhone(phone);
        Properties json = new Properties();
        if (user != null) {
            //用户已存在
            json.setProperty("info", "success");
            //用户存在，注册失败
            return json;
        } else {
            //没有这个人
            json.setProperty("info", "error");
            //用户不存在，可以注册
            return json;
        }
    }


    /**
     *验证登录  ok
     * @param request
     * @param user
     * @return
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public Properties loginValidate(HttpServletRequest request, User user) {
        //根据手机号和密码去查询 用户是否存在
        User cur_user = userService.getUserByPhone(user.getPhone());
        Properties josn = new Properties();
        if(cur_user!=null){
            //用户存在  比对密码
           if( cur_user.getPassword().equals(user.getPassword())){
               //密码比对正确  将用户直接存进session中

               request.getSession().setAttribute("cur_user",cur_user);

               josn.setProperty("info","success");
               return  josn;
           }
           //密码不对
            josn.setProperty("info","error");
            return  josn;
        }
        //用户不存在
        josn.setProperty("info","error");
        return josn;
    }


    /**
     * 发送验证码 ok
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/sendEmail")
    @ResponseBody
    public String sendEmail(User user,HttpServletRequest request) {
        System.out.println(user.toString());
        String validateCode = MailUtils.getValidateCode(6);
        //放入session
        request.getSession().setAttribute("yzm", validateCode);
        boolean b = MailUtils.sendMail(user.getEmail(), validateCode, "验证码");
        if (b) {
            return "success";
        }
        return "hasNoUser";
    }

    /**
     * 验证验证码是否准确  ok
     * @param code
     * @param request
     * @return
     */
    @RequestMapping("/validateEmailCode")
    @ResponseBody
    public ModelAndView validateEmailCode(String email,String code,HttpServletRequest request) {
        String yzm = (String) request.getSession().getAttribute("yzm");
        ModelAndView mv = new ModelAndView();
        if (code.equals(yzm)){
            //表示验证通过  去修改密码  将邮箱设置回页面  后续根据邮箱修改密码
            mv.addObject("email",email);
            mv.setViewName("user/reset_password");
            return mv;
        }
        //验证不通过
        mv.addObject("msg","您的验证码有误哦！");
        mv.setViewName("user/forget_password");
        return mv;
    }

    /**
     *  忘记密码 根据邮箱修改密码  ok
     * @param email
     * @param password02
     * @param request
     * @return
     */
    @RequestMapping("/resetPassword")
    @ResponseBody
    public ModelAndView resetPassword(String email,String password02,HttpServletRequest request) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password02);

        userService.updatePwdByEmail(user);
        //修改成功去登陆
        return new ModelAndView("redirect:/goods/homeGoods");
    }

    /**
     * 去修改密码界面
     * @return
     */
    @RequestMapping("/updatePwdPage")
    public ModelAndView updatePwdPage() {
       return new ModelAndView("user/updatePwd");

    }
    /**
     * 验证旧密码  ok
     * @param oldpassword
     * @param request
     * @return
     */
    @RequestMapping("/checkOldPwd")
    @ResponseBody
    public Properties checkOldPwd(String oldpassword,HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
            Properties json = new Properties();
        if (cur_user.getPassword().equals(oldpassword)){
            //密码正确  可以修改
            json.setProperty("info","success");
            return json;
        }
        //密码不正确
        json.setProperty("info","error");
        return json;
    }


    /**
     *   修改密码 ok
     * @param newpassword2
     * @param request
     * @return
     */
    @RequestMapping("/updatePsw")
    @ResponseBody
    public ModelAndView updatePsw(String newpassword2,HttpServletRequest request) {
        //获取当前登录用户的邮箱
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        //把新修改的密码赋给当前用户
        cur_user.setPassword(newpassword2);
        userService.updatePwdByEmail(cur_user);
        //修改成功  更新session  保险的是从数据库查出来 这里懒一下 直接用当前的用户了
        request.getSession().setAttribute("cur_user",cur_user);
        return new ModelAndView("redirect:/user/home");
    }

    /**
     * 更改用户名
     *
     * @param request
     * @param user
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/changeName")
    public ModelAndView changeName(HttpServletRequest request, User user, ModelMap modelMap) {
        String url = request.getHeader("Referer");
        // 从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        // 更改当前用户的用户名
        cur_user.setUsername(user.getUsername());
        // 执行修改操作
        userService.updateUserName(cur_user);
        // 修改session值
        request.getSession().setAttribute("cur_user", cur_user);
        return new ModelAndView("redirect:" + url);
    }

    /**
     * 完善或修改信息
     * @param request
     * @param user
     * @return
     */
    @RequestMapping(value = "/updateInfo")
    public String updateInfo(HttpServletRequest request, User user) {
        // 从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        //设置修改后的名字
        cur_user.setUsername(user.getUsername());
        //设置添加后的qq
        cur_user.setQq(user.getQq());
        //设置修改后的邮箱
        cur_user.setEmail(user.getEmail());
        // 执行修改操作
        userService.updateUserName(cur_user);
        // 修改session值 更新session
        request.getSession().setAttribute("cur_user", cur_user);
        //重定向到个人设置
        return "redirect:/user/basic";
    }

    /**
     * 用户退出
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().setAttribute("cur_user", null);
        return "redirect:/goods/homeGoods";
    }

    /**
     * 个人中心  进来我就看有没有留言
     *
     * @return
     */
    @RequestMapping(value = "/home")
    public String home(HttpServletRequest request, Model model,String flag) {

        System.out.println(flag+"333333");
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        //默认查询展示  买家的最新的留言信息
        List<Notice> noticeMessage = noticeService.findAllNewMsg(cur_user.getId());
        model.addAttribute("notice",noticeMessage);
        return "user/home";
    }

    /**
     * 个人信息设置
     *
     * @return
     */
    @RequestMapping(value = "/basic")
    public ModelAndView basic(HttpServletRequest request) {
        //前台可以用el表达式直接就从session中拿我们的用户信息  所以我们直接跳转就可以了
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/user/basic");
        return mv;
    }

    /**  ok
     * 我的闲置 查询出所有的用户商品以及商品对应的图片  我的发布
     *
     * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
     */
    @RequestMapping(value = "/allGoods")
    public ModelAndView goods(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        //返回一个我的发布的集合  后台已经判断商品的状态 上架的才会给予展示
        List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
        for (int i = 0; i < goodsList.size(); i++) {
            //将用户信息和image信息封装到GoodsExtend类中，传给前台
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
            goodsExtend.setImages(images);
            goodsExtend.setGoods(goods);
            goodsAndImage.add(i, goodsExtend);
        }
        ModelAndView mv = new ModelAndView();
        mv.addObject("goodsAndImage", goodsAndImage);
        mv.setViewName("/user/goods");
        return mv;
    }

    /**   ok
     * 我的收藏   查询出所有的用户商品以及商品对应的图片
     *
     * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
     */
    @RequestMapping(value = "/allFocus")
    public ModelAndView focus(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        List<Focus> focusList = focusService.getFocusByUserId(userId);
        List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
        //下架商品id集合
        List<Integer> sold_out=new ArrayList<>();
        int sold_out_count =0;
        for (int i = 0; i < focusList.size(); i++) {
            // 将用户信息和image信息封装到GoodsExtend类中，传给前台
            GoodsExtend goodsExtend = new GoodsExtend();
            Focus focus = focusList.get(i);
            Goods goods = goodsService.getGoodsByPrimaryKey(focus.getGoodsId());
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(focus.getGoodsId());
            //后台收集商品的状态 拿到已下架的商品的id  方便一键清理下架商品 功能
            if(goods.getStatus()==0){
                //表示已下架商品
                sold_out.add(goods.getId());
                sold_out_count++;
            }
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsAndImage.add(i, goodsExtend);
        }
        //将下架 商品的id放入session 以便调用
        request.getSession().setAttribute("sold_out",sold_out);
        ModelAndView mv = new ModelAndView();
        //下架商品数
        mv.addObject("sold_out_count",sold_out_count);
        //在售商品数
        int on_sale_count=focusList.size()-sold_out_count;
        mv.addObject("on_sale_count",on_sale_count);
        mv.addObject("goodsAndImage", goodsAndImage);
        mv.setViewName("user/focus");
        return mv;
    }
    /**
     * 根据商品id删除我的收藏   ok
     *
     * @return
     */
    @RequestMapping(value = "/deleteFocus/{id}")
    public String deleteFocus(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
        System.out.println(goods_id+")---111");
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        if(goods_id==-1){
            //表示用户选择了一键删除功能 从当前session中取出失效的id
            List<Integer> sold_out = (List<Integer>)request.getSession().getAttribute("sold_out");
            for (Integer integer : sold_out) {
                focusService.deleteFocusByUserIdAndGoodsId(integer, user_id);
            }
            return "redirect:/user/allFocus";
        }
        //用户选择单独删除
        focusService.deleteFocusByUserIdAndGoodsId(goods_id, user_id);

        return "redirect:/user/allFocus";

    }

    /**
     * 添加我的关注
     *
     * @return
     */
    @RequestMapping(value = "/addFocus")
    @ResponseBody
    public Properties addFocus(HttpServletRequest request, Integer goodsId) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        List<Focus> focus = focusService.getFocusByUserId(user_id);
        System.out.println(focus.toString()+"11112222");
        Properties json = new Properties();
        if (focus.isEmpty()) {
            try {
                focusService.addFocusByUserIdAndId(goodsId, user_id);
            } catch (Exception e) {
                e.printStackTrace();
                //可能出现异常  收藏失败
                json.setProperty("info","error");
               return json;
            }
            //添加个人收藏成功 商品热度加1
            Goods goodsHeatnumById = goodsService.getGoodsHeatnumById(goodsId);
            Integer heatnum = goodsHeatnumById.getHeatnum();
            //更新热度
            goodsService.updataGoodsHeatnumById(goodsId, heatnum + 1);
            //收藏成功
            json.setProperty("info","success");
            return json;
        }
        //遍历这个人的收藏信息防止重复收藏
        boolean flag=false;
        for (Focus myfocus : focus) {
            int goods_Id = myfocus.getGoodsId();
            if (goods_Id == goodsId) {
                //表示已经收藏过该商品
                flag=true;
                break;
            }
        }
        if (flag==false){
            try {
                focusService.addFocusByUserIdAndId(goodsId, user_id);
            } catch (Exception e) {
                e.printStackTrace();
                //可能出现异常  收藏失败
                json.setProperty("info","error");
                return json;
            }
            //添加个人收藏成功 商品热度加1
            Goods goodsHeatnumById = goodsService.getGoodsHeatnumById(goodsId);
            Integer heatnum = goodsHeatnumById.getHeatnum();
            //更新热度
            goodsService.updataGoodsHeatnumById(goodsId, heatnum + 1);
            //收藏成功
            json.setProperty("info","success");
            return json;
        }else {
            json.setProperty("info","msg");
            return json;
        }
    }




/*    @RequestMapping(value = "/insertSelective", method = RequestMethod.POST)
    @ResponseBody
    public String insertSelective(HttpServletRequest request) {
        String context = request.getParameter("context");
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Notice notice = new Notice();
        notice.setContext(context);
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        notice.setCreateAt(sdf.format(dt));
        //notice.setStatus((byte) 0);
        notice.setUser(cur_user);
        if (context == null || context == "") {
            return "{\"success\":false,\"msg\":\"发布失败，请输入内容!\"}";
        }
        try {
            noticeService.insertSelective(notice);
        } catch (Exception e) {
            return "{\"success\":false,\"msg\":\"发布失败!\"}";
        }
        return "{\"success\":true,\"msg\":\"发布成功!\"}";

    }*/


}
