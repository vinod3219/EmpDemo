package com.mythri.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mythri.entity.Department;
import com.mythri.util.UserException;

@Repository("departmentDao")
public class DepartmentDaoImpl implements DepartmentDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private EmployeeDao employeeDao;
	
	@Override
	public void addDepartment(Department department) throws UserException {
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		session.save(department);
		transaction.commit();
		department.setManager(employeeDao.getEmployee(department.getManager().getId()));
		session.close();
	}

	@Override
	public void updateDepartment(Department department) {
		Session session = sessionFactory.openSession();
		Transaction transaction = session.getTransaction();
		transaction.begin();
		session.merge(department);
		transaction.commit();
		session.close();
	}

	@Override
	public Department getDepartmentById(int id) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("SELECT d FROM Department d WHERE d.id=:id");
		query.setParameter("id", id);
		Department dept = (Department)query.uniqueResult();
		session.close();
		return dept;
	}
	
	@Override
	public Department getDeptWithEmps(String name) {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("SELECT d FROM Department d LEFT JOIN FETCH d.employees e WHERE d.name=:name");
		query.setParameter("name", name);
		Department dept = (Department)query.uniqueResult();
		session.close();
		return dept;
	}
	
	@Override
	public void deleteDepartment(Department department) {
		Session session = sessionFactory.openSession();
		session.delete(department);
		session.close();
	}

	@Override
	public List<Department> getDepartments() {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Department");
		List<Department> list = query.list();
		session.close();
		return list;
	}

	@Override
	public List<String> getDepartmentNames() {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("select name from Department");
		List<String> list = query.list();
		session.close();
		return list;
	}
}