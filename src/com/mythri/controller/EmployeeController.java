package com.mythri.controller;

import static com.mythri.util.Constants.COMMAND;
import static com.mythri.util.Constants.EMP_CREATE;
import static com.mythri.util.Constants.EMP_DELETE;
import static com.mythri.util.Constants.EMP_GET_BY_FILTERS;
import static com.mythri.util.Constants.EMP_PROFILE;
import static com.mythri.util.Constants.EMP_UPDATE;
import static com.mythri.util.Constants.GET_EMP_BY_PAGE;
import static com.mythri.util.Constants.SEARCH_EMP;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mythri.dto.CreateEmpDetails;
import com.mythri.dto.EmployeeRequest;
import com.mythri.dto.ResponseDTO;
import com.mythri.entity.Employee;
import com.mythri.service.EmployeeService;
import com.mythri.util.UserException;

/**
 * @author Murali
 * 
 * Class to handle all Http Requests for employee. 
 *
 */
@Controller
public class EmployeeController {

	private static final String GET_ALL_EMPS = "getAllEmps";
	@Autowired
	private EmployeeService employeeService;
	
	@RequestMapping(value = EMP_CREATE, method = RequestMethod.GET)
	public ModelAndView registerForm() {
		CreateEmpDetails managerAndDepts = employeeService.getManagerAndDepts();
		ModelAndView modelAndView = new ModelAndView("addEmployee", COMMAND, new Employee());
		modelAndView.addObject("departments", managerAndDepts.getDepts());
		modelAndView.addObject("managers", managerAndDepts.getEmps());
		return modelAndView;
	}

	@RequestMapping(value = EMP_CREATE, method = RequestMethod.POST)
	public ModelAndView saveEmployee(
			@ModelAttribute(COMMAND) Employee employee, 
			BindingResult result) {
		try {
			employeeService.addEmployee(employee);
		} catch (UserException e) {
			String msg = e.getMessage();
			ModelAndView modelAndView = new ModelAndView("addEmployee", COMMAND,
					employee);
			modelAndView.addObject("errorMsg", msg);
			return modelAndView;
		}
		ModelAndView model = new ModelAndView("searchEmp", "employee", employee);
		model.addObject("msg", "Employee Created!");
		return model;
	}

	@RequestMapping(value = EMP_PROFILE, method = RequestMethod.GET)
	public ModelAndView empProfile(HttpSession session) {
		Employee employee = (Employee) session.getAttribute("empSession");
		ModelAndView modelAndView = new ModelAndView("empProfile","employee",employee);
		modelAndView.addObject("addresses", employee.getAddresses());
		return modelAndView;
	}
 
		@RequestMapping(value = GET_EMP_BY_PAGE, method = RequestMethod.GET)
	public String employeesList(
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
			Model model) {
		ResponseDTO dto = employeeService.getEmployees(pageNo);
		List<Employee> listOfEmployees = dto.getResponseList();
		model.addAttribute("theEmployees", listOfEmployees);
		model.addAttribute("count", dto.getNoOfPages());
		return "empAdvanceSearch";
	}
	
 	@RequestMapping(value = EMP_GET_BY_FILTERS, method = RequestMethod.GET)
	public String getEmpAdvSearchForm() {
		return "empAdvanceSearch";
	}

	@RequestMapping(value = EMP_GET_BY_FILTERS, method = RequestMethod.POST)
	public ModelAndView performAdvSearch(
			@ModelAttribute(COMMAND) EmployeeRequest employeeReq) {
		ResponseDTO dto = employeeService
				.getFilteredEmployees(employeeReq);
		
		List<Employee> listOfEmployees = dto.getResponseList();
		Map<String, Object> map = new HashMap<>();
		if(listOfEmployees==null || listOfEmployees.isEmpty()){
			map.put("msg", "No Result Found!!");
		}else{
			map.put("emps", listOfEmployees);
			map.put("count", dto.getNoOfPages());
		}
		return new ModelAndView("empAdvanceSearch", map);
	}

	@RequestMapping(value = GET_ALL_EMPS, method = RequestMethod.GET)
	public ModelAndView performAdvSearch(@RequestParam(value="sortBy",required=false,defaultValue="id") String sortBy ) {
		ResponseDTO<Employee> dto = employeeService.getAllEmps(sortBy);
		List<Employee> listOfEmployees = dto.getResponseList();
		Map<String, Object> map = new HashMap<>();
		map.put("emps", listOfEmployees);
		return new ModelAndView("showEmps", map);
	}
	
	@RequestMapping(value = EMP_DELETE, method = RequestMethod.GET)
	public ModelAndView deleteEmployee(@RequestParam("id") int id) {
		Employee emp = new Employee();
		emp.setId(id);
		employeeService.deleteEmployee(emp);
		return new ModelAndView("employeesList");
	}

	@RequestMapping(value = EMP_UPDATE, method = RequestMethod.GET)
	public ModelAndView editEmployee(@RequestParam("id") int id) {
		Employee employee = employeeService.getEmpById(id);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put(COMMAND, employee);
		model.put("addresses", employee.getAddresses());
		return new ModelAndView("updateEmpForm", model);
	}

	@RequestMapping(value = EMP_UPDATE, method = RequestMethod.POST)
	public ModelAndView updateEmployee(
			@ModelAttribute(COMMAND) Employee employee, 
			BindingResult result,
			HttpSession session) {
		try {
			Employee emp = employeeService.updateEmployee(employee);
			session.setAttribute("empSession", emp);
			ModelAndView modelAndView = new ModelAndView("empProfile","employee",emp);
			modelAndView.addObject("addresses", emp.getAddresses());
			return modelAndView;
		} catch (UserException e) {
			String msg = e.getMessage();
			ModelAndView modelAndView = new ModelAndView("updateEmpForm", COMMAND,
					employee);
			modelAndView.addObject("errorMsg", msg);
			return modelAndView;
		}
	}

	@RequestMapping(value = SEARCH_EMP, method = RequestMethod.GET)
	public String searchNameForm() {
		return "searchEmp";
	}

	@RequestMapping(value = SEARCH_EMP, method = RequestMethod.POST)
	public ModelAndView searchByName(
			@RequestParam("reqData") String reqData,
			@RequestParam("searchType") int searchType) {
		Employee employee =null;
		if(searchType==1){
			employee = employeeService.getEmpByName(reqData);
		}else if(searchType==2){
			employee = employeeService.getEmpById(Integer.parseInt(reqData));
		}
		ModelAndView modelAndView = new ModelAndView("searchEmp");
		if(employee==null){
			modelAndView.addObject("msg","Employee Not found");
		}else{
			modelAndView.addObject("employee",employee);
		}
		return modelAndView;
	}
}