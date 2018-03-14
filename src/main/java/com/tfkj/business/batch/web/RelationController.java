package com.tfkj.business.batch.web;

import com.tfkj.business.batch.entity.Relation;
import com.tfkj.business.batch.service.RelationService;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018�?1�?16�?
 */
@Controller
@RequestMapping(value = "${adminPath}/relation")
public class RelationController extends BaseController {

	@Autowired
	private RelationService insectionService;

	/**
	 * @Title: index
	 * @Description: 进入index�?
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "index", "toList", "" })
	public String index(Model model) {
//		model.addAttribute("superiorInspect", new SuperiorInspect());
		model.addAttribute("specialSupervision", new Relation());
		// return "system/table/tableIndex";
		return "business/relation/inspectionList";
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
	 * @Title: list
	 * @Description: 列表�?
	 * @param @param SpecialSupervision
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "list" )
	@ResponseBody
	public PageResult<InstructionsElement> list(Instructions  table, Model model, HttpServletRequest request) {
		PageParam pageParam = new PageParam(request);
//		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
//			pageParam.setSort("INSPECTION_DATE");
//			pageParam.setOrderBy("asc");
//			pageParam.setOrderBy("INSPECTION_DATE asc");
//		}
		request.setAttribute("type",table.getType());
		PageResult<InstructionsElement> pageResult= insectionService.findListPage(table, true,pageParam);
		return pageResult;
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
	public Map<String , Object> save(Relation table, Model model, RedirectAttributes redirectAttributes) {
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
	public Map<String , Object> update(Relation table, Model model, RedirectAttributes redirectAttributes) {
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
	public Map<String , Object> delete(Relation table, String ids, RedirectAttributes redirectAttributes) {
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
		String title = YwglConstants.EXPORT_EXCEL_NAME_PSJCB;
		String fileName = title + DateUtils.getDate() + ".xls";
		PageResult<InstructionsElement> pageResult = new PageResult<InstructionsElement>();
		try {
			String isExcel = "isExcel";
			PageParam pageParam1 = new PageParam(request);
			request.setAttribute("type",entity.getType());
			pageResult= insectionService.findListPage(entity,false, pageParam1);
			List<InstructionsElement> list = pageResult.getRows();
			Integer[] fieldName={0,1,2};
			if (StringUtils.isNotBlank(ids)) {
				List<InstructionsElement> likeEntityList = new ArrayList<InstructionsElement>();
					String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (InstructionsElement likeEntity : list) {
					if (idsList.contains(likeEntity.getUnqId())) {
						likeEntityList.add(likeEntity);
					}
				}
				if(entity.getRelationType().equals("2")){
					new ExportExcel2003(title, "2", InstructionsElement.class).setMulDataList(likeEntityList, "2", fieldName,"unqId").write(response, fileName);
				}else{
					new ExportExcel2003(title, "1", InstructionsElement.class).setMulDataList(likeEntityList, "1", fieldName,"unqId").write(response, fileName);
				}
			} else {
				if(entity.getRelationType().equals("2")){
					new ExportExcel2003(title, "2", InstructionsElement.class).setMulDataList(list, "2",fieldName,"unqId").write(response, fileName);
				}else{
					new ExportExcel2003(title, "1", InstructionsElement.class).setMulDataList(list, "1",fieldName,"unqId").write(response, fileName);
				}
			}
			return null;
			} catch (Exception e) {
				addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
				model.addAttribute("browser", "");
				return null;
			}
  	}
}
