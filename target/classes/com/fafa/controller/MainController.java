package com.fafa.controller;

import com.fafa.service.UserService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

/**
 * @author 炜哥哥
 * @date 2020/2/5
 */
@Controller
public class MainController {

    @Resource
    private UserService userService;
    
	/*查找所有用户*/
/*	@RequestMapping(value = "/userList")
	@ResponseBody
	public UserGrid getUserList(@RequestParam("current") int current, @RequestParam("rowCount") int rowCount) {
		int total = userService.getUserNum();
		List<User> list = userService.getPageUser(current, rowCount);
		UserGrid userGrid = new UserGrid();
		userGrid.setCurrent(current);
		userGrid.setRowCount(rowCount);
		userGrid.setRows(list);
		userGrid.setTotal(total);
		return userGrid;
	}*/
}
