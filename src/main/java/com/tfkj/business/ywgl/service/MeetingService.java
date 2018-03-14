
package com.tfkj.business.ywgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.StringUtil;
import com.tfkj.business.ywgl.dao.MeetingTableDataDao;
import com.tfkj.business.ywgl.dao.MeetingTableElementDao;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.MeetingTableData;
import com.tfkj.business.ywgl.entity.MeetingTableElement;
import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;

/**
 * @Description: 会议议定事项
 * @author gaowei
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = true)
public class MeetingService extends CrudService<MeetingTableDataDao, MeetingTableData> {
	@Autowired
	private MeetingTableElementDao meetingTableElementDao;
	@Autowired
	private TableOfficeElementDao officeDao;

	@Transactional(readOnly = false)
	public String saveElement(MeetingTableElement table){
		if(StringUtil.isNotEmpty(table.getId())){
			table.preUpdate();
			//删除相关的单位
			officeDao.deleteByDataId(table.getId());
			//新增单位
			List<TableOfficeElement> officeList=table.getOfficeList();
			if(officeList!=null){
				for (TableOfficeElement tableOfficeElement : officeList) {
					if(tableOfficeElement.getOffice()!=null||StringUtil.isNotEmpty(tableOfficeElement.getFilePath())){
						tableOfficeElement.setDataId(table.getId());
						tableOfficeElement.preInsert();
						officeDao.insert(tableOfficeElement);
					}

				}
			}
			meetingTableElementDao.update(table);
		}else{
			//新增
			table.preInsert();
			List<TableOfficeElement> officeList=table.getOfficeList();
			if(officeList!=null){
				for (TableOfficeElement tableOfficeElement : officeList) {
					if(tableOfficeElement.getOffice()!=null||StringUtil.isNotEmpty(tableOfficeElement.getFilePath())){
						tableOfficeElement.setDataId(table.getId());
						tableOfficeElement.preInsert();
						officeDao.insert(tableOfficeElement);
					}
				}
			}
			meetingTableElementDao.insert(table);
		}
		return table.getId();
	}
	/**
	 * 删除会议议定事项
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void deleteElement(String id){
		meetingTableElementDao.delete(id);
	}
	/**
	 * 删除会议议定事项
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void deleteMeeting(String ids){
		String[] listId=ids.split(",");
		for (String string : listId) {
			dao.delete(string);
			List<MeetingTableElement> meetList=meetingTableElementDao.findListByParentId(string);
			for (MeetingTableElement meetingTableElement : meetList) {
				meetingTableElementDao.delete(meetingTableElement.getId());
			}
		}
	}
	//自定义分页
	  /**
     * 查询分页数据
     * @param entity
     * @param pageParam
     * @return
     */
    public PageResult<MeetingTableElement> findListPage(MeetingTableElement ele,Boolean isPage, PageParam pageParam) {
    	if(isPage){
    		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
        	ele.getSqlMap().put("dsf", dataScopeFilter(ele.getCurrentUser(), "o", "u"));
            PageHelper.offsetPage(pageParam.getOffset(), pageParam.getLimit());
    	}
        if (!StringUtils.isBlank(pageParam.getOrderBy())) {
            PageHelper.orderBy(pageParam.getOrderBy());
        }
        PageInfo<MeetingTableData> pageInfo = new PageInfo<MeetingTableData>(dao.findList(ele));
        PageResult<MeetingTableElement> pageResult = new PageResult<MeetingTableElement>();
        pageResult.setTotal(pageInfo.getTotal());
        List<MeetingTableData> meetList=pageInfo.getList();
        String ids="";
        for (MeetingTableData meetingTableData : meetList) {
			ids+="'"+meetingTableData.getId()+"'"+",";
		}
        if(StringUtil.isNotEmpty(ids)){
        	ids=ids.substring(0, ids.length()-1);
        };
        if(StringUtil.isEmpty(ids)){
        	ids="''";
        }
        ele.setMeetingIds(ids);
        if (!StringUtils.isBlank(pageParam.getOrderBy())) {
            PageHelper.orderBy(pageParam.getOrderBy());
        }
        List<MeetingTableElement> elementList=dao.findListElement(ele);
        pageResult.setRows(elementList);
        return pageResult;
    }
}
