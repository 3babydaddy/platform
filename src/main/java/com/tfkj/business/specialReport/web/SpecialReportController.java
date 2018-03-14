package com.tfkj.business.specialReport.web;

import com.tfkj.business.instructions.entity.InstructionsSupervision;
import com.tfkj.business.specialReport.entity.SpecialReport;
import com.tfkj.business.specialReport.service.SpecialReportService;
import com.tfkj.business.track.entity.TrackSupervision;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@Controller
@RequestMapping(value = "${adminPath}/specialReport")
public class SpecialReportController extends BaseController {

	@Autowired
	private SpecialReportService insectionService;
	/**
	 * @Title: index
	 * @Description: 进入index页
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "index", "toList", "" })
	public String index(Model model) {
//		model.addAttribute("superiorInspect", new SuperiorInspect());
		model.addAttribute("specialReport", new SpecialReport());
		// return "system/table/tableIndex";
		return "business/specialReport/inspectionList";
	}
	/**
	 * @Title:
	 * @Description: addTaskList页面
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "addTaskList")
	public String addTaskList(String id,Model model) {
		model.addAttribute("id", id);
		// return "system/table/tableIndex";
		return "business/specialReport/addTaskList";
	}

	/**
	 * @Title: list
	 * @Description: 列表页
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "list" )
	@ResponseBody
	public PageResult<SpecialReport> list(SpecialReport table, Model model, HttpServletRequest request) {
		PageParam pageParam = new PageParam(request);
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("LSSUE_DATE");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("LSSUE_DATE asc");
		}
		PageResult<SpecialReport> pageResult= insectionService.findPage(table, pageParam);
		return pageResult;
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
	public String exportExcel(String ids, Model model, SpecialReport entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("LSSUE_DATE");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("LSSUE_DATE asc");
		}
		PageResult<SpecialReport> pageResult=new PageResult<SpecialReport>();
		String title = YwglConstants.EXPORT_EXCEL_NAME_SPECIAL_REPORT;
		String fileName = title + DateUtils.getDate() + ".xls";
		try {
			pageResult = insectionService.findNoPage(entity,pageParam);
			List<SpecialReport> list = pageResult.getRows();
			Integer[] fieldName={};
			if (StringUtils.isNotBlank(ids)) {
				List<SpecialReport> likeEntityList = new ArrayList<SpecialReport>();
				String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (SpecialReport likeEntity : list) {
					if (idsList.contains(likeEntity.getId())) {
						likeEntityList.add(likeEntity);
					}
				}
				new ExportExcel2003(title, "", SpecialReport.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
			} else {
				new ExportExcel2003(title, "", SpecialReport.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			model.addAttribute("browser", "");
			return null;
		}
	}
	@RequestMapping(value = "urgeForm")
	public String urgeForm(SpecialReport table, Model model) {
		InstructionsSupervision specialSupervision =new InstructionsSupervision();
		model.addAttribute("table", specialSupervision);
		// return "system/table/tableForm";
		return "business/urgeReport/inspectionForm";
	}
	/**
	 * @Title: form
	 * @Description: 跳转到form页
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "form")
	public String form(SpecialReport table, Model model) {

		if (StringUtils.isNotBlank(table.getId())){;
			SpecialReport specialSupervision = insectionService.get(table.getId());
				model.addAttribute("table", specialSupervision);
		}
		// return "system/table/tableForm";
		return "business/specialReport/inspectionForm";
	}
	/**
	 * @Title: form
	 * @Description: 跳转到form页
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "get")
	@ResponseBody
	public Map<String,Object> get(SpecialReport table, Model model) {
		Map<String , Object> map = new HashMap<>();
		if (StringUtils.isNotBlank(table.getId())){
			try{
				SpecialReport specialSupervision = insectionService.get(table.getId());
					map.put("table",specialSupervision );
					map.put("success",1);

			}catch (Exception e){
				map.put("success",0);
			}
		}
		// return "system/table/tableForm";
		return map;
	}
	/**
	 * @Title: save
	 * @Description: 保存
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String , Object> save(SpecialReport table, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			insectionService.save(table);
			map.put("id",table.getId());
			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
		return map;
	}

	/**
	 * @Title: save
	 * @Description: 保存
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "update")
	@ResponseBody
	public Map<String , Object> update(SpecialReport table, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			insectionService.save(table);
			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
		return map;
	}
	/**
	 * @Title: saveSort
	 * @Description: 保存
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveSort")
	@ResponseBody
	public Map<String , Object> saveSort(String sortlist) {
		Map<String , Object> map = new HashMap<>();
		try {
			String list =sortlist.replaceAll("&quot;","");
			JSONArray jsonArray = new JSONArray(list);
			if (jsonArray.length()>0){
				for (int i = 0; i <jsonArray.length() ; i++) {
					String id = jsonArray.getJSONObject(i).get("id").toString()+"";
					 SpecialReport specialSupervision = new SpecialReport();
					specialSupervision.setId(id);
					insectionService.save(specialSupervision);
				}
			}

			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
		return map;
	}

	/**
	 * @Title: delete
	 * @Description: 删除
	 * @param @param SpecialSupervision
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String , Object> delete(SpecialReport table, String ids, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			if (StringUtils.isNotBlank(ids)){

				String[] array = ids.split(",");
				for (int i = 0; i <array.length ; i++) {
					table.setId(array[i]);
					insectionService.delete(table);
				}
			}
			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		return map;
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
	}
}
