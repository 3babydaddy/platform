package com.tfkj.business.assign.web;

import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.assign.entity.AssignSupervision;
import com.tfkj.business.assign.service.AssignSupervisionService;
import com.tfkj.business.specialReport.entity.SpecialReport;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.entity.MeetingTableData;
import com.tfkj.business.ywgl.entity.SuperiorInspect;
import com.tfkj.business.ywgl.service.MeetingService;
import com.tfkj.business.ywgl.service.SuperiorInspectService;
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
@RequestMapping(value = "${adminPath}/assign")
public class AssignSupervisionController extends BaseController {

	@Autowired
	private AssignSupervisionService insectionService;

	@Autowired
	private MeetingService meetingService;
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
//		model.addAttribute("superiorInspect", new SuperiorInspect());
		model.addAttribute("specialSupervision", new AssignSupervision());
		// return "system/table/tableIndex";
		return "business/assign/inspectionList";
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
		return "business/inspection/addTaskList";
	}

	/**
	 * @Title:
	 * @Description: 关联任务查看
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "findTask")
	public String findTask(String relationTask,Model model) {
		RelationPo relationPo = new RelationPo();
		relationPo.setId(relationTask);
		List<RelationPo> list = insectionService.findRelationList(relationPo);
		if (list!=null&&list.size()>0){
			String source = list.get(0).getSource();
			String parentId = list.get(0).getParentId();
			String id = list.get(0).getId();
			if (StringUtils.isNotBlank(source)&&"1".equals(source)){
				MeetingTableData table = meetingService.get(parentId);
				model.addAttribute("meetingTable", table);
				return "business/meeting/meetingForm";
			}else if ("2".equals(source)){
				SuperiorInspect superiorInspect = new SuperiorInspect();
				if (StringUtils.isNotBlank(id)) {
					superiorInspect = superiorInspectService.get(id);
				}
				model.addAttribute("superiorInspect", superiorInspect);
				return "business/superiorInspect/superiorInspectForm";
			}else{
				return null;
			}
		}else{
			return null;
		}
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
	public String exportExcel(String ids, Model model, AssignSupervision entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("INSPECTION_DATE");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("INSPECTION_DATE asc");
		}
		PageResult<AssignSupervision> pageResult=new PageResult<AssignSupervision>();
		String title = YwglConstants.EXPORT_EXCEL_NAME_JBDC;
		String fileName = title + DateUtils.getDate() + ".xls";
		try {
			pageResult = insectionService.findNoPage(entity, pageParam);
			List<AssignSupervision> list = pageResult.getRows();
			Integer[] fieldName={};
			if (StringUtils.isNotBlank(ids)) {
				List<AssignSupervision> likeEntityList = new ArrayList<AssignSupervision>();
				String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (AssignSupervision likeEntity : list) {
					if (idsList.contains(likeEntity.getId())) {
						likeEntityList.add(likeEntity);
					}
				}
				new ExportExcel2003(title, "", AssignSupervision.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
			} else {
				new ExportExcel2003(title, "", AssignSupervision.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
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
	 * @Description: 列表页
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "list" )
	@ResponseBody
	public PageResult<AssignSupervision> list(AssignSupervision table, Model model, HttpServletRequest request) {
		PageParam pageParam = new PageParam(request);
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("INSPECTION_DATE");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("INSPECTION_DATE asc");
		}
		PageResult<AssignSupervision> pageResult= insectionService.findPage(table, pageParam);
		return pageResult;
	}
	/**
	 * @Title: relationlist
	 * @Description: 列表页
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "relationlist" )
	@ResponseBody
	public PageResult<RelationPo> relationlist(RelationPo table, Model model, HttpServletRequest request) {
		PageResult<RelationPo> pageResult= new PageResult();
		List<RelationPo> list=insectionService.findRelationList(table);
		pageResult.setRows(list);
		pageResult.setTotal(list.size());
		return pageResult;
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
	public String form(AssignSupervision table, Model model) {

		if (StringUtils.isNotBlank(table.getId())){;
			AssignSupervision specialSupervision = insectionService.get(table.getId());
			String taskName = specialSupervision.getRelationTaskName();
			if (StringUtils.isBlank(taskName)){
				specialSupervision.setIsRelation("0");
				specialSupervision.setRelationTask("");
			}
				model.addAttribute("table", specialSupervision);
		}
		// return "system/table/tableForm";
		return "business/assign/inspectionForm";
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
	public Map<String,Object> get(AssignSupervision table, Model model) {
		Map<String , Object> map = new HashMap<>();
		if (StringUtils.isNotBlank(table.getId())){
			try{
				AssignSupervision specialSupervision = insectionService.get(table.getId());
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
	public Map<String , Object> save(AssignSupervision table, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			//后续跟踪不选  跟踪任务和跟踪情况为空
			if (StringUtils.isNotBlank(table.getIsTrack())&&!"Y".equals(table.getIsTrack())){
				table.setTrackTask("");
				table.setTrackSituation("");
			}
			insectionService.saveElement(table);
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
	public Map<String , Object> update(AssignSupervision table, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			insectionService.updateInspection(table);
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
					 AssignSupervision specialSupervision = new AssignSupervision();
					specialSupervision.setId(id);
					insectionService.saveElement(specialSupervision);
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
	public Map<String , Object> delete(AssignSupervision table, String ids, RedirectAttributes redirectAttributes) {
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
