package com.skilldistillery.itinerary.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.itinerary.data.ItineraryDAO;
import com.skilldistillery.itinerary.data.UserDAO;
import com.skilldistillery.itinerary.entities.Itinerary;
import com.skilldistillery.itinerary.entities.User;

@Controller
@SessionAttributes("loggedInUser")
public class UserController {

	@Autowired
	private UserDAO userDao;
	@Autowired
	private ItineraryDAO itineraryDao;
	
	@ModelAttribute("loggedInUser")
	public User initSessionState () {
		return new User();
	}
	
	@RequestMapping(path= {"/", "home.do"})
	public String home(Model model, @ModelAttribute("loggedInUser") User user) {
		List<Itinerary> itineraries = itineraryDao.findAllActiveItineraries();
		model.addAttribute("itineraries", itineraries);
		return "home";
	}

	@GetMapping(path="loginForm.do")
	public String loginForm () {
		return "loginScreen";
	}
	
	@GetMapping(path="createAccountForm.do")
	public String createAccountForm () {
		return "createAccount";
	}
	
	@GetMapping(path="profilePage.do")
	public String profilePage (Model model,@ModelAttribute("loggedInUser") User user ) {
		List<Itinerary> userItineraries = itineraryDao.findUserItineraries(user);
		model.addAttribute("itineraries", userItineraries);
		return "profilePage";
	}
	
	@GetMapping(path="viewAccount.do", params= {"userId"})
	public String viewSomeonesProfile (int userId, Model model, @ModelAttribute("loggedInUser") User user) {
		User userPageToView = userDao.findById(userId);
		List<Itinerary> userItineraries = itineraryDao.findUserItineraries(userPageToView);
		model.addAttribute("itineraries", userItineraries);
		if (user.getId() != userId) {
		model.addAttribute("userId", userPageToView);
		}
		return "profilePage";
	}
	
	@PostMapping(path= "login.do")
	public String login (Model model, @ModelAttribute("loggedInUser") User user, SessionStatus sessionStatus, HttpSession session) {
		user = userDao.findByUsernameAndPassword(user.getUsername(), user.getPassword());
		System.out.println(user);
		model.addAttribute("loggedInUser", user);
		Boolean success = false;
		String view = "home";
		if (user != null) {
			success = true;
			List<Itinerary> itineraries = itineraryDao.findAllActiveItineraries();
			model.addAttribute("itineraries", itineraries);
		} else {
			view = "loginFailed";
			sessionStatus.setComplete();
		}
		model.addAttribute("loginSuccess", success);
		return view;
	}
	
	@PostMapping(path="logout.do")
	public String logout (Model model, SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		List<Itinerary> itineraries = itineraryDao.findAllActiveItineraries();
		model.addAttribute("itineraries", itineraries);
		return "home";
	}
	
	@PostMapping(path="createAccount.do")
	public String createAccount(Model model,@ModelAttribute("loggedInUser") User user) {
		User createdUser = null;
		if (userDao.findByUsername(user.getUsername()) == null) {
			createdUser = userDao.addUser(user);
		} else {
			model.addAttribute("loggedInUser", new User());
		}
		Boolean success = false;
		if (createdUser != null) {
			success = true;
			List<Itinerary> itineraries = itineraryDao.findAllActiveItineraries();
			model.addAttribute("itineraries", itineraries);
		}
		model.addAttribute("creationSuccess", success);
		return "home";
	}
	
	@PostMapping(path="goUpdateAccount.do")
	public String goUpdateAccount(Model model, int updateId) {
		User user = userDao.findById(updateId);
		model.addAttribute("updateId", user);
		return "updateAccount";
	}
	
	@PostMapping(path="updateAccount.do") 
	public String updateAccount (Model model, User formInput, int accountId){
		model.addAttribute("loggedInUser", userDao.updateUser(formInput, accountId));
		return "redirect:profilePage.do";
	}
	
	@PostMapping(path="goDeleteAccount.do")
	public String goDeleteAccount (Model model, int deleteId) {
		User deleteMe = userDao.findById(deleteId);
		model.addAttribute("deleteMe", deleteMe);
		return "deleteAccount";
	}
	
	@PostMapping(path="deleteAccount.do")
	public String deleteAccount (@ModelAttribute("loggedInUser") User user, int deleteId, RedirectAttributes redir, SessionStatus sessionStatus) {
		if (!user.getUsername().equals("admin")) {
			sessionStatus.setComplete();
		}
		userDao.deleteAccount(deleteId);
		return "redirect:home.do";
	}
	
	@GetMapping(path= "adminViewAllUsers.do")
	public String adminViewAllItineraries(Model model) {
		List<User> activeUsers = userDao.findAllActiveUsers();
		List<User> disabledUsers = userDao.findAllDisabledUsers();
		model.addAttribute("active", activeUsers);
		model.addAttribute("disabled", disabledUsers);
		return "adminViewAllUsers";
	}
	
}
