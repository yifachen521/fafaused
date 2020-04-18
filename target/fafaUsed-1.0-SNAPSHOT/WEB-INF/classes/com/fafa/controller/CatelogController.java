package com.fafa.controller;

import com.fafa.service.CatelogService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Controller
public class CatelogController {
    @Resource
    private CatelogService catelogService;

}
