package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tfkj.business.ywgl.dao.YearTaskTableDao;
import com.tfkj.business.ywgl.dao.YearTaskTableElementDao;
import com.tfkj.business.ywgl.entity.YearTaskTableData;
import com.tfkj.business.ywgl.entity.YearTaskTableElement;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 年度重点任务督查
 * @author gaowei
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = false)
public class YearTaskService extends CrudService<YearTaskTableDao, YearTaskTableData> {

	@Autowired
	private YearTaskTableElementDao yearTaskTableElementDao;

	/**
	 * @Title: batchDelete
	 * @Description: 批量删除
	 * @param @param ids "id1,id2"
	 * @param @return 参数
	 * @return int 返回类型
	 * @throws
	 */
	public int batchDelete(String ids) {

		int delete = 0;
		String[] idsArray = ids.split(",");
		// 根据目标任务id--删除分解任务
		// 根据目标任务id--删除目标任务
		for (int i = 0; i < idsArray.length; i++) {
			YearTaskTableElement yearTaskTableElement = new YearTaskTableElement();
			yearTaskTableElement.setDataId(idsArray[i]);
			yearTaskTableElementDao.deleteByDataId(yearTaskTableElement);
			YearTaskTableData yearTaskTableData = new YearTaskTableData();
			yearTaskTableData.setId(idsArray[i]);
			int num = dao.delete(yearTaskTableData);
			delete += num;
		}
		return delete;
	}

	/**
	 * @Title: findListPage
	 * @Description: 自定义分页
	 * @param @param entity
	 * @param @param pageParam
	 * @param @return 参数
	 * @return PageResult<YearTaskTableElement> 返回类型
	 * @throws
	 */
	public PageResult<YearTaskTableElement> findListPage(YearTaskTableData entity, PageParam pageParam) {

		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		entity.getSqlMap().put("dsf", dataScopeFilter(entity.getCurrentUser(), "o", "u"));
		PageHelper.offsetPage(pageParam.getOffset(), pageParam.getLimit());
		if (!StringUtils.isBlank(pageParam.getOrderBy())) {
			PageHelper.orderBy(pageParam.getOrderBy());
		}
		List<YearTaskTableData> list = dao.findList(entity);
		PageResult<YearTaskTableElement> pageResult = new PageResult<YearTaskTableElement>();
		if (list == null || list.isEmpty()) {
			return pageResult;
		}
		String ids = "";
		for (YearTaskTableData target : list) {
			ids += target.getId() + ",";
		}
		String idsSql = StringUtils.strToSql(ids);
		List<YearTaskTableElement> elementList = dao.findElementListByDataIds(idsSql);
		PageInfo<YearTaskTableData> pageInfo = new PageInfo<YearTaskTableData>(list);
		pageResult.setTotal(pageInfo.getTotal());
		pageResult.setRows(elementList);
		return pageResult;
	}
}
