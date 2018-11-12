package com.mythri.util;

public enum ErrorCodes {
	//common places for all error codes
	
	ERROR1("erro1","age is invalid"),
	ERROR2("erro2","Name already exists"),
	ERROR3("erro3","Name doesnt exists..");
	
	private String errorCode;
	private String desc;
	
	private ErrorCodes(String errorCode, String desc) {
		this.errorCode = errorCode;
		this.desc = desc;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public String getDesc() {
		return desc;
	}
	
	
	
}
