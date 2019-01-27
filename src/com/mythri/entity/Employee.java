package com.mythri.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@NamedQueries(
value =
{
 @NamedQuery(name =Employee.GET_EMP_COUNT,query = "select count(*) from Employee"),
 @NamedQuery(name =Employee.GET_EMP_BY_AUTH,query = 
 " from Employee e LEFT JOIN FETCH e.addresses a  "
 + " LEFT JOIN FETCH e.manager mgr "
 + " where e.loginName=:eName and e.password=:ePass"),
 @NamedQuery(name =Employee.CHECK_EMP_EXISTS,query = "select count(*) from Employee  where loginname=:inputName"),
 @NamedQuery(name =Employee.GET_EMPLOYEE_WITH_ADDRESSES,query = "from Employee e LEFT JOIN FETCH e.addresses a where e.id=:id "),
 @NamedQuery(name =Employee.GET_MANAGER_INFO,query = "select id,fName,lName from Employee where designation='MANAGER'"),
 @NamedQuery(name =Employee.GET_BASIC_EMP_DETAILS,query = "select id,fName,lName from Employee "),
 @NamedQuery(name =Employee.GET_DEPT_INFO,query = "select id,name from Department")
}
)
@Entity
@Table(name = "Employee")
public class Employee implements Serializable {
	
	public static final long serialVersionUID = -289937699944859824L;

	public static final String GET_EMP_BY_AUTH = "getEmpByAuth";

	public static final String GET_EMP_COUNT = "getEmpCount";

	public static final String CHECK_EMP_EXISTS = "checkEmpExist";

	public static final String GET_EMPLOYEE_WITH_ADDRESSES = "getEmpWithAddress";

	public static final String GET_MANAGER_INFO = "getManagerInfo";
	
	public static final String GET_DEPT_INFO = "getDepartmentInfo";
	
	public static final String GET_BASIC_EMP_DETAILS = "getBasicEmpDetails";

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	// ,generator="empSequence")
	// @SequenceGenerator(name="empSequence",
	// sequenceName="EMP_SEQUENCE",allocationSize = 1, initialValue= 11000)
	@Column(name = "id")
	private Integer id;

	@Column(name = "fName")
	private String fName;

	@Column(name = "lName")
	private String lName;

	@Column(name = "gender")
	private String gender;

	@Column(name = "dateOfBirth")
	private String dateOfBirth;

	@Column(name = "salary")
	private Double salary;

	@Column(name = "loginName",unique=true)
	private String loginName;

	@Column(name = "password")
	private String password;
	
	@Column(name = "mobileNo")
	private String mobileNo;
	
	@Column(name = "maritalStatus")
	private String maritalStatus;

	@Temporal(TemporalType.DATE)
	private Date joinDate;

	@Column(name = "designation")
	private String designation;

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "manager_id")
	private Employee manager;

	@OneToMany(mappedBy = "manager", fetch = FetchType.LAZY)
	private Set<Employee> subordinates;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "deptId", nullable = true)
	private Department department;
	
	@Column(name = "status")
	private String status;
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "employee")
	private List<Address> addresses;
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}

	public Employee getManager() {
		return manager;
	}

	public void setManager(Employee manager) {
		this.manager = manager;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public Set<Employee> getSubordinates() {
		return subordinates;
	}

	public void setSubordinates(Set<Employee> subordinates) {
		this.subordinates = subordinates;
	}

	public String getDeptName() {
		return department!=null?department.getName() :"";
	}
	
	public boolean isAdmin(){
		return department!=null && department.getName().equals("admin");
	}
	
	public String getManagerName(){
		return manager!=null ? manager.fName + " " + manager.lName : "NA"; 
	}
}
