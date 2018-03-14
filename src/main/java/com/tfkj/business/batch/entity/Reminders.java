package com.tfkj.business.batch.entity;

import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.system.utils.DictUtils;

import java.util.List;

public class Reminders extends DataEntity<Reminders> {

  private static final long serialVersionUID = 1L;

  //
  private String remindersDate;
  private String type;

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getRemindersDate() {
    return remindersDate;
  }

  public void setRemindersDate(String remindersDate) {
    this.remindersDate = remindersDate;
  }
}
