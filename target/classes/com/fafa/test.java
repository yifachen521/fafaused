package com.fafa;

import com.fafa.pojo.Dialogue;
import com.fafa.service.impl.NoticeServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @author 炜哥哥
 * @date 2020/2/25 20:42
 */
public class test {
    @Autowired
    NoticeServiceImpl noticeService;


    @Test
    public void  test1 (){
        List<Dialogue> dialogues = noticeService.dialogueMsg(1, 2);
        for (Dialogue dialogue : dialogues) {
            System.out.println(dialogue.toString());
        }
    }
}
