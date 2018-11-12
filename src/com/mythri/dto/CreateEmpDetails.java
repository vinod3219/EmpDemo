package com.mythri.dto;

import java.util.List;

import com.mythri.entity.Department;
import com.mythri.entity.Employee;

public class CreateEmpDetails {

	private List<Employee> emps;
	private List<Department> depts;

	public List<Employee> getEmps() {
		return emps;
	}

	public CreateEmpDetails(List<Employee> emps, List<Department> depts) {
		super();
		this.emps = emps;
		this.depts = depts;
	}

	public void setEmps(List<Employee> emps) {
		this.emps = emps;
	}

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

}
