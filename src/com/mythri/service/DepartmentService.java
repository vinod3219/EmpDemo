package com.mythri.service;

import java.util.List;

import com.mythri.entity.Department;
import com.mythri.util.UserException;

public interface DepartmentService {
	
	public void addDepartment(Department department) throws UserException;

	public void updateDepartment(Department department);
	
	public Department getDepartmentById(int id);
	
	public void deleteDepartment(Department department);
	
	public List<Department> listDepartments();

	List<String> getDepartmentNames();

	Department getDeptWithEmps(String name);
}
