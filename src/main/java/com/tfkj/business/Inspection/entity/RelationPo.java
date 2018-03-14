package com.tfkj.business.Inspection.entity;

import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.system.utils.DictUtils;

import java.util.List;

public class RelationPo extends DataEntity<RelationPo> {

  private static final long serialVersionUID = 1L;

  //上级id
  private String parentId;

  private String findId;
  //来源
  private  String source;
  private  String sourceName;
  // 关联事项
  private  String agreeMatterName;
  //名称
  private String name ;
  // 类型
  private String type;
  //年度
  private String taskYear;
  private String taskYearEnd;


  public String getFindId() {
    return findId;
  }

  public void setFindId(String findId) {
    this.findId = findId;
  }

  public String getSourceName() {
    return DictUtils.getDictName(this.source,"SOURCE");
  }

  public void setSourceName(String sourceName) {
    this.sourceName = sourceName;
  }

  public String getTaskYearEnd() {
    return taskYearEnd;
  }

  public void setTaskYearEnd(String taskYearEnd) {
    this.taskYearEnd = taskYearEnd;
  }

  public String getParentId() {
    return parentId;
  }

  public void setParentId(String parentId) {
    this.parentId = parentId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getSource() {
    return source;
  }

  public void setSource(String source) {
    this.source = source;
  }

  public String getAgreeMatterName() {
    return agreeMatterName;
  }

  public void setAgreeMatterName(String agreeMatterName) {
    this.agreeMatterName = agreeMatterName;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getTaskYear() {
    return taskYear;
  }

  public void setTaskYear(String taskYear) {
    this.taskYear = taskYear;
  }
}
