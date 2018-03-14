package com.tfkj.framework.system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.UserDao;
import com.tfkj.framework.system.entity.User;

/**
 * 描 述：用户管理service
 */
@Service
@Transactional(readOnly = true)
public class UserService extends CrudService<UserDao, User> {

	@Autowired
	private SystemService systemService;

	/**
	 * 验证登录名是否有效
	 *
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	public String checkLoginName(String oldLoginName, String loginName) {

		if (loginName != null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}
}
