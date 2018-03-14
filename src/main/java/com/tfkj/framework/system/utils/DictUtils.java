/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tfkj.business.instructions.dao.InstructionsSupervisionDao;
import com.tfkj.business.instructions.entity.InstructionsRelationPo;
import com.tfkj.business.ywgl.dao.InstructionsDao;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.framework.system.dao.LeaderDao;
import com.tfkj.framework.system.dao.OfficeDao;
import com.tfkj.framework.system.entity.Leader;
import com.tfkj.framework.system.entity.Office;
import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.tfkj.business.web.constants.Constants;
import com.tfkj.framework.core.mapper.JsonMapper;
import com.tfkj.framework.core.utils.CacheUtils;
import com.tfkj.framework.core.utils.SpringContextHolder;
import com.tfkj.framework.system.dao.DictDao;
import com.tfkj.framework.system.entity.Dict;
import org.aspectj.apache.bcel.generic.Instruction;

/**
 * 字典工具类
 *
 * @author ThinkGem
 * @version 2013-5-29
 */
public class DictUtils {

	private static DictDao dictDao = SpringContextHolder.getBean(DictDao.class);

	private static LeaderDao leaderDao = SpringContextHolder.getBean(LeaderDao.class);

	private static InstructionsDao instructionsDao = SpringContextHolder.getBean(InstructionsDao.class);

	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);

	private static InstructionsSupervisionDao supervisionDao = SpringContextHolder.getBean(InstructionsSupervisionDao.class);

	public static final String CACHE_DICT_MAP = "dictMap";

	/**
	 * @Title: getDictChnameList
	 * @Description: 根据id值与字典类型得到多选框中文
	 * @param @param ids ef:1,2,3
	 * @param @param dictType 字典类型
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getDictChnameList(String ids, String dictType) {

		if (StringUtils.isBlank(ids)) {
			return "";
		}
		StringBuilder str = new StringBuilder();
		str.append("");
		String[] idsArray = ids.split(",");
		for (int i = 0; i < idsArray.length; i++) {
			String dictChname = DictUtils.getDictChname(idsArray[i], dictType, "").trim();
			if (StringUtils.isNotBlank(dictChname)) {
				str.append(dictChname);
				str.append(";");
			}
		}
		return str.toString();
	}

	public static String getDictChname(String enname, String type, String defaultValue) {

		if (Constants.YW_ZJ_DICT_BSJ.equals(enname)) {
			return Constants.YW_ZJ_DICT_BSJ_CHNAME;
		}
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(enname)) {
			for (Dict dict : getDictList(type)) {
				if (type.equals(dict.getTypeEnname()) && enname.equals(dict.getEnname())) {
					return dict.getChname();
				}
			}
		}
		return defaultValue;
	}

	public static String getDictChnames(String values, String type, String defaultValue) {

		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(values)) {
			List<String> valueList = Lists.newArrayList();
			for (String value : StringUtils.split(values, ",")) {
				valueList.add(getDictChname(value, type, defaultValue));
			}
			return StringUtils.join(valueList, ",");
		}
		return defaultValue;
	}

	public static String getDictEnname(String chname, String type, String defaultChname) {

		if (Constants.YW_ZJ_DICT_BSJ_CHNAME.equals(chname)) {
			return Constants.YW_ZJ_DICT_BSJ;
		}
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(chname)) {
			for (Dict dict : getDictList(type)) {
				if (type.equals(dict.getTypeEnname()) && chname.equals(dict.getChname())) {
					return dict.getEnname();
				}
			}
		}
		return defaultChname;
	}
	public static String getOfficeName(String code) {
		String name = "";
		if (StringUtils.isNotBlank(code)){
			String[] list = code.split(",");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i <list.length ; i++) {
				String item = list[i];
				Office office= officeDao.get(item);
				if (office!=null){
					sb.append(office.getName());
					if (i!=list.length-1){
						sb.append(",");
					}
				}
			}
			name = sb.toString();
		}
		return name;
	}
	public static Map<String,String> getRelationName(String code) {
		String name = "";
		String ids = "";
		int num = 0;
;		if (StringUtils.isNotBlank(code)){
			String[] list = code.split(",");
			for (int i = 0; i < list.length ; i++) {
				String item = list[i];
				Instructions instructions= instructionsDao.get(item);
				if (instructions!=null){
					if (StringUtils.isNotBlank(ids)){
						ids+=",";
					}
					ids += item;
					num ++;
					if (StringUtils.isBlank(name)){
						name+=instructions.getIn0001();
					}
				}
			}
			if (num>1){
				name+="等"+num+"个批示件";
			}

		}
		Map<String,String> map = new HashMap<>();
		map.put("name",name);
		map.put("ids",ids);
		return map;
	}
	public static String getDictName(String code,String type) {
		String name = "";
		if (StringUtils.isNotBlank(code)){
			String[] list = code.split(",");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i <list.length ; i++) {
				String item = list[i];
				Dict dict = new Dict();
				dict.setEnname(item);
				dict.setTypeEnname(type);
				List<Dict> dictList= dictDao.findList(dict);
				if (dictList!=null&&dictList.size()>0){
					sb.append(dictList.get(0).getChname());
					if (i!=list.length-1){
						sb.append(",");
					}
				}
			}
			name = sb.toString();
		}
		return name;
	}

	public static String getLeadName(String code) {
		String name = "";
		if (StringUtils.isNotBlank(code)){
			String[] list = code.split(",");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i <list.length ; i++) {
				String item = list[i];
				Leader leaderParam=new Leader();
				leaderParam.setId(item);
				Leader leader= leaderDao.get(leaderParam);
				if (leader!=null){
					sb.append(leader.getL001());
					if (i!=list.length-1){
						sb.append(",");
					}
				}
			}
			name = sb.toString();
		}
		return name;
	}
	public static List<Dict> getDictList(String type) {

		@SuppressWarnings("unchecked")
		Map<String, List<Dict>> dictMap = (Map<String, List<Dict>>) CacheUtils.get(CACHE_DICT_MAP);
		if (dictMap == null) {
			dictMap = Maps.newHashMap();
			for (Dict dict : dictDao.findList(new Dict())) {
				List<Dict> dictList = dictMap.get(dict.getTypeEnname());
				if (dictList != null) {
					dictList.add(dict);
				} else {
					dictMap.put(dict.getTypeEnname(), Lists.newArrayList(dict));
				}
			}
			CacheUtils.put(CACHE_DICT_MAP, dictMap);
		}
		List<Dict> dictList = dictMap.get(type);
		if (dictList == null) {
			dictList = Lists.newArrayList();
		}
		return dictList;
	}

	/**
	 * 返回字典列表（JSON）
	 *
	 * @param type
	 * @return
	 */
	public static String getDictListJson(String type) {

		return JsonMapper.toJsonString(getDictList(type));
	}
}
