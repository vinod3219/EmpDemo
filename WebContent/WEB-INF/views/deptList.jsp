<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<jsp:include page="header.jsp"/>
<h3>List of Departments</h3>
<c:if test="${empty depts}">
	No Departments Available.
</c:if>		
		
<c:if test="${!empty depts}">
	<table align="left" border="1">
		<tr>
			<th><label id="deptIdLbl">Department ID</label></th>
			<th><label id="deptNameLbl">Department Name</label></th>
			<th><label id="deptHeadLbl">Department Head</label></th>
			<th><label id="deptCreatdDateLbl">Created Date</label></th>
		</tr>

		<c:forEach items="${depts}" var="department">
			<tr>
				<td> ${department.id}</td>
				<td> ${department.name}</td>
				<td> ${department.deptHeadIdAndName}</td>
				<td> ${department.createdDate}</td>
				<td align="center"><a href="deptUpdate?id=${department.id}">Edit</a> | <a href="empDelete?id=${employee.id}">Delete</a></td>  
			</tr>
		</c:forEach>
		
	</table>
	</c:if>
</body>
</html>