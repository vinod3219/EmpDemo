package com.mythri.controller;

import static com.mythri.util.Constants.COMMAND;
import static com.mythri.util.Constants.DEPT_CREATE;
import static com.mythri.util.Constants.DEPT_DELETE;
import static com.mythri.util.Constants.DEPT_UPDATE;
import static com.mythri.util.Constants.GET_DEPTS;
import static com.mythri.util.Constants.SEARCH_DEPT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

	@RequestMapping(value = DEPT_CREATE, method = RequestMethod.GET)
	public ModelAndView registerForm() {
		List<Employee> emps = empService.getBasicEmpDetails();
		ModelAndView modelAndView = new ModelAndView("addDepartment", COMMAND,
				new Department());
		modelAndView.addObject("emps", emps);
		return modelAndView;
	}

	@RequestMapping(value = DEPT_CREATE, method = RequestMethod.POST)
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
		ModelAndView modelAndView = new ModelAndView("showNewDept");
		modelAndView.addObject("department", department);
		return modelAndView;
	}

	@RequestMapping(value = DEPT_UPDATE, method = RequestMethod.GET)
	public ModelAndView editDepartment(@RequestParam("id") int id) {
		Department department = departmentService.getDepartmentById(id);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put(COMMAND, department);
		return new ModelAndView("showUpdateDept", model);
	}

	@RequestMapping(value = DEPT_UPDATE, method = RequestMethod.POST)
	public ModelAndView updateEmployee(
			@ModelAttribute(COMMAND) Department department, BindingResult result) {
		departmentService.updateDepartment(department);
		return new ModelAndView("showUpdateDept", "department", department);
	}

	@RequestMapping(value = GET_DEPTS, method = RequestMethod.GET)
	public ModelAndView getDeps(ModelMap modelMap) {
		List<Department> list = departmentService.listDepartments();
		modelMap.put("depts", list);
		return new ModelAndView("deptList", modelMap);
	}

	@RequestMapping(value = SEARCH_DEPT, method = RequestMethod.GET)
	public ModelAndView showSearchdept() {
		return new ModelAndView("searchDept");
	}

	@RequestMapping(value = SEARCH_DEPT, method = RequestMethod.POST)
	public ModelAndView processSearchdept(@RequestParam("name") String name) {
		Department department = departmentService.getDeptWithEmps(name);
		ModelAndView modelAndView = new ModelAndView("searchDept");
		modelAndView.addObject("department", department);
		if (department == null) {
			modelAndView.addObject("msg", "Department Not found");
		}
		return modelAndView;
	}
	
	@RequestMapping(value = DEPT_DELETE, method = RequestMethod.GET)
	public ModelAndView deleteDepartment(@RequestParam("id") int id) {
		Department dept = new Department();
		dept.setId(id);
		ModelAndView modelAndView = new ModelAndView("redirect:" + GET_DEPTS);
		try {
			departmentService.deleteDepartment(dept);
		} catch (UserException e) {
			modelAndView.addObject("msg",e.getMessage());
		}
		return modelAndView;
	}
}