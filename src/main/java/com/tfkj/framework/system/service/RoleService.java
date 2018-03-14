package com.tfkj.framework.system.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.RoleDao;
import com.tfkj.framework.system.entity.Role;

/**
 * 描 述：用户管理service
 */
@Service
@Transactional(readOnly = true)
public class RoleService extends CrudService<RoleDao, Role> {

}
