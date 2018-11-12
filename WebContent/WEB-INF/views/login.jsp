<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<title>Welcome to Online Registration</title>
</head>
<body>
	<h1>Login Page</h1>
	<font color="Red">${msg}</font>    
		<form:form action="login" method = "POST" commandName="command">
		<table>
		<tr>
			<td><label id="userNameLbl">User Name:</label></td>
			<td><input type="text" name="loginName"><td/> 
		</tr>
		<tr>
			<td><label id="pwdLbl">Password:</label></td>
			<td><input type="password" name="password"><td/>
		</tr>
	 		<tr>	    
			<td colspan="2" align="center">
			<input type="submit" value="Login"></td>	
		</tr>
		</table>
		</form:form>
</body>
</html>
