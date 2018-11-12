package com.mythri.dto;

import java.io.Serializable;
import java.util.List;

public class ResponseDTO<T> implements Serializable {

	private static final long serialVersionUID = -3301796492398927076L;

	private int noOfPages;
	private List<T> responseList;

	public ResponseDTO(int count, List<T> responseList) {
		super();
		this.noOfPages = count;
		this.responseList = responseList;
	}

	public ResponseDTO() {
		super();
	}

	public int getNoOfPages() {
		return noOfPages;
	}

	public void setNoOfPages(int count) {
		this.noOfPages = count;
	}

	public List<T> getResponseList() {
		return responseList;
	}

	public void setResponseList(List<T> responseList) {
		this.responseList = responseList;
	}
}
