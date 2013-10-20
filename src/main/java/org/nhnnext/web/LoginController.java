package org.nhnnext.web;

import javax.servlet.http.HttpSession;

import org.nhnnext.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	@Autowired
	private UserRepository userRepository;
	
	@RequestMapping("/join")
	public String join() {
		return "join_form";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(User user) {
		try {
			// save user to DB
			userRepository.save(user);
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="/signin", method=RequestMethod.POST)
	public String login(String userId, String password, HttpSession session) {
		try {
			// UserId로 User조회 
			User foundUser = userRepository.findByUserId(userId);
			if (foundUser.getPassword().equals(password)) {
				session.setAttribute("userId", userId);
			}
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public String login(HttpSession session) {
		try {
			// User의 session을 지움
			session.removeAttribute("userId");
		} catch (Exception e) {
			e.getMessage();
			e.getStackTrace();
		}
		return "redirect:/";
	}
}
