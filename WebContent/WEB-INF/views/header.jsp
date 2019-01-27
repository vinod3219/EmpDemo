<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
history.go(1); 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #893030;
}

li {
    float: left;
}

li a, .dropbtn {
    display: inline-block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
    background-color: gray;
}

li.dropdown {
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.dropdown:hover .dropdown-content {
    display: block;
}

.active {
    background-color: #472121;
}
</style>
</head>
<body>
	 <c:if test='${empty sessionScope["empSession"]}'> 
   		 <jsp:forward page="/login"/>
	</c:if>
<ul>

  <li><a  href="empProfile"><label id="myProfileLbl">My Profile</label></a></li>
  
  <li class="dropdown">
    <a href="javascript:void(0)" class="dropbtn">
    <label id="EmployeeLbl">Employee</label>
    </a>
    <div class="dropdown-content">
    <c:if test='${sessionScope["empSession"].admin}'>
 	 	<a  href="empCreate">
 	 	<label id="addEmpLbl">Add New Employee</label>
 	 	</a> 
  	</c:if>
      <a href="searchEmp">
      <label id="searchEmpLbl">Search Employee</label>
      </a>
      <a href="empGetByFilters">
      <label id="advSearchEmpLbl">Advance Search</label>
      </a>
     <c:if test='${sessionScope["empSession"].admin}'>
      <a href="getAllEmps">
      <label id="showEmpsLbl">Show All Employees</label>
      </a>
      </c:if>
    </div>
  </li>
  
<c:if test='${sessionScope["empSession"].admin}'>
  <li class="dropdown">
    <a href="javascript:void(0)" class="dropbtn">Department</a>
    <div class="dropdown-content">
 	  <a  href="deptCreate">
 	  <label id="addDeptLbl">Add New Department</label>
 	  </a> 
      <a href="searchDept">
      <label id="searchDeptLbl">Search Department</label>
      </a>
      <a href="getDepts">
      <label id="showDeptsLbl">Show All Departments</label>
      </a>
    </div>
  </li>
  </c:if>
  
 <li><a name="logoutLink" href="logout">
 <label id="logoutLbl">Logout</label>
 </a></li>
</ul>

</body>
</html>
