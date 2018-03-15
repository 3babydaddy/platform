/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.tf.permission.client.entity.DepartmentInfo;
import com.tf.permission.client.entity.ResourceInfo;
import com.tf.permission.client.entity.RoleInfo;
import com.tf.permission.client.entity.User;
import com.tf.permission.client.service.PermissionClientService;
import com.tfkj.framework.core.utils.CacheUtils;
import com.tfkj.framework.core.utils.SpringContextHolder;
import com.tfkj.framework.system.entity.Menu;
import com.tfkj.framework.system.entity.Office;

/**
 * 用户工具类
 * 
 * @author ThinkGem
 * @version 2013-12-05
 */
public class UserUtils {

	private static PermissionClientService permissionClientService = SpringContextHolder
			.getBean(PermissionClientService.class);

	public static final String USER_CACHE = "userCache";

	public static final String USER_CACHE_ID_ = "id_";

	public static final String USER_CACHE_LOGIN_NAME_ = "ln";

	public static final String USER_CACHE_LIST_BY_OFFICE_ID_ = "oid_";

	public static final String CACHE_ROLE_LIST = "roleList";

	public static final String CACHE_MENU_LIST = "menuList";

	public static final String CACHE_MENU_ALL_LIST = "menuAllList";

	public static final String CACHE_AREA_LIST = "areaList";

	public static final String CACHE_OFFICE_LIST = "officeList";

	public static final String CACHE_OFFICE_ALL_LIST = "officeAllList";

	/**
	 * 根据ID获取用户
	 * 
	 * @param id
	 * @return 取不到返回null
	 */
	public static User get(String id) {
		// TODO:暂不提供
		return new User();
	}

	/**
	 * 根据登录名获取用户
	 * 
	 * @param loginName
	 * @return 取不到返回null
	 */
	public static User getByLoginName(String loginName) {
		User user = permissionClientService.findUserByUsername(loginName);
		return user;
	}

	/**
	 * 清除当前用户缓存
	 */
	public static void clearCache() {

		removeCache(CACHE_ROLE_LIST);
		removeCache(CACHE_MENU_LIST);
		removeCache(CACHE_MENU_ALL_LIST);
		removeCache(CACHE_AREA_LIST);
		removeCache(CACHE_OFFICE_LIST);
		removeCache(CACHE_OFFICE_ALL_LIST);
		UserUtils.clearCache(getUser());
	}

	/**
	 * 清除指定用户缓存
	 * 
	 * @param user
	 */
	public static void clearCache(User user) {
		CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
		CacheUtils.remove(USER_CACHE,
				USER_CACHE_LOGIN_NAME_ + user.getLoginName());
	}

	/**
	 * 获取当前用户
	 * 
	 * @return 取不到返回 new User()
	 */
	public static User getUser() {
		Subject subject = getSubject();
		if (subject != null) {
			// fix by wanghw 目前授权通过后只携带了userName
			String userName = (String) subject.getPrincipal();
			User user = permissionClientService.findUserByUsername(userName);
			if (user != null) {
				return user;
			}
			return new User();
		}
		// 如果没有登录，则返回实例化空的User对象。
		return new User();
	}

	/**
	 * 获取当前用户角色列表
	 * 
	 * @return
	 */
	public static List<RoleInfo> getRoleList() {
		@SuppressWarnings("unchecked")
		List<RoleInfo> roleList = (List<RoleInfo>) getCache(CACHE_ROLE_LIST);
		if (roleList == null) {
			roleList = permissionClientService.findRolesByUserName(getUser()
					.getName());
			putCache(CACHE_ROLE_LIST, roleList);
		}
		return roleList;
	}

	/**
	 * 获取当前用户授权菜单
	 * 
	 * @return 资源列表
	 */
	public static List<Menu> getMenuList() {
		/*
		 * MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class); Menu m
		 * = new Menu(); m.setUserId("1"); return menuDao.findByUserId(m);
		 */

		return getMenuAllList();
		/*
		 * @SuppressWarnings("unchecked") List<ResourceInfo> menuList =
		 * (List<ResourceInfo>) getCache(CACHE_MENU_LIST); if (menuList == null)
		 * { User u = getUser(); menuList =
		 * permissionClientService.getMenusByUserName(u .getUsername());
		 * putCache(CACHE_MENU_LIST, menuList); } return menuList;
		 */
	}

	/**
	 * TODO: 获取所有授权菜单
	 * 
	 * @return
	 */
	public static List<Menu> getMenuAllList() {

		List<ResourceInfo> menuList = (List<ResourceInfo>) getCache(CACHE_MENU_LIST);
		if (menuList == null) {
			User u = getUser();
			menuList = permissionClientService.getMenusByUserName(u
					.getUsername());
			putCache(CACHE_MENU_LIST, menuList);
		}

		List<Menu> menus = new ArrayList<Menu>();
		/*
		 * Menu rootMenu = new Menu(); Menu rootParent = new Menu();
		 * rootParent.setShowFlag("0"); rootParent.setName("根节点");
		 * rootMenu.setParent(rootParent); menus.add(rootMenu);
		 */

		for (int i = 0; i < menuList.size(); i++) {
			ResourceInfo recource = menuList.get(i);
			if (i == 0) {
				Menu root = new Menu();
				Menu tmp = new Menu();
				root.setId(recource.get_parentId());
				root.setParent(tmp);
				root.setName("根节点");
				menus.add(root);
			}
			
			Menu rootMenu = new Menu();
			rootMenu.setName("根节点");
			rootMenu.setId(recource.get_parentId());
			Menu model = new Menu();
			model.setHref(recource.getResourceurl());
			model.setShowFlag("1");
			model.setName(recource.getResourcename());
			model.setParent(rootMenu);
			model.setId(recource.getId());
			menus.add(model);
			setSubResource(recource, model, menus);
		}
		for (Menu menu : menus) {
			System.out.println("jsonString================>" + menu);
		}
		return menus;
	}

	private static void setSubResource(ResourceInfo parrent, Menu menuP,
			List<Menu> menus) {
		List<ResourceInfo> children = parrent.getSubResources();
		if (children != null) {
			for (ResourceInfo resourceInfo : children) {
				Menu menu = new Menu();
				menu.setId(resourceInfo.getId());
				menu.setHref(resourceInfo.getResourceurl() != null ? resourceInfo
						.getResourceurl() : "");
				menu.setName(resourceInfo.getResourcename());
				Menu tmp = new Menu();
				tmp.setName(menuP.getName());
				tmp.setId(menuP.getId());
				menu.setId(resourceInfo.getId());
				menu.setParent(tmp);
				menu.setShowFlag("1");
				menus.add(menu);
				setSubResource(resourceInfo, menu, menus);
			}
		}
	}

	/**
	 * 获取当前用户有权限访问的统属部门
	 * 
	 * @return
	 */
	public static List<Office> getOfficeList() {
		// TODO:暂不提供
		return new ArrayList<Office>();
	}

	/**
	 * 获取当前用户有权限访问的部门
	 * 
	 * @return
	 */
	public static List<DepartmentInfo> getOfficeAllList() {
		@SuppressWarnings("unchecked")
		List<DepartmentInfo> officeList = (List<DepartmentInfo>) getCache(CACHE_OFFICE_ALL_LIST);
		if (officeList == null) {
			officeList = permissionClientService.findAllDepartments();
			putCache(CACHE_OFFICE_ALL_LIST, officeList);
		}
		return officeList;
	}

	/**
	 * 获取授权主要对象
	 */
	public static Subject getSubject() {
		try {
			Subject subject = SecurityUtils.getSubject();
			if (subject != null) {
				return subject;
			}
		} catch (UnavailableSecurityManagerException e) {
		} catch (InvalidSessionException e) {
		}
		return null;
	}

	public static Session getSession() {
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(false);
			if (session == null) {
				session = subject.getSession();
			}
			if (session != null) {
				return session;
			}
		} catch (InvalidSessionException e) {
		}
		return null;
	}

	// ============== User Cache ==============
	public static Object getCache(String key) {

		return getCache(key, null);
	}

	public static Object getCache(String key, Object defaultValue) {

		Object obj = getSession().getAttribute(key);
		return obj == null ? defaultValue : obj;
	}

	public static void putCache(String key, Object value) {

		getSession().setAttribute(key, value);
	}

	public static void removeCache(String key) {

		getSession().removeAttribute(key);
	}
}
