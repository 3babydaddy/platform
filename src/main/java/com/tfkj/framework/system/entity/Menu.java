/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;

/**
 * 菜单Entity
 * 
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Menu extends DataEntity<Menu> {

	private static final long serialVersionUID = 1L;
	// 父级菜单
	private Menu parent;
	// 所有父级编号
	private String parentIds;
	// 名称
	private String name;
	// 链接类型
	private String hrefType;
	// 链接
	private String href;
	// 目标（ mainFrame、_blank、_self、_parent、_top）
	private String target;
	// 图标
	private String icon;
	// 排序
	private Integer sort;
	// 是否在菜单中显示（1：显示；0：不显示）
	private String showFlag;
	// 权限标识
	private String permission;

	private String userId;

	public Menu() {
		super();
		this.sort = 30;
		this.showFlag = "1";
	}

	public String getHrefType() {
		return hrefType;
	}

	public Menu(String id) {
		super(id);
	}

	@JsonBackReference
	@NotNull
	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	@Length(min = 1, max = 2000)
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	@Length(min = 1, max = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min = 0, max = 2000)
	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	@Length(min = 0, max = 20)
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	@Length(min = 0, max = 100)
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@NotNull
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Length(min = 1, max = 1)
	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}

	@Length(min = 0, max = 200)
	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	@JsonIgnore
	public static void sortList(List<Menu> list, List<Menu> sourcelist, String parentId, boolean cascade) {
		for (int i = 0; i < sourcelist.size(); i++) {
			Menu e = sourcelist.get(i);
			if (e.getParent() != null && e.getParent().getId() != null && e.getParent().getId().equals(parentId)) {
				list.add(e);
				if (cascade) {
					// 判断是否还有子节点, 有则继续获取子节点
					for (int j = 0; j < sourcelist.size(); j++) {
						Menu child = sourcelist.get(j);
						if (child.getParent() != null && child.getParent().getId() != null
								&& child.getParent().getId().equals(e.getId())) {
							sortList(list, sourcelist, e.getId(), true);
							break;
						}
					}
				}
			}
		}
	}

	@JsonIgnore
	public static String getRootId() {
		return "1";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setHrefType(String hrefType) {
		this.hrefType = hrefType;
	}

	@Override
	public String toString() {
		return "Menu [parent=" + parent + ", parentIds=" + parentIds
				+ ", name=" + name + ", hrefType=" + hrefType + ", href="
				+ href + ", target=" + target + ", icon=" + icon + ", sort="
				+ sort + ", showFlag=" + showFlag + ", permission="
				+ permission + ", userId=" + userId + ", id=" + id + "]";
	}

	public List<String> getHrefTypeList() {
		List<String> hrefTypeList = Lists.newArrayList();
		if (hrefType == null || "".equals(hrefType)) {
			return null;
		}
		for (String ht : StringUtils.split(hrefType, ",")) {
			if (!"".equals(ht)) {
				hrefTypeList.add(ht);
			}
		}
		return hrefTypeList;
	}
	public void setHrefTypeList(List<String> hrefTypeList) {
		String htStr = "";
		for (int i = 0; i < hrefTypeList.size(); i++) {
			if (i == hrefTypeList.size() - 1) {
				htStr += hrefTypeList.get(i);
			} else {
				htStr += hrefTypeList.get(i) + ",";
			}
		}
		this.hrefType = htStr;
	}
}