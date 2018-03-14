/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.core.exception;

/**
 * Service层公用的Exception, 从由Spring管理事务的函数中抛出时会触发事务回滚.
 * @author ThinkGem
 */
public class ServiceCheckedException extends Exception {

	private static final long serialVersionUID = 1L;

	public ServiceCheckedException() {
		super();
	}

	public ServiceCheckedException(String message) {
		super(message);
	}

	public ServiceCheckedException(Throwable cause) {
		super(cause);
	}

	public ServiceCheckedException(String message, Throwable cause) {
		super(message, cause);
	}
}
