package com.tfkj.business.familyMatters.web;

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

import com.tfkj.business.familyMatters.entity.AfterBurialExport;
import com.tfkj.business.familyMatters.entity.AfterMarriageExport;
import com.tfkj.business.familyMatters.entity.FamilyMatters;
import com.tfkj.business.familyMatters.service.FamilyMattersService;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * 家庭重大事项登记管理
 * @author waixie011
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/familyMatters")
public class FamilyMattersController extends BaseController {

	@Autowired
	private FamilyMattersService familyMattersService;
	
	/**
	 * 婚嫁事前登记列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "index", "toList", "" })
	public String index(Model model) {
		model.addAttribute("familyMatters", new FamilyMatters());
		return "business/familyMatters/beforeMarriageList";
	}
	
	/**
	 * 婚嫁事后登记列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "afterMarriageIndex", "toAfterMarriageList", "" })
	public String afterMarriageIndex(Model model) {
		model.addAttribute("familyMatters", new FamilyMatters());
		return "business/familyMatters/afterMarriageList";
	}
	
	/**
	 * 丧葬事后登记列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "afterBurialIndex", "toAfterBurialList", "" })
	public String afterBurialIndex(Model model) {
		model.addAttribute("familyMatters", new FamilyMatters());
		return "business/familyMatters/afterBurialList";
	}
	
	/**
	 * 条件查询
	 * @param table
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "list")
	@ResponseBody
	public PageResult<FamilyMatters> list(FamilyMatters table, Model model, HttpServletRequest request) {
		PageParam pageParam = new PageParam(request);
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("fr_feteTime");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("fr_feteTime asc");
		}
		PageResult<FamilyMatters> pageResult = familyMattersService.findPage(table, pageParam);
		return pageResult;
	}
	
	/**
	 * 婚嫁事前登记表单
	 * @param table
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "form")
	public String form(FamilyMatters table, Model model) {
		if (StringUtils.isNotBlank(table.getId())){
			FamilyMatters familyMatters = familyMattersService.get(table.getId());
			model.addAttribute("table", familyMatters);
		}
		return "business/familyMatters/beforeMarriageForm";
	}
	
	/**
	 * 婚嫁事后登记表单
	 * @param table
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "afterMarriageForm")
	public String afterMarriageForm(FamilyMatters table, Model model) {
		if (StringUtils.isNotBlank(table.getId())){
			FamilyMatters familyMatters = familyMattersService.get(table.getId());
			model.addAttribute("table", familyMatters);
		}
		return "business/familyMatters/afterMarriageForm";
	}
	
	/**
	 * 丧葬事后登记表单
	 * @param table
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "afterBurialForm")
	public String afterBurialForm(FamilyMatters table, Model model) {
		if (StringUtils.isNotBlank(table.getId())){
			FamilyMatters familyMatters = familyMattersService.get(table.getId());
			model.addAttribute("table", familyMatters);
		}
		return "business/familyMatters/afterBurialForm";
	}
	
	/**
	 * 保存修改合用方法，id为空时保存，id不为空时修改
	 * @param table
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, Object> save(FamilyMatters table, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			if(StringUtils.isNotBlank(table.getId())){
				FamilyMatters familyMatters = familyMattersService.get(table.getId());
				if(familyMatters != null && familyMatters.getId() != null && !"".equals(familyMatters.getId())){
					familyMattersService.updateFamilyMatters(table);
				}
			}else{
				familyMattersService.save(table);
			}
			map.put("id",table.getId());
			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		return map;
	}
	
	/**
	 * 删除
	 * @param table
	 * @param ids
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String , Object> delete(FamilyMatters table, String ids, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			if (StringUtils.isNotBlank(ids)){
				String[] array = ids.split(",");
				for (int i = 0; i <array.length ; i++) {
					table.setId(array[i]);
					familyMattersService.delete(table);
				}
			}
			map.put("success","1");
		}catch (Exception e){
			map.put("success","0");
		}
		return map;
	}
	
	/**
	 * 导出台账
	 * @param hiddenColumns
	 * @param ids
	 * @param model
	 * @param entity
	 * @param pageParam
	 * @param request
	 * @param response
	 * @param viewName
	 * @param redirectAttributes
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "exportExcel")
	public String exportExcel(String hiddenColumns,String ids, Model model, FamilyMatters entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, String viewName,RedirectAttributes redirectAttributes) throws IOException {
		String title = YwglConstants.EXPORT_EXCEL_NAME_FAMILYMATTERS;
		String fileName = title + DateUtils.getDate() + ".xls";
		PageResult<FamilyMatters> pageResult = new PageResult<FamilyMatters>();
		try {
			PageParam pageParam1 = new PageParam(request);
			if (pageParam1.getSort()==null||"".equals(pageParam.getSort())){
				pageParam1.setSort("fr_feteTime");
				pageParam1.setOrderBy("asc");
				pageParam1.setOrderBy("fr_feteTime asc");
			}
			pageResult = familyMattersService.findNoPage(entity, pageParam1);
			List<FamilyMatters> list = pageResult.getRows();
			Integer[] fieldName={};
			if (StringUtils.isNotBlank(ids)) {
				List<FamilyMatters> likeEntityList = new ArrayList<FamilyMatters>();
				String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (FamilyMatters likeEntity : list) {
					if (idsList.contains(likeEntity.getId())) {
						likeEntityList.add(likeEntity);
					}
				}
				if("0".equals(entity.getType())){
					new ExportExcel2003(title, "", FamilyMatters.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
				}else if("1".equals(entity.getType())){
					new ExportExcel2003(title, "", AfterMarriageExport.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
				}else{
					new ExportExcel2003(title, "", AfterBurialExport.class).setMulDataList(likeEntityList, "", fieldName,"id").write(response, fileName);
				}
			} else {
				if("0".equals(entity.getType())){
					new ExportExcel2003(title, "", FamilyMatters.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
				}else if("1".equals(entity.getType())){
					new ExportExcel2003(title, "", AfterMarriageExport.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
				}else{
					new ExportExcel2003(title, "", AfterBurialExport.class).setMulDataList(list, "",fieldName,"id").write(response, fileName);
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
