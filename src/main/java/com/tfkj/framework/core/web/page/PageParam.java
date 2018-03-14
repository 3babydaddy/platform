package com.tfkj.framework.core.web.page;

import javax.servlet.http.HttpServletRequest;

import com.tfkj.framework.core.utils.StringUtils;

public class PageParam {
    private int offset;

    private int limit;

    private String sort;

    private String order;

    private String orderBy;

    public PageParam() {
    }
    
    public PageParam(HttpServletRequest request) {
        this.offset = StringUtils.isBlank(request.getParameter("offset")) ? 0 : Integer.parseInt(request.getParameter("offset"));
        this.limit = StringUtils.isBlank(request.getParameter("limit")) ? 10 : Integer.parseInt(request.getParameter("limit"));
        this.sort = StringUtils.isBlank(request.getParameter("sort")) ? null : request.getParameter("sort");
        this.order = StringUtils.isBlank(request.getParameter("order")) ? null : request.getParameter("order");
        this.orderBy = this.sort == null || this.order == null ? null : this.sort + " " + this.order;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}
