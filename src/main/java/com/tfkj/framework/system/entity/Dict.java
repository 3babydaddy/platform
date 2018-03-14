/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;

/**
 * 字典Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Dict extends DataEntity<Dict> {

    private static final long serialVersionUID = 1L;
    // 数据值
    private String enname;
    // 标签名
    private String chname;
    // 类型
    private String typeEnname;
    // 类型中文
    private String typeChname;
    // 排序
    private Integer sort;

    @Length(min = 1, max = 100)
    @ExcelField(title = "字典类型", align = 2, sort = 1)
    public String getTypeEnname() {
        return typeEnname;
    }

    @ExcelField(title = "名称", align = 2, sort = 2)
    public String getChname() {
        return chname;
    }

    @ExcelField(title = "保存值", align = 2, sort = 3)
    public String getEnname() {
        return enname;
    }

    @NotNull
    @ExcelField(title = "排序", align = 2, sort = 4)
    public Integer getSort() {
        return sort;
    }

    public void setTypeEnname(String typeEnname) {
        this.typeEnname = typeEnname;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getTypeChname() {
        return typeChname;
    }

    public void setTypeChname(String typeChname) {
        this.typeChname = typeChname;
    }

    public void setChname(String chname) {
        this.chname = chname;
    }

    public void setEnname(String enname) {
        this.enname = enname;
    }
}