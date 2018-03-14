/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.tfkj.framework.core.persistence.TreeEntity;

/**
 * 字典分类/类型Entity
 * 
 * @author sunxuelong
 */
public class DictType extends TreeEntity<DictType> {

	private static final long serialVersionUID = 1L;

	// 英文名
	private String enname;
	// 中文名
	private String chname;
	// 类型
	private String type;

	@Length(min = 1, max = 100)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	@NotNull
	public Integer getSort() {
		return sort;
	}

	@Override
	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Override
	public DictType getParent() {
		return parent;
	}

	@Override
	public void setParent(DictType parent) {
		this.parent = parent;

	}

	public String getEnname() {
		return enname;
	}

	public void setEnname(String enname) {
		this.enname = enname;
	}

	public String getChname() {
		return chname;
	}

	public void setChname(String chname) {
		this.chname = chname;
	}

}