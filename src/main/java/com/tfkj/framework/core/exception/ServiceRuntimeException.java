/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.core.exception;

/**
 * Service层公用的Exception, 从由Spring管理事务的函数中抛出时会触发事务回滚.
 * @author ThinkGem
 */
public class ServiceRuntimeException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ServiceRuntimeException() {
		super();
	}

	public ServiceRuntimeException(String message) {
		super(message);
	}

	public ServiceRuntimeException(Throwable cause) {
		super(cause);
	}

	public ServiceRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}
}
