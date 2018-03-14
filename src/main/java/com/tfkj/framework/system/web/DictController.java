/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.google.common.collect.Maps;
import com.tfkj.framework.core.utils.CacheUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.tfkj.framework.core.beanvalidator.BeanValidators;
import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel;
import com.tfkj.framework.core.utils.excel.ImportExcel;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.system.entity.Dict;
import com.tfkj.framework.system.entity.DictType;
import com.tfkj.framework.system.service.DictService;
import com.tfkj.framework.system.service.DictTypeService;

/**
 * 字典Controller
 * 
 * @author sunxuelong
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;

	@Autowired
	private DictTypeService dictTypeService;

	@ModelAttribute
	public Dict get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return dictService.get(id);
		} else {
			return new Dict();
		}
	}

	/**
	 * 进入index页
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = { "index", "" })
	public String index() {
		return "system/dict/dictIndex";
	}

	/**
	 * 列表页（不分页）
	 * 
	 * @param dict
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = { "list" })
	public String list(Dict dict, Model model) {
		List<Dict> dictList = dictService.findList(dict);
		model.addAttribute("dictList", dictList);
		model.addAttribute("dict", dict);
		return "system/dict/dictList";
	}

	/**
	 * 跳转到form页
	 * 
	 * @param dict
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {
		model.addAttribute("dict", dict);
		return "system/dict/dictForm";
	}
	/**
	 * 获取单位JSON数据。
	 *
	 * @param type
	 *            类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade
	 *            显示级别
	 * @param response
	 * @return
	 */
	// @RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "dictTree")
	public List<Map<String, Object>> treeData(String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Dict dict = new Dict();
		dict.setTypeEnname(type);
		List<Dict> list = dictService.findList(dict);
		for (int i = 0; i < list.size(); i++) {
			Dict e = list.get(i);
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getEnname());
				map.put("name", e.getChname());
				if (type != null ) {
					map.put("isParent", true);
				mapList.add(map);
			}
		}
		return mapList;
	}



	/**
	 * 保存到数据库
	 * 
	 * @param dict
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save") // @Valid
	public String save(Dict dict, Model model, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage&type=" + dict.getTypeEnname();
		}
		if (!beanValidator(model, dict)) {
			return form(dict, model);
		}
		dictService.save(dict);
		addMessage(redirectAttributes, "保存字典项'" + dict.getChname() + "'成功");
		return "redirect:" + adminPath + "/sys/dict/list?repage&typeEnname=" + dict.getTypeEnname();
	}

	/**
	 * 删除
	 * 
	 * @param dict
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
	public String delete(Dict dict, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage";
		}
		dictService.delete(dict);
		addMessage(redirectAttributes, "删除字典项成功！");
		return "redirect:" + adminPath + "/sys/dict/list?repage&typeEnname=" + dict.getTypeEnname();
	}

	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Dict> listData(@RequestParam(required = false) String typeEnname) {
		Dict dict = new Dict();
		dict.setTypeEnname(typeEnname);
		return dictService.findList(dict);
	}

	/**
	 * 下载导入数据模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "字典数据导入模板.xlsx";
			List<Dict> list = Lists.newArrayList();
			Dict dict1 = new Dict();
			dict1.setTypeEnname("ywgl_xb");
			dict1.setEnname("M");
			dict1.setChname("男");
			dict1.setSort(1);
			Dict dict2 = new Dict();
			dict2.setTypeEnname("ywgl_xb");
			dict2.setEnname("W");
			dict2.setChname("女");
			dict2.setSort(2);
			list.add(dict1);
			list.add(dict2);
			new ExportExcel("字典数据", Dict.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！系统出现错误,请稍后重试!");
		}
		return "redirect:" + adminPath + "/sys/dict?repage";
	}

	/**
	 * 导入字典数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Dict> list = ei.getDataList(Dict.class);
			DictType dictType = new DictType();
			Dict dictCheck = new Dict();
			for (Dict dict : list) {
				try {
					BeanValidators.validateWithException(validator, dict);
					dictType.setEnname(dict.getTypeEnname());
					if (dictTypeService.findList(dictType) != null && dictTypeService.findList(dictType).size() > 0) {
						dictCheck.setTypeEnname(dict.getTypeEnname());
						dictCheck.setEnname(dict.getEnname());
						if (dictService.findList(dictCheck) == null || dictService.findList(dictCheck).size() == 0) {
							dictService.save(dict);
							successNum++;
						} else {
							failureMsg.append("<br/>字典  " + dict.getTypeEnname() + ":" + dict.getChname() + " 已存在; ");
							failureNum++;
						}
					} else {
						failureMsg.append("<br/>没有  " + dict.getTypeEnname() + " 字典类型; ");
						failureNum++;
					}
				} catch (ConstraintViolationException ex) {
					failureMsg.append("<br/>字典 " + dict.getChname() + " 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList) {
						failureMsg.append(message + "; ");
						failureNum++;
					}
				} catch (Exception ex) {
					failureMsg.append("<br/>字典 " + dict.getChname() + " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条数据，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条数据" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入数据失败！系统出现错误,请稍后重试!");
		}
		return "redirect:" + adminPath + "/sys/dict?repage";
	}
}
