<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Emp Advance Search</title>
</head>
<body>
<jsp:include page="header.jsp"/>

<c:if test="${emps != null}">
	<c:set var="pageUrl" value="getAllEmps" scope="request"/>
	<jsp:include page="employeesList.jsp"/>
</c:if>
</body>
</html>