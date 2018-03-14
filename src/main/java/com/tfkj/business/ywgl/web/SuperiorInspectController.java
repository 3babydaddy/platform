package com.tfkj.business.ywgl.web;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.entity.SuperiorInspect;
import com.tfkj.business.ywgl.service.SuperiorInspectService;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 上级督查
 * @author gaowei
 * @date 2018年1月24日
 */
@Controller
@RequestMapping(value = "${adminPath}/ywgl/superiorInspect")
public class SuperiorInspectController extends BaseController {

	@Autowired
	private SuperiorInspectService superiorInspectService;

	/**
	 * @Title: index
	 * @Description: 进入index页
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "index", "toList", "" })
	public String index(Model model) {

		SuperiorInspect superiorInspect = new SuperiorInspect();
		model.addAttribute("superiorInspect", superiorInspect);
		return "business/superiorInspect/superiorInspectList";
	}

	/**
	 * @Title: list
	 * @Description: 列表页
	 * @param @param superiorInspect
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<SuperiorInspect> list(SuperiorInspect entity, HttpServletRequest request) {

		PageResult<SuperiorInspect> pageResul = superiorInspectService.findPage(entity, new PageParam(request));
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

		SuperiorInspect superiorInspect = new SuperiorInspect();
		if (StringUtils.isNotBlank(id)) {
			superiorInspect = superiorInspectService.get(id);
		} else {
			// 督查类型
			superiorInspect.setInspectType("01");
			// 落实状态
			superiorInspect.setTaskState("02");
		}
		model.addAttribute("superiorInspect", superiorInspect);
		return "business/superiorInspect/superiorInspectForm";
	}

	/**
	 * @Title: save
	 * @Description: form表单-保存
	 * @param @param superiorInspect
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "save")
	public String save(SuperiorInspect entity, Model model, RedirectAttributes redirectAttributes) {

		superiorInspectService.saveForm(entity);
		addMessage(redirectAttributes, "保存任务成功!");
		return "redirect:" + adminPath + "/ywgl/superiorInspect/index";
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

		int batchDelete = superiorInspectService.batchDelete(ids);
		if (batchDelete > 0) {
			addMessage(redirectAttributes, "删除任务成功！");
		} else {
			addMessage(redirectAttributes, "删除任务失败！");
		}
		return "redirect:" + adminPath + "/ywgl/superiorInspect/toList";
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
	public String exportExcel(String ids, Model model, SuperiorInspect entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, String viewName,RedirectAttributes redirectAttributes) throws IOException {
		String title = YwglConstants.EXPORT_EXCEL_NAME_SJLWQDC;
		String fileName = title + DateUtils.getDate() + ".xls";
		PageResult<SuperiorInspect> pageResult = new PageResult<SuperiorInspect>();
		try {
			pageResult = superiorInspectService.findNoPage(entity, new PageParam(request));
			List<SuperiorInspect> list = pageResult.getRows();
			Integer[] fieldName={};
			if (StringUtils.isNotBlank(ids)) {
				List<SuperiorInspect> likeEntityList = new ArrayList<SuperiorInspect>();
					String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (SuperiorInspect likeEntity : list) {
					if (idsList.contains(likeEntity.getId())) {
						likeEntityList.add(likeEntity);
					}
				}
				new ExportExcel2003(title, "", SuperiorInspect.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
			} else {
				new ExportExcel2003(title, "", SuperiorInspect.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			model.addAttribute("browser", "");
			return null;
		}
	}
}
