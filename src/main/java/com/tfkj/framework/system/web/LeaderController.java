/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.system.entity.Leader;
import com.tfkj.framework.system.service.LeaderService;

/**
 * @Description: 领导信息维护
 * @author gaowei
 * @date 2018年1月25日
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/leader")
public class LeaderController extends BaseController {

	@Autowired
	private LeaderService leaderService;

	@ModelAttribute("leader")
	public Leader get(@RequestParam(required = false) String id) {

		if (StringUtils.isNotBlank(id)) {
			Leader leader = leaderService.get(id);
			if (leader == null) {
				return new Leader();
			} else {
				return leaderService.get(id);
			}
		} else {
			return new Leader();
		}
	}

	/**
	 * @Title: leaderTree
	 * @Description: 领导树
	 * @param @param isAll true 显示所有
	 * @param @param type 00显示领导类型
	 * @param @param response
	 * @param @return 参数
	 * @return List<Map<String,Object>> 返回类型
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "leaderTree")
	public List<Map<String, Object>> leaderTree(@RequestParam(required = false) Boolean isAll, @RequestParam(required = false) String type, HttpServletResponse response) {

		List<Map<String, Object>> mapList = Lists.newArrayList();
		Leader leader = new Leader();
		if ("00".equals(type)) {
			Leader parent = new Leader();
			parent.setId("0");
			leader.setParent(parent);
		}
		List<Leader> list = leaderService.findList(leader);
		for (int i = 0; i < list.size(); i++) {
			Leader e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("pIds", e.getParentIds());
			map.put("name", e.getL001());
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 查询list
	 *
	 * @param leader
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "list" })
	public String list(Leader leader, Model model) {

		model.addAttribute("list", leaderService.findList(leader));
		return "system/leader/leaderList";
	}

	/**
	 * @Title: cxlist
	 * @Description: 查询
	 * @param @param leader
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "cxList" })
	public String cxlist(Leader leader, Model model) {

		model.addAttribute("list", leaderService.findList(leader));
		return "system/leader/leaderCxList";
	}

	@RequestMapping(value = "add")
	public String add(Leader leader, Model model) {

		model.addAttribute("leader", leader);
		return "system/leader/leaderForm";
	}

	/**
	 * @Title: form
	 * @Description: 维护页
	 * @param @param leader
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "form")
	public String form(Leader leader, Model model) {

		leader = leaderService.get(leader);
		if (leader == null) {
			leader = new Leader();
		}
		model.addAttribute("leader", leader);
		return "system/leader/leaderForm";
	}

	/**
	 * @Title: save
	 * @Description: 保存
	 * @param @param leader
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "save")
	public String save(Leader leader, Model model, RedirectAttributes redirectAttributes) {

		leaderService.save(leader);
		addMessage(redirectAttributes, "维护领导'" + leader.getL001() + "'成功");
		model.addAttribute("list", leaderService.findList(new Leader()));
		return "redirect:" + adminPath + "/sys/leader/list";
	}

	@RequestMapping(value = "delete")
	public String delete(Leader leader, Model model, RedirectAttributes redirectAttributes) {

		leaderService.delete(leader);
		addMessage(redirectAttributes, "删除成功");
		model.addAttribute("list", leaderService.findList(new Leader()));
		return "redirect:" + adminPath + "/sys/leader/list";
	}

	@RequestMapping(value = "batchUpdate")
	public String batchUpdate(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {

		leaderService.batchUpdate(ids, sorts);
		addMessage(redirectAttributes, "更新排序成功!");
		return "redirect:" + adminPath + "/sys/leader/list";
	}
}
