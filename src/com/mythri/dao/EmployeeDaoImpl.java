package com.mythri.dao;

import static com.mythri.entity.Employee.CHECK_EMP_EXISTS;
import static com.mythri.entity.Employee.GET_BASIC_EMP_DETAILS;
import static com.mythri.entity.Employee.GET_DEPT_INFO;
import static com.mythri.entity.Employee.GET_EMPLOYEE_WITH_ADDRESSES;
import static com.mythri.entity.Employee.GET_EMP_BY_AUTH;
import static com.mythri.entity.Employee.GET_EMP_COUNT;
import static com.mythri.entity.Employee.GET_MANAGER_INFO;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mythri.dto.CreateEmpDetails;
import com.mythri.dto.EmployeeRequest;
import com.mythri.dto.ResponseDTO;
import com.mythri.entity.Address;
import com.mythri.entity.Department;
import com.mythri.entity.Employee;

@Repository("employeeDao")
public class EmployeeDaoImpl implements EmployeeDao {


	@Autowired
	private SessionFactory sessionFactory;

	private static final int RESULT_PER_PAGE = 5;

	public void addEmployee(Employee employee) {
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		session.save(employee);// 1 row in emp table and 2 rows in address table
		transaction.commit();
		session.close();
	}

	@Override
	public Employee updateEmployee(Employee employee) {
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		Query q = session
				.getNamedQuery(GET_EMPLOYEE_WITH_ADDRESSES);
		q.setParameter("id", employee.getId());
		Employee empFromDB = (Employee) q.uniqueResult();
		copyEmp(employee, empFromDB);
		session.merge(empFromDB);
		transaction.commit();
		session.close();
		return empFromDB;
	}

	private void copyEmp(Employee source, Employee target) {
		if (StringUtils.isNotEmpty(source.getfName())) {
			target.setfName(source.getfName());
		}
		if (StringUtils.isNotEmpty(source.getlName())) {
			target.setlName(source.getlName());
		}
		if (StringUtils.isNotEmpty(source.getDateOfBirth())) {
			target.setDateOfBirth(source.getDateOfBirth());
		}
		if (StringUtils.isNotEmpty(source.getMobileNo())) {
			target.setMobileNo(source.getMobileNo());
		}
		if (StringUtils.isNotEmpty(source.getMaritalStatus())) {
			target.setMaritalStatus(source.getMaritalStatus());
		}
		
		List<Address> targetAddrss = target.getAddresses();
		List<Address> sourceAddrss = source.getAddresses();
		if(targetAddrss==null || targetAddrss.isEmpty()){
			target.setAddresses(sourceAddrss);
		}else{
			for(Address sAdd: sourceAddrss){
				Address tAdd = getAddress(targetAddrss ,sAdd.getAddressType() );
				if(tAdd!=null){
					if(sAdd.getAddrLine1()!=null)
						tAdd.setAddrLine1(sAdd.getAddrLine1());
					
					if(sAdd.getAddrLine2()!=null)
						tAdd.setAddrLine2(sAdd.getAddrLine2());
					
					if(sAdd.getCity()!=null)
						tAdd.setCity(sAdd.getCity());
					
					if(sAdd.getCountry()!=null)
						tAdd.setCountry(sAdd.getCountry());
					
					if(sAdd.getPin()!=null)
						tAdd.setPin(sAdd.getPin());
					
					if(sAdd.getState()!=null)
						tAdd.setState(sAdd.getState());
				}
			}
		}
	}

	private Address getAddress(List<Address> targetAddrss, Integer addressType) {
		for(Address tAdd : targetAddrss){
			if(tAdd.getAddressType().equals(addressType)){
				return tAdd;
			}
		}
		return null;
	}

	@Override
	public boolean isEmployeeExists(String str) {
		Session session = sessionFactory.openSession();
		Query q = session
				.getNamedQuery(CHECK_EMP_EXISTS);
		q.setParameter("inputName", str);
		long count = (Long) q.uniqueResult();
		session.close();
		return count >=1 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public ResponseDTO<Employee> getEmployees(int pageNo) {
		Session session = sessionFactory.openSession();
		ResponseDTO<Employee> resDto = new ResponseDTO<Employee>();
		Query query = session.createQuery("from Employee");
		updatePaginationSettings(pageNo, resDto, query);
		resDto.setResponseList(query.list());
		session.close();
		return resDto;
	}
	
	public void updatePwd(Integer id, String newPass){
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		Query query1 = session.createQuery("Update Employee set password=:pwd where id=:id");
		query1.setParameter("pwd", newPass);
		query1.setParameter("id", id);
		query1.executeUpdate();
		transaction.commit();
		session.close();
	}
	
	private void updatePaginationSettings(int pageNo,ResponseDTO<Employee> resDto, 
			Query query) {
		Session session = sessionFactory.getCurrentSession();
		Query query1 = session.getNamedQuery(GET_EMP_COUNT);
		long count = (long) query1.uniqueResult();

		int resultsPerPage = RESULT_PER_PAGE;
		int firstResult = (pageNo - 1) * resultsPerPage;
		query.setFirstResult(firstResult);
		query.setMaxResults(resultsPerPage);

		int noOfPages = (int) count / resultsPerPage;
		int rem = (int) count / resultsPerPage;

		if (rem > 0) {
			noOfPages = noOfPages + 1;
		}
		resDto.setNoOfPages(noOfPages);
	}

	public Employee getValidEmpByAuth(Employee employee) {
		Session session = sessionFactory.openSession();
		Query q = session
				.getNamedQuery(GET_EMP_BY_AUTH);
		q.setParameter("eName", employee.getLoginName());
		q.setParameter("ePass", employee.getPassword());
		Employee validEmp = (Employee) q.uniqueResult();
		session.close();
		return validEmp;
	}

	public Employee getEmployee(int id) {
		Session session = sessionFactory.openSession();
		Query q = session
				.getNamedQuery(GET_EMPLOYEE_WITH_ADDRESSES);
		q.setParameter("id", id);
		Employee validEmp = (Employee) q.uniqueResult();
		session.close();
		return validEmp;
	}

	public void deleteEmployee(Employee employee) {
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		session.delete(employee);
		transaction.commit();
		session.close();
	}

	public Employee searchByName(String name) {
		Session session = sessionFactory.openSession();
		Criteria c = session.createCriteria(Employee.class);
		Criterion cr = Restrictions.eq("fName", name);
		c.add(cr);
		Employee employee = (Employee) c.uniqueResult();
		session.close();
		return employee;
	}

	@SuppressWarnings("unchecked")
	public ResponseDTO<Employee> getAdvancedSearchResult(
			EmployeeRequest employeeReq) {
		Session session = sessionFactory.openSession();
		Criteria empCriteria = sessionFactory.getCurrentSession().createCriteria(
				Employee.class);

		if (StringUtils.isNotEmpty(employeeReq.getfName())) {
			empCriteria.add(Restrictions.like("fName", "%"+employeeReq.getfName()+"%"));
		}
		
		if (StringUtils.isNotEmpty(employeeReq.getlName())) {
			empCriteria.add(Restrictions.like("lName", "%"+employeeReq.getlName()+"%"));
		}
		
		if(StringUtils.isNotEmpty(employeeReq.getDeptId())){
			Criteria deptCriteria = empCriteria.createCriteria("department");
			deptCriteria.add(Restrictions.eq("name", employeeReq.getDeptId()));
		}
		
		if(StringUtils.isNotEmpty(employeeReq.getCity())){
			Criteria addressCriteria = empCriteria.createCriteria("addresses");
			addressCriteria.add(Restrictions.eq("city", employeeReq.getCity()));
		}
		
		ResponseDTO<Employee> responseDTO = new ResponseDTO<Employee>(1,
				empCriteria.list());
		session.close();
		return responseDTO;
	}

	@Override
	public ResponseDTO<Employee> getAllEmps(String sortBy) {
		Session session = sessionFactory.openSession();
		Criteria c = session.createCriteria(Employee.class);
		c.addOrder(Order.asc(sortBy));
		List<Employee> list = c.list();
		ResponseDTO<Employee> responseDTO = new ResponseDTO<Employee>(0, list);
		session.close();
		return responseDTO;
	}

	@Override
	public CreateEmpDetails getManagerAndDepts() {
		Session session = sessionFactory.openSession();
		List<Object[]> list1 = session.getNamedQuery(GET_MANAGER_INFO).list();
		List<Employee> emps = getEmpList(list1);

		List<Object[]> list2 = session.getNamedQuery(GET_DEPT_INFO).list();
		List<Department> depts = new ArrayList<Department>();
		for(Object[] o:list2){
			Department d = new Department();
			d.setId((Integer)o[0]);
			d.setName((String)o[1]);
			depts.add(d);
		}
		CreateEmpDetails createEmpDetails = new CreateEmpDetails(emps, depts);
		session.close();
		return createEmpDetails;
	}

	private List<Employee> getEmpList(List<Object[]> list1) {
		List<Employee> emps = new ArrayList<Employee>();
		for(Object[] o:list1){
			Employee e = new Employee();
			e.setId((Integer)o[0]);
			e.setfName((String)o[1]);
			e.setlName((String)o[2]);
			emps.add(e);
		}
		return emps;
	}

	@Override
	public List<Employee> getBasicEmpDetails() {
		Session s = sessionFactory.openSession();
		List<Object[]> list =(List<Object[]>) s.getNamedQuery(GET_BASIC_EMP_DETAILS).list();
		List<Employee> emps = getEmpList(list);
		s.close();
		return emps;
	}
}