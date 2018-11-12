package com.mythri.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mythri.dao.EmployeeDao;
import com.mythri.dto.CreateEmpDetails;
import com.mythri.dto.EmployeeRequest;
import com.mythri.dto.ResponseDTO;
import com.mythri.entity.Address;
import com.mythri.entity.Employee;
import com.mythri.util.ErrorCodes;
import com.mythri.util.UserException;

@Service("employeeService")
@Transactional
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private EmployeeDao employeeDao;
	
	@Transactional
	public void addEmployee(Employee employee) throws UserException {
		if(employeeDao.isEmployeeExists(employee.getLoginName()))
			throw new UserException(ErrorCodes.ERROR2.getErrorCode(), ErrorCodes.ERROR2.getDesc());
		employee.setJoinDate(new Date());
		//mapEmployeeWithAddress(employee);
		employeeDao.addEmployee(employee);
	}

	private void mapEmployeeWithAddress(Employee employee) {
		List<Address> addresses = employee.getAddresses();
		if(addresses!=null){
			for(Address address:addresses){
				address.setEmployee(employee);
			}
		}
	}

	@Override @Transactional
	public ResponseDTO<Employee> getEmployees(int pageNo) {
		return employeeDao.getEmployees(pageNo);
	}

	@Override 
	@Transactional
	public Employee getValidEmpByAuth(Employee employee) {
		return employeeDao.getValidEmpByAuth(employee);
	}

	@Transactional
	public Employee getEmpById(int id) {
		return employeeDao.getEmployee(id);
	}

	@Override 
	@Transactional
	public void deleteEmployee(Employee employee) {
		employeeDao.deleteEmployee(employee);
	}

	@Override 
	@Transactional
	public Employee getEmpByName(String name) {
		return employeeDao.searchByName(name);
	}

	@Override 
	@Transactional
	public Employee updateEmployee(Employee employee) throws UserException {
		if(!employeeDao.isEmployeeExists(employee.getLoginName()))
			throw new UserException(ErrorCodes.ERROR3.getErrorCode(), ErrorCodes.ERROR3.getDesc());
		mapEmployeeWithAddress(employee);
		return employeeDao.updateEmployee(employee);
	}

	@Override
	public ResponseDTO<Employee> getFilteredEmployees(EmployeeRequest employeeReq) {
		return employeeDao.getAdvancedSearchResult(employeeReq);
	}

	@Override
	public ResponseDTO<Employee> getAllEmps(String sortBy) {
		return employeeDao.getAllEmps(sortBy);
	}

	@Override
	public CreateEmpDetails getManagerAndDepts() {
		return employeeDao.getManagerAndDepts();
	}

	@Override
	public List<Employee> getBasicEmpDetails() {
		return employeeDao.getBasicEmpDetails();
	}
}