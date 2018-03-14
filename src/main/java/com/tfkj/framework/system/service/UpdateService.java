package com.tfkj.framework.system.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.UserDao;
import com.tfkj.framework.system.entity.User;

/**
 * 描 述：用户管理service
 */
@Service
@Transactional(readOnly = true)
public class UpdateService extends CrudService<UserDao, User> {

}
