/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;
import com.tfkj.framework.system.entity.Log;
import com.tfkj.framework.system.entity.Update;
import com.tfkj.framework.system.service.LogService;
import com.tfkj.framework.system.utils.UserUtils;

/**
 * 升级Controller
 * 描 述：系统升级
 * 创建时间: 2016年11月2日
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/update")
public class UpdateController extends BaseController {

	@Autowired
	private LogService logService;

	/**
	 * 系统升级
	 *
	 * @param log
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	// @RequiresPermissions("sys:update:execute")
	@RequestMapping(value = { "index" })
	public String index(Model model) {

		UserUtils.clearCache();
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		UserUtils.removeCache(UserUtils.CACHE_MENU_ALL_LIST);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_ALL_LIST);
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
		UserUtils.removeCache(UserUtils.USER_CACHE);
		model.addAttribute("update", new Update());
		return "redirect:" + adminPath + "/db/updateList";
	}

	/**
	 * 执行升级操作
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:update:execute")
	@RequestMapping(value = { "execute" })
	public String execute(Update update, HttpServletRequest request, HttpServletResponse response) {

		return null;
	}

	/**
	 * 升级记录列表
	 *
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("sys:update:view")
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<Log> list(Log log, HttpServletRequest request, HttpServletResponse response) {

		PageResult<Log> pageResult = logService.findPage(log, new PageParam(request));
		return pageResult;
	}

	/**
	 * 加载列表json格式list
	 */
	@RequiresPermissions("sys:update:view")
	@RequestMapping(value = { "jsonlist" })
	@ResponseBody
	public PageResult<Log> jsonlist(Log log, HttpServletRequest request, HttpServletResponse response) {

		PageResult<Log> pageResult = logService.findPage(log, new PageParam(request));
		return pageResult;
	}
}
