package com.tfkj.business.familyMatters.entity;

import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;
import com.tfkj.framework.system.utils.DictUtils;

/**
 * 家庭重大事项登记管理
 * @author waixie011
 *
 */
public class FamilyMatters extends DataEntity<FamilyMatters> {

	private static final long serialVersionUID = 1L;
	
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
	
	//举办方式
	private String holding;
	
	//宴请时间
	private String feteTime;
	
	//宴请结束时间，条件查询使用
	private String feteEndTime;
	
	//城市
	private String city;
	
	//宴请地点
	private String fetePlace;
	
	//宴请规模
	private String feteScale;
	
	//参加人员
	private String attendants;
	
	//数量(人)
	private String amount;
	
	//收取礼金礼品数量
	private String giftAmount;
	
	//宴请桌数
	private String feteAmount;
	
	//价格(元)
	private String feteCost;
	
	//其他费用(元)
	private String otherCost;
	
	//总体花费(元)
	private String totalCost;
	
	//宴请标准(元/桌)
	private String feteStandards;
	
	//宴请对象
	private String fetePeople;
	
	//其他需要说明的情况
	private String instruction;
	
	//登记类型 0-婚嫁事前登记 1-婚嫁事后登记 2-丧葬事后登记
	private String type;
	
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

	@ExcelField(align = 2, type = 0, sort = 6000, title = "举办方式")
	public String getHolding() {
		return holding;
	}

	public void setHolding(String holding) {
		this.holding = holding;
	}

	@ExcelField(align = 2, type = 0, sort = 7000, title = "宴请时间")
	public String getFeteTime() {
		return feteTime;
	}

	public void setFeteTime(String feteTime) {
		this.feteTime = feteTime;
	}

	public String getFeteEndTime() {
		return feteEndTime;
	}

	public void setFeteEndTime(String feteEndTime) {
		this.feteEndTime = feteEndTime;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getFetePlace() {
		return fetePlace;
	}

	public void setFetePlace(String fetePlace) {
		this.fetePlace = fetePlace;
	}

	public String getFeteScale() {
		return feteScale;
	}

	public void setFeteScale(String feteScale) {
		this.feteScale = feteScale;
	}

	public String getAttendants() {
		return attendants;
	}

	public void setAttendants(String attendants) {
		this.attendants = attendants;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getGiftAmount() {
		return giftAmount;
	}

	public void setGiftAmount(String giftAmount) {
		this.giftAmount = giftAmount;
	}

	public String getFeteAmount() {
		return feteAmount;
	}

	public void setFeteAmount(String feteAmount) {
		this.feteAmount = feteAmount;
	}

	public String getFeteCost() {
		return feteCost;
	}

	public void setFeteCost(String feteCost) {
		this.feteCost = feteCost;
	}

	public String getOtherCost() {
		return otherCost;
	}

	public void setOtherCost(String otherCost) {
		this.otherCost = otherCost;
	}

	public String getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}

	public String getFeteStandards() {
		return feteStandards;
	}

	public void setFeteStandards(String feteStandards) {
		this.feteStandards = feteStandards;
	}

	public String getFetePeople() {
		return fetePeople;
	}

	public void setFetePeople(String fetePeople) {
		this.fetePeople = fetePeople;
	}

	public String getInstruction() {
		return instruction;
	}

	public void setInstruction(String instruction) {
		this.instruction = instruction;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}
