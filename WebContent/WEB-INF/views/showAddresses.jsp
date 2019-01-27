<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <c:forEach var="i" begin="0" end="1">
		   			<c:if test="${i eq 0}">
		   				<h3>
		   	<label id="presentAddrLbl">Present Address :</label>
		   	</h3>
		   			</c:if>
		   			
		   			<c:if test="${i eq 1}">
		   				<h3>
		   				<label id="permAddrLbl">Permanent Address :</label></h3>
		   			</c:if>
	<table border="1" width="30%">
			     <tr>
			        <td width="15%">
			     <label id="addr1Lbl${i}">Address Line 1:</label> </td>
			        <td width="15%">${empty addresses[i].addrLine1 ? '--' : addresses[i].addrLine1} </td>
			    </tr>
			     
			     <tr>
			        <td><label id="addr2Lbl${i}">Address Line 2:</label> </td>
			        <td>  
			        ${empty addresses[i].addrLine2 ? '--' : addresses[i].addrLine2} </td>
			    </tr>
			    
			    <tr>
			        <td><label id="cityLbl${i}">City:</label> </td>
			        <td>
			        ${empty addresses[i].city ? '--' : addresses[i].city}
			        </td>
			    </tr>
			    
			    <tr>
			        <td><label id="stateLbl${i}">State:</label> </td>
			        <td>
			        ${empty addresses[i].state ? '--' : addresses[i].state}
			        </td>
			    </tr>
			    
			    <tr>
			        <td><label id="countryLbl${i}">Country:</label> </td>
			        <td>
			        ${empty addresses[i].country ? '--' : addresses[i].country}
			        </td>
			    </tr>
			    
			    <tr>
			        <td><label id="pinLbl${i}">Pin Code:</label> </td>
			        <td>
			        ${empty addresses[i].pin ? '--' : addresses[i].pin}
			        </td>
			    </tr>
</table>			    
			</c:forEach>
 