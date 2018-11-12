package com.mythri.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mythri.dao.AddressDao;
import com.mythri.entity.Address;
import com.mythri.util.UserException;
@Service("addressService")
@Transactional
public class AddressServiceImpl implements AddressService {

		@Autowired
		private AddressDao addressDao;
		
		@Override
		public void addAddress(Address address) throws UserException {
			addressDao.addAddress(address);
	}

}
