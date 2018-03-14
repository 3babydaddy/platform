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
import com.tfkj.framework.system.service.LogService;

/**
 * 日志Controller
 * 
 * @author ThinkGem
 * @version 2013-6-2
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;

	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = { "" })
	public String list(Log log, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 设置默认时间范围，默认当前月
		Log logDate = logService.logDate(log);
		model.addAttribute("logDate", logDate);
		return "system/log/logList";
	}

	/**
	 * 日志列表
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<Log> list(Log log, HttpServletRequest request, HttpServletResponse response) {
		PageResult<Log> pageResult = logService.findPage(log, new PageParam(request));
		return pageResult;
	}

	/**
	 * @Title: form
	 * @Description: 查看日志详情
	 * @param @param log
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = "form")
	public String form(Log log, Model model) {
		Log logForm = logService.get(log);

		model.addAttribute("log", logForm);
		return "system/log/logForm";
	}
}
