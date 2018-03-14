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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.pagehelper.StringUtil;
import com.tfkj.business.Inspection.entity.SpecialSupervision;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.entity.MeetingTableElement;
import com.tfkj.business.ywgl.entity.MeetingTableData;
import com.tfkj.business.ywgl.entity.MeetingTableElement;
import com.tfkj.business.ywgl.service.MeetingService;
import com.tfkj.framework.core.utils.DateUtils;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.ExportExcel2003;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 会议议定事项
 * @author gaowei
 * @date 2018年1月16日
 */
@Controller
@RequestMapping(value = "${adminPath}/ywgl/Meeting")
public class MeetingController extends BaseController {

	@Autowired
	private MeetingService MeetingSerice;

	/**
	 * @Title: index
	 * @Description: 进入index页
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "index", "" })
	public String index() {

		// return "system/table/tableIndex";
		return "business/meeting/meetingForm";
	}

	/**
	 * @Title: list
	 * @Description: 列表页
	 * @param @param MeetingTableData
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = { "list" })
	@ResponseBody
	public PageResult<MeetingTableElement>  list(MeetingTableElement table, Model model,HttpServletRequest request) {

		PageResult<MeetingTableElement> pageResul=MeetingSerice.findListPage(table,true, new PageParam(request));
		return pageResul;
	}

	/**
	 * 跳转列表页
	 * @return
	 */

	@RequestMapping(value = { "goList" })
	public String  goList(Model model) {
		model.addAttribute("meetingData", new MeetingTableElement());
		return "business/meeting/meetingList";
	}

	/**
	 * 跳转会议Form页
	 * @param table
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "goSingleMeetingForm" })
	public String goSingleMeetingForm(MeetingTableData table, Model model) {

		return "business/meeting/singleMeetingForm";
	}


	/**
	 * @Title: form
	 * @Description: 跳转到form页
	 * @param @param MeetingTableData
	 * @param @param model
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "form")
	public String form(String id, Model model) {

		MeetingTableData table = MeetingSerice.get(id);
		if(table.getMeetingTableElement()!=null&&table.getMeetingTableElement().size()==1){
			if(StringUtil.isEmpty(table.getMeetingTableElement().get(0).getId())){
				table.setMeetingTableElement(null);
			}
		}
		model.addAttribute("meetingTable", table);
		return "business/meeting/meetingForm";
	}

	/**
	 * @Title: save
	 * @Description: 保存 会议
	 * @param @param MeetingTableData
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveTableData")
	@ResponseBody
	public Map<String,String> save(MeetingTableData table, Model model, RedirectAttributes redirectAttributes) {
		Map<String,String> map=new HashMap<String, String>();
		/*try {*/
			MeetingSerice.save(table);
			map.put("id", table.getId());
			map.put("flag", "success");

		/*} catch (Exception e) {
			map.put("flag", "false");
		}*/
		return map;
	}

	/**
	 * @Title: save
	 * @Description: 保存议定事项
	 * @param @param MeetingTableData
	 * @param @param model
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "saveElement")
	@ResponseBody
	public Map<String,String> saveElement(MeetingTableElement table, Model model, RedirectAttributes redirectAttributes) {
		Map<String,String> map=new HashMap<String, String>();
		String elementId=MeetingSerice.saveElement(table);
		map.put("elementId", elementId);
		map.put("flag", "success");
		return map;

	}

	/**
	 * @Title: delete
	 * @Description: 删除议定事项
	 * @param @param MeetingTableData
	 * @param @param redirectAttributes
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "deleteMeetingElemnt")
	@ResponseBody
	public Map<String,String> deleteMeetingElemnt(String id ) {
		Map<String,String> map=new HashMap<String, String>();
		MeetingSerice.deleteElement(id);
		map.put("flag", "success");
		return null;
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
	}
	/**
	 * 删除会议
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "deleteMeeting")
	@ResponseBody
	public Map<String,String> deleteMeeting(String ids ) {
		Map<String,String> map=new HashMap<String, String>();
		MeetingSerice.deleteMeeting(ids);
		map.put("flag", "success");
		// return "redirect:" + adminPath + "/sys/table/list?repage&typeEnname=" + table.getTypeEnname();
		return map;
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
	public String exportExcel(String hiddenColumns,String ids, Model model, MeetingTableElement entity, PageParam pageParam, HttpServletRequest request, HttpServletResponse response, String viewName,RedirectAttributes redirectAttributes) throws IOException {
		String title = YwglConstants.EXPORT_EXCEL_NAME_HYYDSX;
		String fileName = title + DateUtils.getDate() + ".xls";
		PageResult<MeetingTableElement> pageResult = new PageResult<MeetingTableElement>();
		try {
			String isExcel = "isExcel";
			pageResult = MeetingSerice.findListPage(entity,false, new PageParam(request));
			List<MeetingTableElement> list = pageResult.getRows();
			Integer[] fieldName={0,1,2};
			if (StringUtils.isNotBlank(ids)) {
				List<MeetingTableElement> likeEntityList = new ArrayList<MeetingTableElement>();
					String[] idsArray = ids.split(",");
				List<String> idsList = Arrays.asList(idsArray);
				for (MeetingTableElement likeEntity : list) {
					if (idsList.contains(likeEntity.getParentId())) {
						likeEntityList.add(likeEntity);
					}
				}
				new ExportExcel2003(title, "", MeetingTableElement.class).setMulDataList(likeEntityList, "", fieldName,"parentId").write(response, fileName);
			} else {
				new ExportExcel2003(title, "", MeetingTableElement.class).setMulDataList(list, "",fieldName,"parentId").write(response, fileName);
			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出失败！失败信息：" + e.getMessage());
			model.addAttribute("browser", "");
			return null;
		}
	}
}
