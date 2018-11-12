<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Update Department</title>
</head>
<body>
<jsp:include page="header.jsp"/>
	<form:form action="deptUpdate" method="POST" commandName="command">
		<h3><label id="updateDeptLbl">Update Department</label> </h3>
		<table>
			<tr>
				<td><label id="deptIdLbl">Department ID</label></td>
				<td><form:input path="id" readonly="true" /></td>
			</tr>

			<tr>
				<td><label id="deptNameLbl">Department Name</label></td>
				<td><form:input path="name" /></td>
			</tr>

			<tr>
				<td><label id="deptHeadLbl">Department Head</label></td>
				<td>
				<input type="text" value="${command.deptHeadIdAndName}" />
				</td>
			</tr>

			<tr>
				<td><label id="deptCreatedDateLbl">Created Date</label></td>
				<td><form:input path="createdDate" readonly="true" /></td>
			</tr>

			<tr>
				<td><input type="submit" name="submit" value="submit" /></td>
			</tr>
		</table>
	</form:form>
</body>
</html>