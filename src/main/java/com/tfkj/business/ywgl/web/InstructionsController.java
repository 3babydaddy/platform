package com.tfkj.business.ywgl.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.business.ywgl.service.InstructionsElementService;
import com.tfkj.business.ywgl.service.InstructionsService;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 批示件
 * @author gaowei
 * @date 2018年1月30日
 */
@Controller
@RequestMapping(value = "${adminPath}/ywgl/instructions")
public class InstructionsController extends BaseController {

	@Autowired
	private InstructionsService instructionsService;

	@Autowired
	private InstructionsElementService instructionsElementService;

	/**
	 * 跳转列表页
	 *
	 * @return
	 */
	@RequestMapping(value = { "index" })
	public String index(Model model) {

		Instructions query = new Instructions();
		model.addAttribute("query", query);
		return "business/instructions/instructionsList";
	}

	/**
	 * @Title:
	 * @Description: 关联页面
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "addSpecialReportList")
	public String addSpecialReportList(String ids, Model model) {

		model.addAttribute("parentIds", ids);
		return "business/instructions/addSpecialReportList";
	}

	/**
	 * @Title: relate
	 * @Description: 关联专报
	 * @param @param parentIds
	 * @param @param relateId
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "relate")
	public String relate(String parentIds, String relateId, Model model) {

		instructionsService.relate(parentIds, relateId);
		return "redirect:" + adminPath + "/ywgl/instructions/index";
	}

	/**
	 * @Title: list
	 * @Description: 分页数据
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<InstructionsElement> list(Instructions entity, HttpServletRequest request) {

		PageResult<InstructionsElement> pageResul = instructionsElementService.findListPage(entity,true, new PageParam(request));
		return pageResul;
	}
	/**
	 * @throws IOException
	 * @Title: ryxxExportExcel
	 * @Description: 查询条件导出列表
	 * @param @param model
	 * @param @param cxtj
	 * @param @param request
	 * @param @param response
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "exportExcel")
	public String exportExcel(String hiddenColumns,String ids, Model model, Instructions entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, String viewName,RedirectAttributes redirectAttributes) throws IOException {
		String title = YwglConstants.EXPORT_EXCEL_NAME_PSJ;
		String fileName = title + DateUtils.getDate() + ".xls";
		PageResult<InstructionsElement> pageResult = new PageResult<InstructionsElement>();
		try {
			String isExcel = "isExcel";
			pageResult = instructionsElementService.findListPage(entity,false, new PageParam(request));
			List<InstructionsElement> list = pageResult.getRows();
			Integer[] fieldName={0,1,2,3,4,5,6,7,8,9,10,17};
			if (StringUtils.isNotBlank(ids)) {
				List<InstructionsElement> likeEntityList = new ArrayList<InstructionsElement>();
					String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (InstructionsElement likeEntity : list) {
					if (idsList.contains(likeEntity.getDataId())) {
						likeEntityList.add(likeEntity);
					}
				}
				new ExportExcel2003(title, "3", InstructionsElement.class).setMulDataList(likeEntityList, "3", fieldName,"dataId").write(response, fileName);
			} else {
				new ExportExcel2003(title, "3", InstructionsElement.class).setMulDataList(list, "3",fieldName,"dataId").write(response, fileName);
			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			model.addAttribute("browser", "");
			return null;
		}
	}
	/**
	 * @Title: list
	 * @Description: 不分页查询数据
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "noPagelist" })
	@ResponseBody
	public PageResult<Instructions> noPagelist(Instructions entity, HttpServletRequest request) {
		PageResult<Instructions> pageResul = instructionsElementService.findListNoPage(entity, new PageParam(request));
		return pageResul;
	}

	/**
	 * @Title: form
	 * @Description: 跳转编辑页
	 * @param @param id
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "form")
	public String form(String id, Model model) {

		Instructions instructions = instructionsService.get(id);
		if (instructions == null) {
			instructions = new Instructions();
			instructions.setIn0016("01");
			instructions.setIn0017("01");
		}
		model.addAttribute("entity", instructions);
		return "business/instructions/instructionsForm";
	}

	/**
	 * @Title: save
	 * @Description: 保存表单
	 * @param @param table
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return Map<String,String> 返回类型
	 * @throws
	 */
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, String> save(Instructions table, Model model, RedirectAttributes redirectAttributes) {

		Map<String, String> map = new HashMap<String, String>();
		try {
			instructionsService.saveForm(table);
			map.put("id", table.getId());
			map.put("flag", "success");
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return map;
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

		int batchDelete = instructionsService.batchDelete(ids);
		if (batchDelete > 0) {
			addMessage(redirectAttributes, "删除任务成功！");
		} else {
			addMessage(redirectAttributes, "删除任务失败！");
		}
		return "redirect:" + adminPath + "/ywgl/instructions/index";
	}
}
