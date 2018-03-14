package com.tfkj.business.familyMatters.entity;

import com.tfkj.framework.core.utils.excel.annotation.ExcelField;
import com.tfkj.framework.system.utils.DictUtils;

/**
 * 丧葬事后登记导出实体
 * @author waixie011
 *
 */
public class AfterBurialExport {

	//姓名
	private String name;
	
	//姓名，显示时使用
	private String nameText;
	
	//单位
	private String company;
	
	//单位名称
	private String companyText;
	
	//职务
	private String post;
	
	//身份证号
	private String idNumber;
	
	//申报事宜/报告事项
	private String matters;
	
	//宴请时间
	private String feteTime;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@ExcelField(align = 2, type = 0, sort = 1000, title = "姓名")
	public String getNameText() {
		return DictUtils.getLeadName(this.name);
	}

	public void setNameText(String nameText) {
		this.nameText = nameText;
	}
	
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@ExcelField(align = 2, type = 0, sort = 2000, title = "单位")
	public String getCompanyText() {
		return DictUtils.getOfficeName(this.company);
	}

	public void setCompanyText(String companyText) {
		this.companyText = companyText;
	}

	@ExcelField(align = 2, type = 0, sort = 3000, title = "职务")
	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	@ExcelField(align = 2, type = 0, sort = 4000, title = "身份证号")
	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	@ExcelField(align = 2, type = 0, sort = 5000, title = "申报事宜")
	public String getMatters() {
		return matters;
	}

	public void setMatters(String matters) {
		this.matters = matters;
	}

	@ExcelField(align = 2, type = 0, sort = 7000, title = "宴请时间")
	public String getFeteTime() {
		return feteTime;
	}

	public void setFeteTime(String feteTime) {
		this.feteTime = feteTime;
	}
	
}
