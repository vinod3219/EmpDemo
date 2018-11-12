package com.mythri.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class EmployeeValidator implements Validator {

public boolean supports(Class<?> clazz) {
		
		return EmployeeCommand.class.equals(clazz);
	}
	public void validate(Object command, Errors errors) {
		EmployeeCommand ec=(EmployeeCommand)command;
		String nm=ec.getName();    String pwd=ec.getPassword();
		String city=ec.getCity();    String utype=ec.getUserType();
		int age=ec.getAge();
		
		if(nm==null || nm.length()==0){
			errors.rejectValue("name", "errors.required",new Object[]{"Name"},null);
		}
		if(pwd==null || pwd.length()==0){
			errors.rejectValue("password", "errors.required",new Object[]{"Password"},null);
		}
		if(city==null || city.length()==0){
			errors.rejectValue("city", "errors.required",new Object[]{"City"},null);
		}
		if(utype==null || utype.length()==0){
			errors.rejectValue("userType", "errors.required",new Object[]{"UserType"},null);
		}
		if(age<18 || age==0){
			errors.rejectValue("age", "errors.required",new Object[]{"Age"},null);
		}
		
	}

	
}
