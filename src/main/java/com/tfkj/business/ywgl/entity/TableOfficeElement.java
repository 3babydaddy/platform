package com.tfkj.business.ywgl.entity;

import java.util.Date;

import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.system.entity.Office;

public class TableOfficeElement extends DataEntity<TableOfficeElement> {

	private static final long serialVersionUID = 1L;

	// 数据ID
	private String dataId;

	// 负责单位
	private Office office;

	// 负责人
	private String chargePerson;

	// 左边第一附件路径
	private String filePath;

	// 排序序号
	private String sort;

	//绑定字段
	private String a0001;

	//上传时间
	private String a0002;

	// 左边第二附件路径
	private String a0003;

	// 完成时限
	private String a0004;

	//工作评价
	private String a0005;

	public String getSort() {

		return sort;
	}

	public void setSort(String sort) {

		this.sort = sort;
	}

	public String getDataId() {

		return dataId;
	}

	public void setDataId(String dataId) {

		this.dataId = dataId;
	}

	public Office getOffice() {

		return office;
	}

	public void setOffice(Office office) {

		this.office = office;
	}

	public String getChargePerson() {

		return chargePerson;
	}

	public void setChargePerson(String chargePerson) {

		this.chargePerson = chargePerson;
	}

	public String getFilePath() {

		return filePath;
	}

	public void setFilePath(String filePath) {

		this.filePath = filePath;
	}

	public String getA0001() {

		return a0001;
	}

	public void setA0001(String a0001) {

		this.a0001 = a0001;
	}



	public String getA0002() {
		return a0002;
	}

	public void setA0002(String a0002) {
		this.a0002 = a0002;
	}

	public String getA0003() {

		return a0003;
	}

	public void setA0003(String a0003) {

		this.a0003 = a0003;
	}

	public String getA0004() {

		return a0004;
	}

	public void setA0004(String a0004) {

		this.a0004 = a0004;
	}

	public String getA0005() {

		return a0005;
	}

	public void setA0005(String a0005) {

		this.a0005 = a0005;
	}

	public static long getSerialversionuid() {

		return serialVersionUID;
	}
}
