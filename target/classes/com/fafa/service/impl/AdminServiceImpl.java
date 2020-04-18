package com.fafa.service.impl;

import com.fafa.dao.AdminMapper;
import com.fafa.pojo.Admin;
import com.fafa.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service(value="adminService")
public class AdminServiceImpl implements AdminService {
	@Resource
	private AdminMapper am;

	@Override
	public Admin findAdmin(Long phone, String password) {
		// TODO Auto-generated method stub
		return am.findAdmin(phone,password);
	}

	@Override
	public Admin findAdminById(Integer id) {
		// TODO Auto-generated method stub
		return am.findAdminById(id);
	}

	@Override
	public void updateAdmin(Admin admins) {
		 am.updateAdmin(admins);
	}


	

}
