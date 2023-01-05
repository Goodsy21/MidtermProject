package com.skilldistillery.itinerary.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.skilldistillery.itinerary.data.UserDAO;
import com.skilldistillery.itinerary.entities.User;

@Controller
@SessionAttributes("loggedInUser")
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@ModelAttribute
	public User initSessionState () {
		return new User();
	}
	
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model, @ModelAttribute("loggedInUser") User user) {
		model.addAttribute("SMOKETEST", userDao.findById(1)); //FIXME: DELETE LATER!
		return "home";
	}
	
	@PostMapping(path= "login.do")
	public String login (Model model, @ModelAttribute("loggedInUser") User user) {
		user = userDao.findByUsernameAndPassword(user.getUsername(), user.getPassword());
		Boolean success = false;
		if (user != null) {
			success = true;
		}
		model.addAttribute("loginSuccess", success);
		return "home";
	}
}
