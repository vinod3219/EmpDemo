package com.mythri.controller;

import static com.mythri.util.Constants.COMMAND;
import static com.mythri.util.Constants.INDEX;
import static com.mythri.util.Constants.LOGIN;
import static com.mythri.util.Constants.LOGOUT;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mythri.entity.Employee;
import com.mythri.service.EmployeeService;

@Controller
public class CommonController {
	
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = INDEX, method = RequestMethod.GET)
	public ModelAndView welcome() {
		return new ModelAndView("index");
	}

	@RequestMapping(value = LOGIN, method = RequestMethod.GET)
	public String loginForm() {
		return "login";
	}

	@RequestMapping(value = "changePwd", method = RequestMethod.GET)
	public String changePwd() {
		return "changePwd";
	}
	
	// logic for validating uname and pwd
	@RequestMapping(value = LOGIN, method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute(COMMAND) Employee employee,
			BindingResult result,HttpSession session) {
		Employee validUser = employeeService.getValidEmpByAuth(employee);
		if (validUser!=null){
			session.setAttribute("empSession", validUser);
			ModelAndView modelAndView = new ModelAndView("empProfile","employee",validUser);
			modelAndView.addObject("addresses", validUser.getAddresses());
			return modelAndView;
		}
		return new ModelAndView("login","msg","Invalid Login");
	}

	@RequestMapping(LOGOUT)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("empSession");
		session.invalidate();
		return "login";
	}
}
