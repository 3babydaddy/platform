/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.Collections3;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;
import com.tfkj.framework.core.utils.excel.annotation.ExcelFields;

/**
 * 用户Entity
 *
 * @author ThinkGem
 * @version 2013-12-05
 */
public class User extends DataEntity<User> {

	private static final long serialVersionUID = 1L;

	// 归属单位
	private Office office;

	// 登录名
	private String loginName;

	// 用户名
	private String name;

	// 密码
	private String password;

	// 用户类型
	private String type;

	// 最后登陆IP
	private String loginIp;

	// 最后登陆日期
	private Date loginDate;

	// 是否允许登陆
	private String stateFlag;

	// 原登录名
	private String oldLoginName;

	// 新密码
	private String newPassword;

	// 上次登陆IP
	private String oldLoginIp;

	// 上次登陆日期
	private Date oldLoginDate;

	// 根据角色查询用户条件
	private Role role;

	// 拥有角色列表
	private List<Role> roleList = Lists.newArrayList();

	public User() {
		super();
		this.stateFlag = Global.YES;
	}

	public User(String id) {
		super(id);
	}

	public User(String id, String loginName) {
		super(id);
		this.loginName = loginName;
	}

	public User(Role role) {
		super();
		this.role = role;
	}

	@ExcelField(align = 2, exportListType = "14", sort = 60, title = "是否允许登陆")
	public String getStateFlag() {

		return stateFlag;
	}

	public void setStateFlag(String stateFlag) {

		this.stateFlag = stateFlag;
	}

	@Override
	@ExcelField(title = "ID", align = 2, exportListType = "14", sort = 1)
	public String getId() {

		return id;
	}

	@NotNull(message = "归属单位不能为空")
	@ExcelFields({ @ExcelField(align = 2, exportListType = "14", type = 0, sort = 0, value = "office.id", title = "归属单位单位唯一标识"),
	        @ExcelField(align = 2, exportListType = "14", type = 0, sort = 2, value = "office.name", title = "归属单位") })
	public Office getOffice() {

		return office;
	}

	public void setOffice(Office office) {

		this.office = office;
	}

	@Length(min = 1, max = 100, message = "登录名长度必须介于 1 和 100 之间")
	@ExcelField(title = "登录名", align = 2, exportListType = "14", sort = 30)
	public String getLoginName() {

		return loginName;
	}

	public void setLoginName(String loginName) {

		this.loginName = loginName;
	}

	@Length(min = 1, max = 100, message = "密码长度必须介于 1 和 100 之间")
	@ExcelField(title = "用户密码", align = 2, exportListType = "14", sort = 40)
	public String getPassword() {

		return password;
	}

	public void setPassword(String password) {

		this.password = password;
	}

	@Length(min = 0, max = 100, message = "用户类型长度必须介于 1 和 100 之间")
	// @ExcelField(title = "用户类型", align = 2, exportListType = "14", sort = 80, dictType = "sys_user_type")
	@ExcelField(title = "用户类型", align = 2, exportListType = "14", sort = 80)
	public String getType() {

		return type;
	}

	public void setType(String type) {

		this.type = type;
	}

	@ExcelField(title = "最后登录IP", align = 2, exportListType = "14", sort = 100)
	public String getLoginIp() {

		return loginIp;
	}

	public void setLoginIp(String loginIp) {

		this.loginIp = loginIp;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@ExcelField(title = "最后登录日期", align = 2, exportListType = "14", sort = 110)
	public Date getLoginDate() {

		return loginDate;
	}

	public void setLoginDate(Date loginDate) {

		this.loginDate = loginDate;
	}

	public String getOldLoginName() {

		return oldLoginName;
	}

	public void setOldLoginName(String oldLoginName) {

		this.oldLoginName = oldLoginName;
	}

	public String getNewPassword() {

		return newPassword;
	}

	public void setNewPassword(String newPassword) {

		this.newPassword = newPassword;
	}

	public String getOldLoginIp() {

		if (oldLoginIp == null) {
			return loginIp;
		}
		return oldLoginIp;
	}

	public void setOldLoginIp(String oldLoginIp) {

		this.oldLoginIp = oldLoginIp;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getOldLoginDate() {

		if (oldLoginDate == null) {
			return loginDate;
		}
		return oldLoginDate;
	}

	public void setOldLoginDate(Date oldLoginDate) {

		this.oldLoginDate = oldLoginDate;
	}

	public Role getRole() {

		return role;
	}

	public void setRole(Role role) {

		this.role = role;
	}

	@JsonIgnore
	// @ExcelField(title = "拥有角色列表", align = 2, exportListType = "14", sort = 800, type = 1, fieldType = RoleListType.class)
	public List<Role> getRoleList() {

		return roleList;
	}

	public void setRoleList(List<Role> roleList) {

		this.roleList = roleList;
	}

	@JsonIgnore
	public List<String> getRoleIdList() {

		List<String> roleIdList = Lists.newArrayList();
		for (Role role : roleList) {
			roleIdList.add(role.getId());
		}
		return roleIdList;
	}

	public void setRoleIdList(List<String> roleIdList) {

		roleList = Lists.newArrayList();
		for (String roleId : roleIdList) {
			Role role = new Role();
			role.setId(roleId);
			roleList.add(role);
		}
	}

	/**
	 * 用户拥有的角色名称字符串, 多个角色名称用','分隔.
	 */
	public String getRoleNames() {

		return Collections3.extractToString(roleList, "name", ",");
	}

	/**
	 * 是否为系统管理员
	 *
	 * @return
	 */
	public boolean isSuperAdmin() {

		// User user = UserUtils.get(this.id);
		// return "0".equals(user.getOffice().getParent().getId());
		return false;
	}

	@Override
	public String toString() {

		return id;
	}

	public String getName() {

		return name;
	}

	public void setName(String name) {

		this.name = name;
	}

	@Override
	@ExcelField(align = 2, sort = 10000, title = "备注", exportListType = "14")
	public String getRemarks() {

		return remarks;
	}

	@Override
	public void setRemarks(String remarks) {

		this.remarks = remarks;
	}

	/*@Override
	@ExcelField(align = 2, sort = 10100, value = "createBy.id", title = "创建者唯一标识", exportListType = "14")
	public User getCreateBy() {

		return createBy;
	}

	@Override
	public void setCreateBy(User createBy) {

		this.createBy = createBy;
	}*/

	@Override
	@ExcelField(align = 2, sort = 10200, title = "创建时间", exportListType = "14")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getCreateDate() {

		return createDate;
	}

	@Override
	public void setCreateDate(Date createDate) {

		this.createDate = createDate;
	}

	/*@Override
	@ExcelField(align = 2, sort = 10300, value = "updateBy.id", title = "更新者唯一标识", exportListType = "14")
	public User getUpdateBy() {

		return updateBy;
	}

	@Override
	public void setUpdateBy(User updateBy) {

		this.updateBy = updateBy;
	}*/

	@Override
	@ExcelField(align = 2, sort = 10400, title = "更新时间", exportListType = "14")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getUpdateDate() {

		return updateDate;
	}

	@Override
	public void setUpdateDate(Date updateDate) {

		this.updateDate = updateDate;
	}

	@Override
	@ExcelField(align = 2, sort = 10500, title = "删除标记", exportListType = "14")
	public String getDelFlag() {

		return delFlag;
	}

	@Override
	public void setDelFlag(String delFlag) {

		this.delFlag = delFlag;
	}
}