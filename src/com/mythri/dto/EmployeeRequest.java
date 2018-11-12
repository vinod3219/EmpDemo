package com.mythri.dto;

import java.io.Serializable;

public class EmployeeRequest implements Serializable{

	private static final long serialVersionUID = 7214189066541003181L;
	private String city;
	private String fName;
	private String lName;
	private String deptId;
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getlName() {
		return lName;
	}
	public void setlName(String lName) {
		this.lName = lName;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
 }
