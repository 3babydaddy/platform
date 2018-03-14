package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.ywgl.dao.InstructionsDao;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.StringUtils;

/**
 * @Description: 批示件
 * @author gaowei
 * @date 2018年1月30日
 */
@Service
@Transactional(readOnly = false)
public class InstructionsService extends CrudService<InstructionsDao, Instructions> {

	@Autowired
	private InstructionsElementService instructionsElementService;

	/**
	 * @Title: relate
	 * @Description: 父级数据关联子级数据
	 * @param @param parentIds
	 * @param @param relateId
	 * @param @return 参数
	 * @return 返回类型
	 * @throws
	 */
	public void relate(String parentIds, String relateId) {

		if (StringUtils.isBlank(relateId) || StringUtils.isBlank(parentIds)) {
			return;
		}
		String[] idsArray = parentIds.split(",");
		for (int i = 0; i < idsArray.length; i++) {
			Instructions instructions = new Instructions();
			instructions.setId(idsArray[i]);
			instructions.setIn0020(relateId);
			instructions.preUpdate();
			dao.update(instructions);
		}
	}

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
			Instructions instructions = new Instructions();
			instructions.setId(idsArray[i]);
			instructions.setDelFlag(Instructions.DEL_FLAG_DELETE);
			int num = dao.delete(instructions);
			delete += num;
		}
		return delete;
	}

	/**
	 * @Title: saveForm
	 * @Description: 保存表单
	 * @param @param entity 参数
	 * @return void 返回类型
	 * @throws
	 */
	public void saveForm(Instructions entity) {

		String dataId = IdGen.uuid();
		if (StringUtils.isBlank(entity.getId())) {
			entity.setId(dataId);
			entity.setIsNewRecord(true);
		}
		InstructionsElement element = new InstructionsElement();
		element.setDataId(entity.getId());
		List<InstructionsElement> elementList = instructionsElementService.findList(element);

		List<InstructionsElement> officeElementList = entity.getOfficeElementList();
		if (officeElementList != null && !officeElementList.isEmpty()) {
			for (InstructionsElement officeElement : officeElementList) {
				if (officeElement.getOfficeId()!=null){
					Boolean flag = true;
					if (StringUtils.isBlank(officeElement.getType())) {
						continue;
					}
					if (elementList!=null&&elementList.size()>0){
						for (int i = 0; i <elementList.size() ; i++) {
							InstructionsElement item = elementList.get(i);
							if (item.getOfficeId()!=null&&item.getOfficeId().equals(officeElement.getOfficeId())){
								elementList.remove(item);
								flag = false;
							}
						}
					}

					officeElement.setDataId(entity.getId());
					officeElement.setType(YwglConstants.INSTRUCTIONS_ELEMENT_TYPE_OFFICE);
					if (flag){
						instructionsElementService.save(officeElement);
					}else {
						instructionsElementService.updateElementOfficeLeader(officeElement);
					}
				}
			}
		}
		List<InstructionsElement> leaderElementList = entity.getLeaderElementList();
		if (leaderElementList != null && !leaderElementList.isEmpty()) {
			for (InstructionsElement leaderElement : leaderElementList) {
				if (leaderElement.getLeaderId()!=null){
					Boolean flag = true;
					if (StringUtils.isBlank(leaderElement.getType())) {
						continue;
					}
					if (elementList!=null&&elementList.size()>0) {
						for (int i = 0; i < elementList.size(); i++) {
							InstructionsElement item = elementList.get(i);
							if (item.getLeaderId()!=null&&item.getLeaderId().equals(leaderElement.getLeaderId())){
								flag = false;
								elementList.remove(item);
							}
						}
					}

					leaderElement.setDataId(entity.getId());
					leaderElement.setType(YwglConstants.INSTRUCTIONS_ELEMENT_TYPE_LEADER);
					if (flag){
						instructionsElementService.save(leaderElement);
					}else {
						instructionsElementService.updateElementOfficeLeader(leaderElement);
					}
				}
			}
		}
		for (InstructionsElement item : elementList){
			item.setDelFlag("1");
			instructionsElementService.updateElementOfficeLeader(item);
		}
		this.save(entity);
	}
}
