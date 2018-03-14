package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.StringUtil;
import com.tfkj.business.ywgl.dao.InstructionsDao;
import com.tfkj.business.ywgl.dao.InstructionsElementDao;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 批示件
 * @author gaowei
 * @date 2018年1月30日
 */
@Service
@Transactional(readOnly = false)
public class InstructionsElementService extends CrudService<InstructionsElementDao, InstructionsElement> {

	@Autowired
	private InstructionsDao instructionsDao;

	@Autowired
	private InstructionsElementDao instructionsElementDao;

	/**
	 * @Title: findListByDataId
	 * @Description: 根据父级id查询子元素
	 * @param @param dataId
	 * @param @return 参数
	 * @return List<InstructionsElement> 返回类型
	 * @throws
	 */
	public List<InstructionsElement> findListByDataId(String dataId) {

		return dao.findListByDataId(dataId);
	}

	public List<InstructionsElement> findOneElement(InstructionsElement dataId) {

		return dao.findOneElement(dataId);
	}

	public List<InstructionsElement> findListElement(InstructionsElement dataId) {

		return dao.findPageList(dataId);
	}

	public void updateElement(InstructionsElement dataId) {

		 instructionsElementDao.updateElement(dataId);
	}

	public void updateElementOfficeLeader(InstructionsElement dataId) {

		instructionsElementDao.updateElementOfficeLeader(dataId);
	}
	/**
	 * 不分页查询
	 *
	 * @param entity
	 * @param pageParam
	 * @return
	 */
	public PageResult<Instructions> findListNoPage(Instructions entity, PageParam pageParam) {
		if (!StringUtils.isBlank(pageParam.getOrderBy())) {
			PageHelper.orderBy(pageParam.getOrderBy());
		}
		PageInfo<Instructions> pageInfo = new PageInfo<Instructions>(instructionsDao.findListInstruction(entity));
		PageResult<Instructions> pageResult = new PageResult<Instructions>();
		pageResult.setTotal(pageInfo.getTotal());
		List<Instructions> list = pageInfo.getList();
		pageResult.setRows(list);
		return pageResult;
	}

	/**
	 * 查询分页数据
	 *
	 * @param entity
	 * @param pageParam
	 * @return
	 */
	public PageResult<InstructionsElement> findListPage(Instructions entity,Boolean isPage, PageParam pageParam) {
		if(isPage){
			// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
			entity.getSqlMap().put("dsf", dataScopeFilter(entity.getCurrentUser(), "o", "u"));
			PageHelper.offsetPage(pageParam.getOffset(), pageParam.getLimit());
		}
		if (!StringUtils.isBlank(pageParam.getOrderBy())) {
			PageHelper.orderBy(pageParam.getOrderBy());
		}
		PageInfo<Instructions> pageInfo = new PageInfo<Instructions>(instructionsDao.findIdsList(entity));
		PageResult<InstructionsElement> pageResult = new PageResult<InstructionsElement>();
		pageResult.setTotal(pageInfo.getTotal());
		List<Instructions> list = pageInfo.getList();
		String ids = "";
		for (Instructions data : list) {
			ids += "'" + data.getId() + "'" + ",";
		}
		if (StringUtil.isNotEmpty(ids)) {
			ids = ids.substring(0, ids.length() - 1);
		}
		if (StringUtil.isEmpty(ids)) {
			ids = "''";
		}
		InstructionsElement ele = new InstructionsElement();
		// 数据关联ID
		ele.setDataId(ids);
		// 责任领导
		ele.setLeaderIds(entity.getLeaderIds());
		// 是否超期
		ele.setIn0003(entity.getIn0012());
		// 承办单位
		ele.setOfficeIds(entity.getOfficeIds());
		// 办理情况
		ele.setIn0002(entity.getIn0013());
		// 落实及上报情况
		ele.setIn0004(entity.getIn0014());
		//批示时间
		ele.setParentIn0004Start(entity.getIn0004Start());
		ele.setParentIn0004End(entity.getIn0004End());
		//文件名
		ele.setIn0001(entity.getIn0001());
		//文件号
		ele.setIn0002(entity.getIn0002());
		//收件时间
		ele.setParentIn0005Start(entity.getIn0005Start());
		ele.setParentIn0005End(entity.getIn0005End());

		//按轻重分类
		ele.setIn0006(entity.getIn0006());
		//要求分类
		ele.setIn0007(entity.getIn0007());
		//按内容分类
		ele.setIn0008(entity.getIn0008());
		//按内容分类
		ele.setParentIn0018(entity.getIn0018());
		//领导单位
		ele.setLeaderIds(entity.getLeaderIds());
//承办单位
		ele.setOfficeIds(entity.getOfficeIds());
//文件类型
		ele.setParentIn0016(entity.getIn0016());
		//标记
		ele.setParentIn0019(entity.getIn0019());
		//落实及上报情况
		ele.setIn0014(entity.getIn0014());
		//落实及上报情况
		ele.setParentIn0017(entity.getIn0017());



		if (!StringUtils.isBlank(pageParam.getOrderBy())) {
			PageHelper.orderBy(pageParam.getOrderBy());
		}
		List<InstructionsElement> elementList = dao.findPageList(ele);
		pageResult.setRows(elementList);
		return pageResult;
	}
}
