package com.mythri.controller;

import static com.mythri.util.Constants.COMMAND;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mythri.entity.Department;
import com.mythri.entity.Employee;
import com.mythri.service.DepartmentService;
import com.mythri.service.EmployeeService;
import com.mythri.util.UserException;

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	@Autowired
	private EmployeeService empService;

	@RequestMapping(value = "/deptCreate", method = RequestMethod.GET)
	public ModelAndView registerForm() {
		List<Employee> emps = empService.getBasicEmpDetails();
		ModelAndView modelAndView = new ModelAndView("addDepartment", COMMAND,
				new Department());
		modelAndView.addObject("emps", emps);
		return modelAndView;
	}

	@RequestMapping(value = "/deptCreate", method = RequestMethod.POST)
	public ModelAndView saveDepartment(
			@ModelAttribute(COMMAND) Department department, BindingResult result) {
		try {
			departmentService.addDepartment(department);
		} catch (UserException e) {
			String msg = e.getMessage();
			ModelAndView modelAndView = new ModelAndView("addDepartment",
					COMMAND, department);
			modelAndView.addObject("errorMsg", msg);
			return modelAndView;
		}
		ModelAndView modelAndView = new ModelAndView("showDept");
		modelAndView.addObject("department", department);
		return modelAndView;
	}

	@RequestMapping(value = "/deptDelete", method = RequestMethod.GET)
	public ModelAndView deleteDepartment(@RequestParam("id") int id) {
		Department dept = new Department();
		dept.setId(id);
		departmentService.deleteDepartment(dept);
		return new ModelAndView("employeesList", null);
	}

	@RequestMapping(value = "/deptUpdate", method = RequestMethod.GET)
	public ModelAndView editDepartment(@RequestParam("id") int id) {
		Department department = departmentService.getDepartmentById(id);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put(COMMAND, department);
		return new ModelAndView("showUpdateDept", model);
	}

	@RequestMapping(value = "/deptUpdate", method = RequestMethod.POST)
	public ModelAndView updateEmployee(
			@ModelAttribute(COMMAND) Department department, BindingResult result) {
		departmentService.updateDepartment(department);
		return new ModelAndView("showUpdateDept", "department", department);
	}

	@RequestMapping(value = "/getDepts", method = RequestMethod.GET)
	public ModelAndView getDeps() {
		List<Department> list = departmentService.listDepartments();
		Map<String, Object> map = new HashMap<>();
		map.put("depts", list);
		return new ModelAndView("deptList", map);
	}

	@RequestMapping(value = "/searchDept", method = RequestMethod.GET)
	public ModelAndView showSearchdept() {
		return new ModelAndView("searchDept");
	}

	@RequestMapping(value = "/searchDept", method = RequestMethod.POST)
	public ModelAndView processSearchdept(@RequestParam("name") String name) {
		Department department = departmentService.getDeptWithEmps(name);
		ModelAndView modelAndView = new ModelAndView("searchDept");
		modelAndView.addObject("department", department);
		if (department == null) {
			modelAndView.addObject("msg", "Department Not found");
		}
		return modelAndView;
	}
}