package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.StringUtil;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.web.constants.YwglConstantsUtil;
import com.tfkj.business.ywgl.dao.SuperiorInspectDao;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.SuperiorInspect;
import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.StringUtils;

/**
 * @Description: 表格单位
 * @author gaowei
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = false)
public class SuperiorInspectService extends CrudService<SuperiorInspectDao, SuperiorInspect> {

	@Autowired
	private TableOfficeElementDao tableOfficeElementDao;

	@Autowired
	private TableOfficeElementService tableOfficeElementService;

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
		for (int i = 0; i < idsArray.length; i++) {
			SuperiorInspect superiorInspect = new SuperiorInspect();
			superiorInspect.setId(idsArray[i]);
			superiorInspect.setDelFlag(SuperiorInspect.DEL_FLAG_DELETE);
			int num = dao.delete(superiorInspect);
			delete += num;
		}
		return delete;
	}

	/**
	 * @Title: saveForm
	 * @Description: 保存Form表单
	 * @param @param entity
	 * @param @return 参数
	 * @return void 返回类型
	 * @throws
	 */
	public void saveForm(SuperiorInspect entity) {

		String dataId = IdGen.uuid();
		if (StringUtils.isBlank(entity.getId())) {
			entity.setId(dataId);
			entity.setIsNewRecord(true);
		}
		List<TableOfficeElement> dutyOfficeList = entity.getDutyOfficeList();
		if (dutyOfficeList != null && !dutyOfficeList.isEmpty()) {
			tableOfficeElementDao.deleteByFieldType(YwglConstants.TABLE_OFFICE_ELEMENT_FILE_FIELD_DUTY_OFFICE_LIST);
			String officeNames = YwglConstantsUtil.getOfficeNames(dutyOfficeList);
			if (StringUtils.isNotBlank(officeNames)) {
				entity.setS0005(officeNames);
			}
			for (TableOfficeElement tableOfficeElement : dutyOfficeList) {
				if(tableOfficeElement.getOffice()!=null||StringUtil.isNotEmpty(tableOfficeElement.getFilePath())){
					String dutyOfficeListId = IdGen.uuid();
					tableOfficeElement.setId(dutyOfficeListId);
					tableOfficeElement.setIsNewRecord(true);
					tableOfficeElement.setDataId(entity.getId());
					tableOfficeElement.setA0001(YwglConstants.TABLE_OFFICE_ELEMENT_FILE_FIELD_DUTY_OFFICE_LIST);
					tableOfficeElementService.save(tableOfficeElement);
				}
			}
		}
		// 分管区负责人
		/*
		 * String chargeOfficeIds = entity.getChargeOfficeIds();
		 * String leaderNames = YwglConstantsUtil.getLeaderNames(chargeOfficeIds, YwglConstants.LEADER_TYPE_FGQLD);
		 * entity.setS0003(leaderNames);
		 */
		this.save(entity);
	}
}
