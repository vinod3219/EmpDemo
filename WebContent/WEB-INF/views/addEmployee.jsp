<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	</head>
	<script type="text/javascript">
function check() {
	
	 var loginName = document.forms["empCreate"]["loginName"];
	 var password = document.forms["empCreate"]["password"] ;
	 var fName = document.forms["empCreate"]["fName"];
	 var mobileNo = document.forms["empCreate"]["mobileNo"];
	 var salary = document.forms["empCreate"]["salary"];
	 
	 if(loginName.value == "" ){
		 alert( "Please provide loginName!" );
		 loginName.focus() ;
	     return false;
	 }
	 
	 if(password.value == "" ){
		 alert( "Please provide Password!" );
		 password.focus() ;
	     return false;
	 }
	 
	 if(fName.value == "" ){
		 alert( "Please provide first Name!" );
		 fName.focus() ;
	     return false;
	 }
	 
	 if(mobileNo.value == "" ){
		 alert( "Please provide mobile Number!" );
		 mobileNo.focus() ;
	     return false;
	 }
	 
	 if(salary.value == "" ){
		 alert( "Please provide Salary!" );
		 salary.focus() ;
	     return false;
	 }
	 return true;
}
</script>

	<body>
	<jsp:include page="header.jsp"/>
		<h2>Add Employee Data</h2>
		<font color="red"> ${errorMsg }</font>
		<form:form method="post" action="empCreate" name="empCreate" commandName="command" onsubmit="return check();">
	   		<table>
			   <tr>
			        <td><label id="empLoginLbl">Employee login Name:</label></td>
                    <td><form:input path="loginName" /></td>
			    </tr>
			    
			     <tr>
			        <td><label id="empPwdLbl">Employee Password:</label></td>
                    <td><form:password path="password" /></td>
			    </tr>
			    <tr>
			        <td><label id="empFnameLbl">Employee First Name:</label> </td>
			        <td><form:input path="fName" /></td>
			    </tr>
			    <tr>
			        <td><label id="empLnameLbl">Employee Last Name:</label> </td>
			        <td><form:input path="lName" /></td>
			    </tr>
			   
			    <tr>
			        <td><label id="desigLbl">Designation:</label> </td>
			        <td>
			        <select name="designation">
				        <option value="Associate Engineer">Associate Engineer</option>
				        <option value="Senior Engineer">Senior Engineer</option>
				        <option value="Analyst">Analyst</option>
				        <option value="System Engineer">System Engineer</option>
				        <option value="Manager">Manager</option>
				        </select> 
			        </td>
			    </tr> 
			    
			    <tr>
			        <td><label id="genderLbl">Gender:</label></td>
			        <td>
			        	<input type="radio" id="mRadio" name="gender" value="male"  checked/>Male
			        	<input type="radio" id="fRadio" name="gender" value="female" />Female
			        </td>
			    </tr>
			    
			    <tr>
			        <td><label id="dobLbl">Date of Birth:</label></td>
			        <td><form:input path="dateOfBirth" /> &nbsp;&nbsp;(mm/dd/yyyy)</td>
			    </tr>

			    <tr>
			        <td><label id="statusLbl">Status:</label></td>
			        <td>
			        <select name="status">
			      		<option value="Active">Active</option>
			      		<option value="Inactive">Inactive</option>
			      	</select>
			        </td>
			    </tr>
			  
			    <tr>
			        <td><label id="deptLbl">Department:</label></td>
			        <td><select name="department.id">
			   		    <c:forEach items="${departments}" var="dept">
			      			<option value="${dept.id}">${dept.name}</option>
			      		</c:forEach>
			      		</select>
					</td>
			    </tr>
			  
			   
			   <tr>
			        <td><label id="managerLbl">Manager :</label></td>
			        <td>
			      <select name="manager.id">
			      <c:forEach items="${managers}" var="manager">
			      <option value="${manager.id}">${manager.fName} -  ${manager.lName} </option>
			      </c:forEach>
			      </select>
			        </td>
			    </tr>

		 	    <tr>
			        <td><label id="empSalLbl">Employee Salary:</label></td>
			        <td><form:input path="salary" /></td>
			    </tr>
				
				<tr>
			   <td><label id="mnoLbl">Mobile No:</label></td>
			        <td><form:input path="mobileNo" /></td>
			    </tr>			    
			    
			    <tr>
			   <td><label id="statusLbl">Marital Status:</label></td>
			        <td>
			         <select name="maritalStatus">
				        <option value="single">Single</option>
				        <option value="divorsed">Divorsed</option>
				        <option value="married">Married</option>
				     </select> 
			        </td>
			    </tr>		
			    
			<jsp:include page="addAddress.jsp"/>
			<tr> <td>
			  <input id="accept" type="checkbox" value="Accept"/> I accept
			  </td> </tr>
			  
			 <tr>
			      <td colspan="2">
			      <input id="submit" type="submit" value="Submit"/></td>
		      </tr>
		      </table>
		</form:form>
	</body>
</html>
