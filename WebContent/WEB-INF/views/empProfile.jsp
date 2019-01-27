<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Employee Profile</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<h3>My Profile</h3>
 	<a href="empUpdate?id=${employee.id}"><label id="updateProfile">Update Profile</label></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="changePwd"><label id="changePwd">Change Password</label></a>
 
 <br/><br/>
<div>
	<table border="1" width="30%">
		<tr>
			<td width="15%"><label id="idLbl">ID</label></td> <td width="15%"> ${employee.id}</td>
		</tr>
		
		
		<tr>
			<td><label id="desigLbl">Designation</label></td> <td> ${employee.designation}</td>
		</tr>
			
		<tr>
			<td><label id="fNameLbl">First Name</label></td> <td> ${employee.fName}</td>
		</tr>
		
		<tr>
			<td><label id="lNameLbl">Last Name</label></td> <td> ${employee.lName}</td>
		</tr>
		
		<tr>
			<td><label id="genderLbl">Gender</label></td> <td> ${employee.gender}</td>
		</tr>		
		
		<tr>
			<td><label id="deptNameLbl">Department Name:</label></td> <td> ${employee.deptName}</td>
		</tr>
		
		<tr>
			<td><label id="managerLbl">Manager Name:</label></td> <td> 
			${employee.managerName}
			</td>
		</tr>
		
		<tr>
			<td><label id="salLbl">Salary</label> </td> <td> ${employee.salary}</td>
		</tr>
		
		<tr>
			<td><label id="loginLbl">Login Name</label> </td> <td> ${employee.loginName}</td>
		</tr>
		
		<tr>
			<td><label id="dobLbl">Date of Birth</label></td> <td> ${employee.dateOfBirth}</td>
		</tr>
		
		<tr>
			<td><label id="dojLbl">Date Of Join</label></td> <td> ${employee.joinDate}</td>
		</tr>	
		
		<tr>
			<td><label id="mnoLbl">Mobile No:</label></td> <td> ${employee.mobileNo}</td>
		</tr>	
		
		<tr>
			<td><label id="martialStatusLbl">Marital Status:</label></td> <td> ${employee.maritalStatus}</td>
		</tr>
		
		<tr>
			<td><label id="statusLbl">Status:</label></td> 
			<td> ${employee.status}</td>
		</tr>	
  	</table>
 	<br/>

 	<jsp:include page="showAddresses.jsp"/>

</div>
</body>
</html>