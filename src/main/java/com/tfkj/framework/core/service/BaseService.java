/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.core.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.tf.permission.client.entity.User;
import com.tfkj.framework.core.persistence.BaseEntity;
import com.tfkj.framework.core.utils.StringUtils;

/**
 * Service基类
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class BaseService {

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * SERVICE层操作是否成功
	 */
	public final static String SERVICE_SUCCESS = "1";// 成功

	public final static String SERVICE_FAIL = "0";// 失败

	/**
	 * 数据范围过滤
	 * 
	 * @param user
	 *            当前用户对象，通过“entity.getCurrentUser()”获取
	 * @param officeAlias
	 *            单位表别名，多个用“,”逗号隔开。
	 * @param userAlias
	 *            用户表别名，多个用“,”逗号隔开，传递空，忽略此参数
	 * @return 标准连接条件对象
	 */
	public static String dataScopeFilter(User user, String officeAlias,
			String userAlias) {

		StringBuilder sqlString = new StringBuilder();

		// 进行权限过滤，多个角色权限范围之间为或者关系。
		List<String> dataScope = Lists.newArrayList();

		// 超级管理员，跳过权限过滤
		if (user.getIsAdmin().equals("1")) {
			/*
			 * boolean isDataScopeAll = false; // 遍历用户的所有角色 for (Role r : user)
			 * { // 遍历参数单位表别名 for (String oa : StringUtils.split(officeAlias,
			 * ",")) { // 如果dataScope中不包含该角色中的数据范围并且单位别名不为空 if
			 * (!dataScope.contains(r.getDataType()) &&
			 * StringUtils.isNotBlank(oa)) { // 所有单位数据 if
			 * (Role.DATA_SCOPE_ALL.equals(r.getDataType())) { isDataScopeAll =
			 * true; } // 所属单位及以下数据 else if
			 * (Role.DATA_SCOPE_OFFICE_AND_CHILD.equals(r.getDataType())) {
			 * sqlString.append(" OR " + oa + ".id = '" +
			 * user.getOffice().getId() + "'"); sqlString.append(" OR " + oa +
			 * ".parent_ids LIKE '" + user.getOffice().getParentIds() + "%'"); }
			 * // 所在单位数据 else if
			 * (Role.DATA_SCOPE_OFFICE.equals(r.getDataType())) {
			 * sqlString.append(" OR " + oa + ".id = '" +
			 * user.getOffice().getId() + "'"); } // 按明细设置 else if
			 * (Role.DATA_SCOPE_CUSTOM.equals(r.getDataType())) {
			 * sqlString.append
			 * (" OR EXISTS (SELECT 1 FROM sys_role_office WHERE role_id = '" +
			 * r.getId() + "'"); sqlString.append(" AND office_id = " + oa +
			 * ".id)"); } dataScope.add(r.getDataType()); } } } // 如果没有全部数据权限 if
			 * (!isDataScopeAll) { // 参数中设置了用户别名，则当前权限为本人 if
			 * (StringUtils.isNotBlank(userAlias)) { for (String ua :
			 * StringUtils.split(userAlias, ",")) { sqlString.append(" OR " + ua
			 * + ".id = '" + user.getId() + "'"); } } // 如果未设置别名，当前无权限为已植入权限
			 * else { for (String oa : StringUtils.split(officeAlias, ",")) {
			 * sqlString.append(" OR " + oa + ".id IS NULL"); } } } //
			 * 如果包含全部权限，则去掉之前添加的所有条件，并跳出循环。 else { sqlString = new
			 * StringBuilder(); }
			 */
		}
		if (StringUtils.isNotBlank(sqlString.toString())) {
			return " AND (" + sqlString.substring(4) + ")";
		}
		return "";
	}

	/**
	 * 数据范围过滤（符合业务表字段不同的时候使用，采用exists方法）
	 * 
	 * @param entity
	 *            当前过滤的实体类
	 * @param sqlMapKey
	 *            sqlMap的键值，例如设置“dsf”时，调用方法：${sqlMap.sdf}
	 * @param officeWheres
	 *            office表条件，组成：部门表字段=业务表的部门字段
	 * @param userWheres
	 *            user表条件，组成：用户表字段=业务表的用户字段
	 * @example dataScopeFilter(user, "dsf", "id=a.office_id",
	 *          "id=a.create_by"); dataScopeFilter(entity, "dsf", "code=a.jgdm",
	 *          "no=a.cjr"); // 适应于业务表关联不同字段时使用，如果关联的不是单位id是code。
	 */
	public static void dataScopeFilter(BaseEntity<?> entity, String sqlMapKey,
			String officeWheres, String userWheres) {

		User user = entity.getCurrentUser();

		// 如果是超级管理员，则不过滤数据
		// if (user.isSuperAdmin()) {
		return;
		// }

		/*
		 * //
		 * 数据范围（1：所有数据；2：所在公司及以下数据；3：所在公司数据；4：所在部门及以下数据；5：所在部门数据；8：仅本人数据；9：按明细设置
		 * ） StringBuilder sqlString = new StringBuilder();
		 * 
		 * // 获取到最大的数据权限范围 String roleId = ""; int dataScopeInteger = 8; for
		 * (Role r : user.getRoleList()) { int ds =
		 * Integer.valueOf(r.getDataType()); if (ds == 9) { roleId = r.getId();
		 * dataScopeInteger = ds; break; } else if (ds < dataScopeInteger) {
		 * roleId = r.getId(); dataScopeInteger = ds; } } String dataScopeString
		 * = String.valueOf(dataScopeInteger);
		 * 
		 * // 生成部门权限SQL语句 for (String where : StringUtils.split(officeWheres,
		 * ",")) { if (Role.DATA_SCOPE_OFFICE_AND_CHILD.equals(dataScopeString))
		 * { sqlString.append(" AND EXISTS (SELECT 1 FROM SYS_OFFICE");
		 * sqlString.append(" WHERE (id = '" + user.getOffice().getId() + "'");
		 * sqlString.append(" OR parent_ids LIKE '" +
		 * user.getOffice().getParentIds() + "%')"); sqlString.append(" AND " +
		 * where + ")"); } else if
		 * (Role.DATA_SCOPE_OFFICE.equals(dataScopeString)) {
		 * sqlString.append(" AND EXISTS (SELECT 1 FROM SYS_OFFICE");
		 * sqlString.append(" WHERE id = '" + user.getOffice().getId() + "'");
		 * sqlString.append(" AND " + where + ")"); } else if
		 * (Role.DATA_SCOPE_CUSTOM.equals(dataScopeString)) { sqlString.append(
		 * " AND EXISTS (SELECT 1 FROM sys_role_office ro123456, sys_office o123456"
		 * ); sqlString.append(" WHERE ro123456.office_id = o123456.id");
		 * sqlString.append(" AND ro123456.role_id = '" + roleId + "'");
		 * sqlString.append(" AND o123456." + where + ")"); } } // 生成个人权限SQL语句
		 * for (String where : StringUtils.split(userWheres, ",")) { if
		 * (Role.DATA_SCOPE_SELF.equals(dataScopeString)) {
		 * sqlString.append(" AND EXISTS (SELECT 1 FROM sys_user");
		 * sqlString.append(" WHERE id='" + user.getId() + "'");
		 * sqlString.append(" AND " + where + ")"); } }
		 * 
		 * // System.out.println("dataScopeFilter: " + sqlString.toString());
		 * 
		 * // 设置到自定义SQL对象 entity.getSqlMap().put(sqlMapKey,
		 * sqlString.toString());
		 */

	}

}
