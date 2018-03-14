package com.tfkj.business.batch.web;

import com.tfkj.business.batch.entity.Relation;
import com.tfkj.business.batch.entity.Reminders;
import com.tfkj.business.batch.service.RelationService;
import com.tfkj.business.batch.service.RemindersService;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.business.ywgl.service.InstructionsElementService;
import com.tfkj.business.ywgl.service.InstructionsService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.BaseController;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;
import net.sf.cglib.beans.BeanMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@Controller
@RequestMapping(value = "${adminPath}/reminders")
public class RemindersController extends BaseController {

	@Autowired
	private RemindersService insectionService;

	@Autowired
	private InstructionsService insectionsService;

	@Autowired
	private InstructionsElementService instructionsElementService;


	@Autowired
	private RelationService relationService;

	@Autowired
	private RemindersService remindersService;
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
		model.addAttribute("query", new Instructions());
		model.addAttribute("type","1");
		// return "system/table/tableIndex";
		return "business/batch/inspectionList";
	}
	/**
	 * @Title:
	 * @Description: addTaskList页面
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "addUrge")
	public String addUrge(String ids,Model model) {

		ArrayList<Map<String,String>> leadlist = new ArrayList();
		ArrayList<Map<String,String>> dwlist = new ArrayList();
		if (StringUtils.isNotBlank(ids)){
			String[] array = ids.split(",");
			for (int i=0;i<array.length;i++){
				String item = array[i];
				Instructions instructions = insectionsService.get(item);
				InstructionsElement instructionsElement = new InstructionsElement();
				instructionsElement.setDataId("'"+instructions.getId()+"'");
				instructionsElement.setParentIn0012("01");
				List<InstructionsElement> instructionsElementList= instructionsElementService.findListElement(instructionsElement);
				for (InstructionsElement element : instructionsElementList) {
					Map<String,String> map = new HashMap<>();
					if ("1".equals(element.getType())){
						map.put("type","1name");
						Boolean flag = true ;
						if (element!=null){
							for (int j = 0; j <leadlist.size() ; j++) {
								Map<String,String> m = leadlist.get(j);
								if (element!=null&&m!=null&&m.get("name").equals(element.getParentIn0010Text())){
									leadlist.remove(m);
									map.put("id",m.get("id")+","+"1"+element.getId());
									map.put("name",element.getParentIn0010Text());
									flag= false;
								}
							}
							if (flag){
								map.put("id","1"+element.getId());
								map.put("name",element.getParentIn0010Text());
							}
						}
						leadlist.add(map);
					}else if ("2".equals(element.getType())){
						map.put("type","2name");
						Boolean flag = true ;
						if (element!=null) {
							for (int j = 0; j <dwlist.size() ; j++) {
								Map<String,String> m = dwlist.get(j);
								if (m.get("name").equals(element.getParentIn0009Text())) {
									dwlist.remove(m);
									map.put("id", m.get("id") + "," + "2" + element.getId());
									map.put("name", element.getParentIn0009Text());
									flag = false;
								}
							}

							if (flag) {
								map.put("id", "2" + element.getId());
								map.put("name", element.getParentIn0009Text());
							}
						}
						dwlist.add(map);
					}

				}
			}
		}
		model.addAttribute("dwlist", dwlist);
		model.addAttribute("leadlist", leadlist);
		// return "system/table/tableIndex";
		return "business/batch/addTaskList";
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
	public PageResult<Reminders> list(Reminders table, Model model, HttpServletRequest request) {
		PageParam pageParam = new PageParam(request);
		if (pageParam.getSort()==null||"".equals(pageParam.getSort())){
			pageParam.setSort("INSPECTION_DATE");
			pageParam.setOrderBy("asc");
			pageParam.setOrderBy("INSPECTION_DATE asc");
		}
		PageResult<Reminders> pageResult= insectionService.findPage(table, pageParam);
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
	public String form(String id,String relationType, Model model) {

		if (StringUtils.isNotBlank(id)){
			InstructionsElement instructionsElement = new InstructionsElement();
			instructionsElement.setUnqId("'"+id+"'");
			instructionsElement.setRelationType(relationType);
			List<InstructionsElement> listElement = relationService.findAllList(instructionsElement);
			if(listElement.size()>0){
				model.addAttribute("unqId", listElement.get(0).getUnqId());
				model.addAttribute("type", listElement.get(0).getType());
				model.addAttribute("listElement", listElement);
				model.addAttribute("remindersDate", listElement.get(0).getRemindersDate());
				model.addAttribute("leaderName", listElement.get(0).getParentIn0010Text());
				model.addAttribute("leaderId", listElement.get(0).getLeaderId());
				model.addAttribute("officeId", listElement.get(0).getOfficeId());
				model.addAttribute("officeName", listElement.get(0).getParentIn0009Text());
			}
		}
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
	@RequestMapping(value = "get")
	@ResponseBody
	public Map<String,Object> get(Reminders table, Model model) {
		Map<String , Object> map = new HashMap<>();
		if (StringUtils.isNotBlank(table.getId())){
			try{
				Reminders specialSupervision = insectionService.get(table.getId());
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
	@RequestMapping(value = "update")
	@ResponseBody
	public Map<String , Object> update(String list, Model model, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			String array =list.replaceAll("&quot;","");
			JSONArray jsonArray = new JSONArray(array);
			Set<String> idSet = new HashSet<>();
			if (jsonArray.length()>0){
				JSONObject jsonObject = jsonArray.getJSONObject(0);

				Iterator iterator = jsonObject.keys();
				while(iterator.hasNext()){
					String key = (String) iterator.next();
					if (key.length()>32){
						String eId = key.substring(key.length()-32,key.length());
						idSet.add(eId);
					}
				}
				for (String item:idSet){
					InstructionsElement element = new InstructionsElement();
					element.setId(item);
					Iterator it = jsonObject.keys();
					while(it.hasNext()){
						String key = (String) it.next();
						String value = jsonObject.getString(key).toString();
						if (key.indexOf(item)!=-1){
							if (key.indexOf("in0003")!=-1){
								element.setIn0003(value);
							}
							if (key.indexOf("in0002")!=-1){
								element.setIn0002(value);
							}
							if (key.indexOf("in0004")!=-1){
								element.setIn0004(value);
							}
						}
					}
					instructionsElementService.updateElement(element);
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
	 * @Title: saveSort
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
	public Map<String , Object> save(String list,String remindersDate) {
		Map<String , Object> map = new HashMap<>();
		try {
			String[] array =list.split(",");
			String remId = "";
			if (array.length>0){
				for (int i = 0; i <array.length ; i++) {
					String code = array[i];
					String type = code.substring(0,1);
					String id = code.substring(1,code.length());
					 Relation specialSupervision = new Relation();
					specialSupervision.setRemindersDate(remindersDate);
					specialSupervision.setPzId(id);
					List relationList=relationService.findRelationList(specialSupervision);
					if (relationList.size()==0){
						if (remId==""){
							Reminders reminders = new Reminders();
							reminders.setRemindersDate(remindersDate);
							reminders.setType(type);
							remindersService.save(reminders);
							remId = reminders.getId();
						}


						specialSupervision.setCbId(remId);
						specialSupervision.setType(type);
						relationService.save(specialSupervision);
						InstructionsElement instructionsElement=instructionsElementService.get(id);

						if (instructionsElement!=null){
							String date = instructionsElement.getIn0001();
							if (StringUtils.isNotBlank(date)){
								date+=","+remindersDate;
							}else {
								date=remindersDate;
							}
							instructionsElement.setIn0001(date);
							instructionsElementService.updateElement(instructionsElement);
						}
					}
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
	public Map<String , Object> delete(Reminders table,String relationType, String ids, RedirectAttributes redirectAttributes) {
		Map<String , Object> map = new HashMap<>();
		try {
			if (StringUtils.isNotBlank(ids)){
				String[] array = ids.split(",");
				for (int i = 0; i <array.length ; i++) {
					String item = array[i];
					InstructionsElement element = new InstructionsElement();
					element.setUnqId("'"+item+"'");
					element.setRelationType(relationType);
					List<InstructionsElement> list = relationService.findAllList(element);
					if (list!=null&&list.size()>0){
						for (InstructionsElement instructionsElement:list){
							relationService.deleteRelation(instructionsElement);
							InstructionsElement insElement=instructionsElementService.get(instructionsElement.getId());
							String remindersDate = instructionsElement.getRemindersDate();
							String date = insElement.getIn0001();
							date = date.replaceAll(","+remindersDate,"");
							date = date.replaceAll(remindersDate+",","");
							date = date.replaceAll(remindersDate,"");
							instructionsElement.setIn0001(date);
							instructionsElementService.updateElement(instructionsElement);
						}
					}
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
