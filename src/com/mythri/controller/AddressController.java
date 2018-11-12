package com.mythri.controller;

import static com.mythri.util.Constants.COMMAND;
import static com.mythri.util.Constants.EMP_CREATE;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mythri.entity.Address;
import com.mythri.entity.Department;
import com.mythri.service.AddressService;
import com.mythri.service.DepartmentService;
import com.mythri.util.UserException;

@Controller
public class AddressController {

	@Autowired
	private AddressService addressService;

	@RequestMapping(value = "/addCreate", method = RequestMethod.GET)
	public ModelAndView registerForm() {
		return new ModelAndView("register", COMMAND, new Address());
	}

	@RequestMapping(value = "/addCreate", method = RequestMethod.POST)
	public ModelAndView saveDepartment(@ModelAttribute(COMMAND) Address address, 
			BindingResult result) {
		try {
			addressService.addAddress(address);
		} catch (UserException e) {
			String msg = e.getMessage();
			ModelAndView modelAndView = new ModelAndView("register", COMMAND,
					address);
			modelAndView.addObject("errorMsg", msg);
			return modelAndView;
		}
		return new ModelAndView("login");
	}
}
