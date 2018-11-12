package com.mythri.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.mythri.entity.Address;
import com.mythri.util.UserException;

@Repository("addressDao")
public class AddressDaoImpl implements AddressDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void addAddress(Address address) throws UserException {
		sessionFactory.getCurrentSession().saveOrUpdate(address);
	}

}
