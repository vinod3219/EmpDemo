package com.mythri.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mythri.dao.DepartmentDao;
import com.mythri.entity.Department;
import com.mythri.util.ErrorCodes;
import com.mythri.util.UserException;

@Service("departmentService")
@Transactional
public class DepartmentServiceImpl implements DepartmentService{

	@Autowired
	private DepartmentDao departmentDao;
	
	@Override
	public void addDepartment(Department department) throws UserException {
		department.setCreatedDate(new Date());
		departmentDao.addDepartment(department);
	}

	@Override
	public void updateDepartment(Department department) {
		departmentDao.updateDepartment(department);		
	}

	@Override
	public Department getDepartmentById(int id) {
		return departmentDao.getDepartmentById(id);
	}

	@Override
	public void deleteDepartment(Department department) throws UserException {
		Long empCountForDeptId = departmentDao.getEmpCountForDeptId(department.getId());
		if (empCountForDeptId !=0) {
			throw new UserException(ErrorCodes.ERROR4.getErrorCode(), ErrorCodes.ERROR4.getDesc());
		}
		departmentDao.deleteDepartment(department);
	}

	@Override
	public List<Department> listDepartments() {
		return departmentDao.getDepartments();
	}
	
	@Override
	public List<String> getDepartmentNames(){
		return departmentDao.getDepartmentNames(); 
	}
	
	@Override
	public Department getDeptWithEmps(String name) {
		return departmentDao.getDeptWithEmps(name);
	}
 }
