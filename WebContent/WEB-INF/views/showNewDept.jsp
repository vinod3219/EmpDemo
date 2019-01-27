<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Show Department</title>
</head>
<body>
<jsp:include page="header.jsp"/>
	<c:if test="${empty department }">
	<label id="noDeptLbl">Department not found</label>
	</c:if>

	<c:if test="${not empty department }">
		<h3><label id="deptDetailsLbl">Department Details</label></h3>
		<table align="left" border="1">
			<tr>
				<td><label id="deptIdLbl">Department ID</label></td>
				<td>${department.id}</td>
			</tr>

			<tr>
				<td><label id="deptNameLbl">Department Name</label></td>
				<td>${department.name}</td>
			</tr>

			<tr>
				<td><label id="deptHeadLbl">Department Head</label></td>
				<td>${department.deptHeadIdAndName}</td>
			</tr>

			<tr>
				<td><label id="createdLbl">Created Date</label></td>
				<td>${department.createdDate}</td>
			</tr>
		</table>
	</c:if>
</body>
</html>