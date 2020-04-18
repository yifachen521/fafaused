package com.fafa.controller;

import com.fafa.pojo.Dialogue;
import com.fafa.pojo.Notice;
import com.fafa.pojo.Revert;
import com.fafa.pojo.User;
import com.fafa.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/24 19:46
 */

@Controller
@RequestMapping("/notice")//     notice/dialogue
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    //对卖家说
    @RequestMapping("/addBuyerMessage")
    public String addBuyerMessage(Notice notice, Model model, HttpSession session){
        //获取当前用户id
        User cur_user =(User) session.getAttribute("cur_user");
        notice.setBuyerId(cur_user.getId());
        //获取当前时间
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String thisdate = format.format(date);
        notice.setBuildTime(thisdate);
        noticeService.addBuyerMessage(notice);


        //待处理--------------------------------

        model.addAttribute("notice",null);
        return "user/home";
    }


    //回复买家
    @RequestMapping("/addSellerMessage")
    public String addSellerMessage(Revert revert, Model model, HttpSession session){
        //获取当前时间
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String thisdate = format.format(date);
        revert.setBuildTime(thisdate);
        //获取当前用户id
        User cur_user =(User) session.getAttribute("cur_user");
        revert.setBuyerId(cur_user.getId());

        noticeService.addSellerMessage(revert);
        //model.addAttribute("notice",null);
        return "redirect:/user/home";
    }


    //查看对话
    @RequestMapping("/dialogue")
    public String dialogue(Integer buyerId,String buyerName,Model model, HttpSession session){
        System.out.println(buyerId+"--111--"+buyerName);
        User cur_user =(User) session.getAttribute("cur_user");
        List<Dialogue> dialogues = noticeService.dialogueMsg(cur_user.getId(), buyerId);
        model.addAttribute("dialogues",dialogues);
        model.addAttribute("buyerName",buyerName);

        return "user/message";
    }


}
