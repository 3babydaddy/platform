/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.List;

import com.tfkj.framework.core.persistence.TreeEntity;

/**
 * @Description: 领导信息
 * @author gaowei
 * @date 2018年1月25日
 */
public class Leader extends TreeEntity<Leader> {

	private static final long serialVersionUID = 1L;

	/**
	 * 姓名
	 */
	private String l001;

	/**
	 * 性别
	 */
	private String l002;

	/**
	 * 出生日期
	 */
	private String l003;

	private String l004;

	private String l005;

	private String l006;

	private String l007;

	private String l008;

	private String l009;

	private List<String> childDeptList;// 快速添加子部门

	public List<String> getChildDeptList() {

		return childDeptList;
	}

	public void setChildDeptList(List<String> childDeptList) {

		this.childDeptList = childDeptList;
	}

	public String getL001() {

		return l001;
	}

	public void setL001(String l001) {

		this.l001 = l001;
	}

	public String getL002() {

		return l002;
	}

	public void setL002(String l002) {

		this.l002 = l002;
	}

	public String getL003() {

		return l003;
	}

	public void setL003(String l003) {

		this.l003 = l003;
	}

	public String getL004() {

		return l004;
	}

	public void setL004(String l004) {

		this.l004 = l004;
	}

	public String getL005() {

		return l005;
	}

	public void setL005(String l005) {

		this.l005 = l005;
	}

	public String getL006() {

		return l006;
	}

	public void setL006(String l006) {

		this.l006 = l006;
	}

	public String getL007() {

		return l007;
	}

	public void setL007(String l007) {

		this.l007 = l007;
	}

	public String getL008() {

		return l008;
	}

	public void setL008(String l008) {

		this.l008 = l008;
	}

	public String getL009() {

		return l009;
	}

	public void setL009(String l009) {

		this.l009 = l009;
	}

	public static long getSerialversionuid() {

		return serialVersionUID;
	}

	/**
	 * 创建一个新的实例 Leader.
	 */
	public Leader() {
		super();
	}

	public Leader(String id) {
		super(id);
	}

	@Override
	public Leader getParent() {

		return parent;
	}

	@Override
	public void setParent(Leader parent) {

		this.parent = parent;
	}
}