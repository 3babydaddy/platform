package com.tfkj.business.specialReport.entity;

import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;
import com.tfkj.framework.system.utils.DictUtils;

import java.util.List;

public class SpecialReport extends DataEntity<SpecialReport> {

  private static final long serialVersionUID = 1L;

  // 期数
  private String number;
  // 名称
  private String reportName;
  // 签发时间
  private String lssueDate;
  // 内容简介
  private String msg;
  //附件
  private String fileUploadUrl;
  private String fileUploadName;
  @ExcelField(align = 2, type = 0, sort = 3000, title = "期数")
  public String getNumber() {
    return number;
  }

  public void setNumber(String number) {
    this.number = number;
  }
  @ExcelField(align = 2, type = 0, sort = 1000, title = "名称")
  public String getReportName() {
    return reportName;
  }

  public void setReportName(String reportName) {
    this.reportName = reportName;
  }
  @ExcelField(align = 2, type = 0, sort = 2000, title = "签发时间")
  public String getLssueDate() {
    return lssueDate;
  }

  public void setLssueDate(String lssueDate) {
    this.lssueDate = lssueDate;
  }
  @ExcelField(align = 2, type = 0, sort = 4000, title = "内容简介")
  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public String getFileUploadUrl() {
    return fileUploadUrl;
  }

  public void setFileUploadUrl(String fileUploadUrl) {
    this.fileUploadUrl = fileUploadUrl;
  }

  public String getFileUploadName() {
    String url = this.fileUploadUrl;
    if (StringUtils.isNotBlank(url)){
      String[] array = url.split("/");
      this.fileUploadName = array[array.length-1];
    }
    return this.fileUploadName;
  }

  public void setFileUploadName(String fileUploadName) {
    this.fileUploadName = fileUploadName;
  }
}
