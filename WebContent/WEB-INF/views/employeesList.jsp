<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<h3>List of Employees</h3>

<c:if test="${!empty emps}">
  	<table class="table-bordered table pull-right" align="left" border="1">
		<thead>
 		<tr role="row">
			<c:if test="${!empty pageUrl}">
			<th><a href="${pageUrl}?sortBy=id"><label id="idlbl">ID</label></a></th>
			<th><a href="${pageUrl}?sortBy=fName"><label id="fNamelbl">First Name</label></a></th>
			<th><a href="${pageUrl}?sortBy=lName"><label id="lNamelbl">Last Name</label></a></th>
			<th><a href="${pageUrl}?sortBy=designation"><label id="desinlbl">Designation</label></a></th>
			<th><a href="${pageUrl}?sortBy=gender"><label id="genderlbl">Gender</label></a></th>
			<th><a href="${pageUrl}?sortBy=department.id"><label id="deptlbl">Department</label></a></th>
			<th><a href="${pageUrl}?sortBy=joinDate"><label id="joinDatelbl">Join Date</label></a></th>
			<th><a href="${pageUrl}?sortBy=mobileNo"><label id="mnolbl">Mobile No</label></a></th>
			<th><a href="${pageUrl}?sortBy=mobileNo"><label id="statuslbl">Staus</label></a></th>
			
			</c:if>

			<c:if test="${empty pageUrl}">
			<th><label id="idLbl">ID</label></th>
			<th><label id="fNameLbl">First Name</label></th>
			<th><label id="lNameLbl">Last Name</label></th>
			<th><label id="desigLbl">Designation</label></th>
			<th><label id="genderLbl">Gender</label></th>
			<th><label id="deptLbl">Department</label></th>
			<th><label id="joinDateLbl">Join Date</label></th>
			<th><label id="mnoLbl">Mobile No</label></th>
			<th><label id="statusLbl">Status</label></th>
			</c:if>
			
			
			 <c:if test='${empty sessionScope["empSession"].admin}'> 
   		 			<th>Action</th>
			</c:if>
		</tr>
	</thead>

	<tbody>
		<c:forEach items="${emps}" var="employee">
			<tr>
				<td> ${employee.id}</td>
				<td> ${employee.fName}</td>
				<td> ${employee.lName}</td>
				<td> ${employee.designation}</td>
				<td> ${employee.gender}</td>
				<td> ${employee.deptName}</td>
				<td> ${employee.joinDate}</td>
				<td> ${employee.mobileNo}</td>
				<c:if test='${empty sessionScope["empSession"].admin}'> 
		   		 						<td align="center"><a href="empUpdate?id=${employee.id}">Edit</a> | <a href="empDelete?id=${employee.id}">Delete</a></td>
				</c:if>
  			   <td> ${employee.status}</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	</c:if>
	
	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>	<br/>
	<c:if test="${count>1}">
	<c:forEach var="i" begin="1" end="${count}"> 
		<a href="./getEmpsByPage?pageNo=${i}">
		<c:out value="${i}"></c:out>
		</a>&nbsp;&nbsp;&nbsp;
	</c:forEach>
	</c:if>
</body>
</html>
