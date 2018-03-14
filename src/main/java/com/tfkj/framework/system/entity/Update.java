/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import com.tfkj.framework.core.persistence.DataEntity;

/**
 * 系统更新Entity
 * 描　　述：
 * 创建时间: 2016年11月2日
 */
public class Update extends DataEntity<Update> {

    private static final long serialVersionUID = 1L;

    private String version;  // 版本号
    
    private String path;     // 升级包保存路径

    private String title;    // 日志标题

    private String detail;   // 详细内容

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}