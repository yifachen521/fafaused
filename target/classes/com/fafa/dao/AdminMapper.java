package com.fafa.dao;

import com.fafa.pojo.Admin;
import com.fafa.pojo.UserLike;

import java.util.List;

public interface AdminMapper {
	
	
	public Admin findAdmin(Long phone, String password);

	public Admin findAdminById(Integer id);

	public void updateAdmin(Admin admins);

	List<UserLike> findUserLike(Integer id);

}
