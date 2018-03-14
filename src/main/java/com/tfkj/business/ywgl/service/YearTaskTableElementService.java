package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.business.ywgl.dao.YearTaskTableElementDao;
import com.tfkj.business.ywgl.entity.YearTaskTableElement;
import com.tfkj.framework.core.service.CrudService;

/**
 * @Description: 年度重点任务督查
 * @author gaowei
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = false)
public class YearTaskTableElementService extends CrudService<YearTaskTableElementDao, YearTaskTableElement> {

	/**
	 * @Title: findListByTargetTaskId
	 * @Description: 根据目标任务ID查询分解任务
	 * @param @param targetTaskId
	 * @param @return 参数
	 * @return List<YearTaskTableElement> 返回类型
	 * @throws
	 */
	public List<YearTaskTableElement> findListByTargetTaskId(String targetTaskId) {

		List<YearTaskTableElement> list = dao.findListByDataId(targetTaskId);
		return list;
	}
}
