/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.persistence.DataEntity;

/**
 * 角色Entity
 * 
 * @author ThinkGem
 * @version 2013-12-05
 */
public class Role extends DataEntity<Role> {

	private static final long serialVersionUID = 1L;
	// 所属单位
	private Office office;
	// 角色名称
	private String name;
	// 角色英文名称
	private String enname;
	// 功能权限类型
	private String funcType;
	// 数据权限范围
	private String dataType;
	// 原角色名称
	private String oldName;
	// 原角色英文名称
	private String oldEnname;
	// 是否是可用
	private String stateFlag;
	// 根据用户ID查询角色列表
	private User user;
	// 拥有菜单列表
	private List<Menu> menuList = Lists.newArrayList();
	// 按明细设置数据范围
	private List<Office> officeList = Lists.newArrayList();

	public static final String DATA_SCOPE_ALL = "1"; // 所有数据
	public static final String DATA_SCOPE_OFFICE_AND_CHILD = "2";// 所属单位及以下数据
	public static final String DATA_SCOPE_OFFICE = "3";// 所属单位数据
	public static final String DATA_SCOPE_SELF = "4";// 仅本人数据
	public static final String DATA_SCOPE_CUSTOM = "5";// 按明细设置

	public Role() {
		super();
		this.dataType = DATA_SCOPE_SELF;
		this.stateFlag = Global.YES;
	}

	public Role(String id) {
		super(id);
	}

	public Role(User user) {
		this();
		this.user = user;
	}

	public String getStateFlag() {
		return stateFlag;
	}

	public void setStateFlag(String stateFlag) {
		this.stateFlag = stateFlag;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	@Length(min = 1, max = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public List<Menu> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}

	public List<String> getMenuIdList() {
		List<String> menuIdList = Lists.newArrayList();
		for (Menu menu : menuList) {
			menuIdList.add(menu.getId());
		}
		return menuIdList;
	}

	public void setMenuIdList(List<String> menuIdList) {
		menuList = Lists.newArrayList();
		for (String menuId : menuIdList) {
			Menu menu = new Menu();
			menu.setId(menuId);
			menuList.add(menu);
		}
	}

	public String getMenuIds() {
		return StringUtils.join(getMenuIdList(), ",");
	}

	public void setMenuIds(String menuIds) {
		menuList = Lists.newArrayList();
		if (menuIds != null) {
			String[] ids = StringUtils.split(menuIds, ",");
			setMenuIdList(Lists.newArrayList(ids));
		}
	}

	public List<Office> getOfficeList() {
		return officeList;
	}

	public void setOfficeList(List<Office> officeList) {
		this.officeList = officeList;
	}

	public List<String> getOfficeIdList() {
		List<String> officeIdList = Lists.newArrayList();
		for (Office office : officeList) {
			officeIdList.add(office.getId());
		}
		return officeIdList;
	}

	public void setOfficeIdList(List<String> officeIdList) {
		officeList = Lists.newArrayList();
		for (String officeId : officeIdList) {
			Office office = new Office();
			office.setId(officeId);
			officeList.add(office);
		}
	}

	public String getOfficeIds() {
		return StringUtils.join(getOfficeIdList(), ",");
	}

	public void setOfficeIds(String officeIds) {
		officeList = Lists.newArrayList();
		if (officeIds != null) {
			String[] ids = StringUtils.split(officeIds, ",");
			setOfficeIdList(Lists.newArrayList(ids));
		}
	}

	/**
	 * 获取权限字符串列表
	 */
	public List<String> getPermissions() {
		List<String> permissions = Lists.newArrayList();
		for (Menu menu : menuList) {
			if (menu.getPermission() != null && !"".equals(menu.getPermission())) {
				permissions.add(menu.getPermission());
			}
		}
		return permissions;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getFuncType() {
		return funcType;
	}

	public void setFuncType(String funcType) {
		this.funcType = funcType;
	}

	public String getEnname() {
		return enname;
	}

	public void setEnname(String enname) {
		this.enname = enname;
	}

	public String getOldEnname() {
		return oldEnname;
	}

	public void setOldEnname(String oldEnname) {
		this.oldEnname = oldEnname;
	}

	// public boolean isXtglAdmin(){
	// return isXtglAdmin(this.id);
	// }
	//
	// public static boolean isXtglAdmin(String id){
	// return id != null && "1".equals(id);
	// }

	// @Transient
	// public String getMenuNames() {
	// List<String> menuNameList = Lists.newArrayList();
	// for (Menu menu : menuList) {
	// menuNameList.add(menu.getName());
	// }
	// return StringUtils.join(menuNameList, ",");
	// }
}
