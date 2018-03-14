package com.tfkj.business.batch.entity;

import com.tfkj.framework.core.persistence.DataEntity;

public class Relation extends DataEntity<Relation> {

  private static final long serialVersionUID = 1L;

  //
  private String cbId;
  private String type;
  private String unqId;
  private String pzId;
  private String remindersDate;

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getUnqId() {
    return unqId;
  }

  public void setUnqId(String unqId) {
    this.unqId = unqId;
  }

  public String getRemindersDate() {
    return remindersDate;
  }

  public void setRemindersDate(String remindersDate) {
    this.remindersDate = remindersDate;
  }

  public String getCbId() {
    return cbId;
  }

  public void setCbId(String cbId) {
    this.cbId = cbId;
  }

  public String getPzId() {
    return pzId;
  }

  public void setPzId(String pzId) {
    this.pzId = pzId;
  }
}
