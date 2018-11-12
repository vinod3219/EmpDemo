package com.mythri.dao;

import com.mythri.entity.Address;
import com.mythri.util.UserException;

public interface AddressDao {

	public void addAddress(Address address)throws UserException;

}
