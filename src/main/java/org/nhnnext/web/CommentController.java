package org.nhnnext.web;

import javax.servlet.http.HttpSession;

import org.nhnnext.repository.BoardRepository;
import org.nhnnext.repository.CommentRepository;
import org.nhnnext.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommentController {
	
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@RequestMapping(value = "/board/{id}/reply", method = RequestMethod.POST)
	public String comment(Comment comment, @PathVariable Long id, HttpSession session) {
		try {
			// find board having that comment
			Board foundBoard = boardRepository.findOne(id);
			
			// set board in Comment instance
			comment.setBoard(foundBoard);
			String userId = (String)session.getAttribute("userId");
			User foundUser = userRepository.findByUserId(userId);
			comment.setUser(foundUser);
			// save comment to DB
			commentRepository.save(comment);
		} catch (Exception e) {
			e.getMessage();
			e.getStackTrace();
		}
		return "redirect:/board/" + id;
	}
}
