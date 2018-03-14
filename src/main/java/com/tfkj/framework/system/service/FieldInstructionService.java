/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.FieldInstructionDao;
import com.tfkj.framework.system.entity.FieldInstruction;

/**
 * 字段提示Service
 *
 * @author sunxuelong
 */
@Service
@Transactional(readOnly = true)
public class FieldInstructionService extends CrudService<FieldInstructionDao, FieldInstruction> {

	/**
	 * 返回字段提示信息
	 *
	 * @param fieldInstruction
	 * @return Map<字段code,提示信息>
	 */
	public Map<String, String> findMap(FieldInstruction fieldInstruction) {

		List<FieldInstruction> fieldInstructionList = dao.findList(fieldInstruction);
		Map<String, String> fiMap = new HashMap<String, String>(16);
		for (FieldInstruction fi : fieldInstructionList) {
			fiMap.put(fi.getFieldCode(), fi.getInstruction());
		}
		return fiMap;
	}
	/**
     * 查询列表数据 无任何条件限制 用于导出使用
     * @return
     */
    public List<FieldInstruction> selectAll(FieldInstruction fieldInstruction) {
        return dao.selectAll(fieldInstruction);
    }
}
