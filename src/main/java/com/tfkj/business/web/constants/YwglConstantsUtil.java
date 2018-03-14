package com.tfkj.business.web.constants;

import java.util.List;

import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.utils.SpringContextHolder;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.system.dao.LeaderDao;
import com.tfkj.framework.system.dao.OfficeDao;
import com.tfkj.framework.system.entity.Leader;
import com.tfkj.framework.system.entity.Office;

public class YwglConstantsUtil {

	/**
	 * 领导查询
	 */
	private static LeaderDao leaderDao = SpringContextHolder.getBean(LeaderDao.class);

	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);

	/**
	 * @Title: leaderNames
	 * @Description: 根据IDS和领导适用类型,查询领导名称
	 * @param @param ids
	 * @param @param Type
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getLeaderNames(String ids) {

		if (StringUtils.isBlank(ids)) {
			return null;
		}
		String[] idsArray = ids.split(",");
		StringBuilder names = new StringBuilder();
		for (int i = 0; i < idsArray.length; i++) {
			Leader leader = new Leader();
			leader.setId(idsArray[i]);
			Leader findLeader = leaderDao.get(leader);
			if (findLeader != null) {
				if (names.length() > 0) {
					names.append(",").append(findLeader.getL001());
				} else {
					names.append(findLeader.getL001());
				}
			}
		}
		String leaderNames = names.toString();
		if (leaderNames.endsWith(",")) {
			leaderNames = leaderNames.substring(0, leaderNames.length() - 1);
		}
		return leaderNames;
	}

	/**
	 * @Title: getOfficeNames
	 * @Description: 获得单位名称
	 * @param @param ids
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getOfficeNames(String ids) {

		if (StringUtils.isBlank(ids)) {
			return "";
		}
		String[] idsArray = ids.split(",");
		StringBuilder names = new StringBuilder();
		for (int i = 0; i < idsArray.length; i++) {
			Office office = new Office(idsArray[i]);
			Office findOffice = officeDao.get(office);
			if (findOffice != null) {
				if (names.length() > 0) {
					names.append(",").append(findOffice.getName());
				} else {
					names.append(findOffice.getName());
				}
			}
		}
		String officeNames = names.toString();
		if (officeNames.endsWith(",")) {
			officeNames = officeNames.substring(0, officeNames.length() - 1);
		}
		return officeNames;
	}

	public static String getOfficeNames(List<TableOfficeElement> list) {

		StringBuilder names = new StringBuilder();
		if (list != null && !list.isEmpty()) {
			for (TableOfficeElement tableOfficeElement : list) {
				if (tableOfficeElement != null && tableOfficeElement.getOffice() != null) {
					if (names.length() > 0) {
						names.append(",").append(tableOfficeElement.getOffice().getName());
					} else {
						names.append(tableOfficeElement.getOffice().getName());
					}
				}
			}
		}
		String officeNames = names.toString();
		if (officeNames.endsWith(",")) {
			officeNames = officeNames.substring(0, officeNames.length() - 1);
		}
		return officeNames;
	}
}