package com.tfkj.business.ywgl.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tfkj.business.ywgl.entity.YearTaskTableData;
import com.tfkj.business.ywgl.entity.YearTaskTableElement;
import com.tfkj.business.ywgl.service.YearTaskService;
import com.tfkj.business.ywgl.service.YearTaskTableElementService;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 年度重点任务督查
 * @author gaowei
 * @date 2018年1月16日
 */
@Controller
@RequestMapping(value = "${adminPath}/ywgl/yearTask")
public class YearTaskController extends BaseController {

	@Autowired
	private YearTaskService yearTaskService;

	@Autowired
	private YearTaskTableElementService yearTaskTableElementService;

	/**
	 * @Title: index
	 * @Description: 进入index页
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "index", "toList", "" })
	public String index(Model model) {

		model.addAttribute("yearTaskTableElement", new YearTaskTableElement());
		return "business/yearTask/yearTaskList";
	}

	/**
	 * @Title: list
	 * @Description: 列表页
	 * @param @param YearTaskTableData
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<YearTaskTableElement> list(YearTaskTableData entity, HttpServletRequest request) {

		PageResult<YearTaskTableElement> pageResul = yearTaskService.findListPage(entity, new PageParam(request));
		return pageResul;
	}

	/**
	 * @Title: form
	 * @Description: 跳转到form页
	 * @param @param targetTaskId 目标任务ID
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "form")
	public String form(String id, Model model) {

		// 目标任务
		YearTaskTableData targetTask = yearTaskService.get(id);
		// 分解任务
		List<YearTaskTableElement> relateTaskList = new ArrayList<YearTaskTableElement>();
		if (targetTask == null) {
			targetTask = new YearTaskTableData();
		}
		if (StringUtils.isNotBlank(id)) {
			relateTaskList = yearTaskTableElementService.findListByTargetTaskId(id);
		}
		model.addAttribute("yearTaskTableData", targetTask);
		model.addAttribute("yearTaskTableElement", new YearTaskTableElement());
		model.addAttribute("relateTaskList", relateTaskList);
		return "business/yearTask/yearTaskForm";
	}

	/**
	 * @Title: singleYearTaskForm
	 * @Description: 新增目标任务
	 * @param @param targetTaskId
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "singleYearTaskForm")
	public String singleYearTaskForm(String targetTaskId, Model model) {

		// 目标任务
		model.addAttribute("yearTaskTableData", new YearTaskTableData());
		return "business/yearTask/singleYearTaskForm";
	}

	/**
	 * @Title: saveYearTask
	 * @Description: 保存单独目标任务
	 * @param @param entity
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveYearTask")
	public String saveYearTask(YearTaskTableData entity, Model model, RedirectAttributes redirectAttributes) {

		yearTaskService.save(entity);
		addMessage(redirectAttributes, "保存任务成功!");
		return "redirect:" + adminPath + "/ywgl/yearTask/toList";
	}

	/**
	 * @Title: saveYearTaskAndExplain
	 * @Description: 保存并分解任务
	 * @param @param entity
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "saveYearTaskAndExplain")
	public String saveYearTaskAndExplain(YearTaskTableData entity, Model model, RedirectAttributes redirectAttributes) {

		String id = IdGen.uuid();
		entity.setId(id);
		entity.setIsNewRecord(true);
		yearTaskService.save(entity);
		return id;
	}

	/**
	 * @Title: saveParent
	 * @Description: form表单-父级-保存
	 * @param @param YearTaskTableData
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveParent")
	public String saveParent(YearTaskTableData entity, Model model, RedirectAttributes redirectAttributes) {

		yearTaskService.save(entity);
		addMessage(redirectAttributes, "保存任务成功!");
		model.addAttribute("yearTaskTableData", entity);
		model.addAttribute("yearTaskTableElement", new YearTaskTableElement());
		model.addAttribute("relateTask", new YearTaskTableElement());
		return "business/yearTask/yearTaskForm";
	}

	/**
	 * @Title: saveChild
	 * @Description: form表单-子级-保存
	 * @param @param YearTaskTableData
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveChild")
	public String saveChild(YearTaskTableElement entity, Model model, RedirectAttributes redirectAttributes) {

		yearTaskTableElementService.save(entity);
		addMessage(redirectAttributes, "保存任务成功!");
		model.addAttribute("yearTaskTableData", new YearTaskTableData());
		model.addAttribute("yearTaskTableElement", entity);
		return "business/yearTask/yearTaskForm";
	}

	/**
	 * @Title: delete
	 * @Description: form-删除
	 * @param @param YearTaskTableData
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "delete")
	public String delete(YearTaskTableData query, RedirectAttributes redirectAttributes) {

		yearTaskService.delete(query);
		addMessage(redirectAttributes, "删除任务成功！");
		return "business/yearTask/yearTaskForm";
	}

	/**
	 * @Title: listToDelete
	 * @Description: 列表删除
	 * @param @param query
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "listToDelete")
	public String listToDelete(String ids, RedirectAttributes redirectAttributes) {

		int batchDelete = yearTaskService.batchDelete(ids);
		if (batchDelete > 0) {
			addMessage(redirectAttributes, "删除任务成功！");
		} else {
			addMessage(redirectAttributes, "删除任务失败！");
		}
		return "redirect:" + adminPath + "/ywgl/yearTask/toList";
	}

	/**
	 * @Title: deleteChild
	 * @Description: 删除--子级
	 * @param @param YearTaskTableData
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "deleteChild")
	public String deleteChild(YearTaskTableData query, RedirectAttributes redirectAttributes) {

		yearTaskService.delete(query);
		addMessage(redirectAttributes, "删除任务成功！");
		return "business/yearTask/yearTaskForm";
	}
}
