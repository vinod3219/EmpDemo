<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Search Department</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h3><label id="searchDeptFormLbl">Search Department ID Form</label></h3>
	<font color="Red">${msg}</font>
	<form:form action="./searchDept">
		<table>
			<tr>
				<td><label id="deptLbl">Search Department</label> &nbsp;&nbsp; <input type="text"
					name="name" />&nbsp;&nbsp;
				</td>
				<td><input type="submit" value="Search" /></td>
			</tr>
		</table>
	</form:form>

	<c:if test="${department != null}">
		<jsp:include page="showDept.jsp" />
	</c:if>

</body>
</html>