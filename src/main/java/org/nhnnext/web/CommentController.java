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
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CommentController {

	@Autowired
	private CommentRepository commentRepository;

	@Autowired
	private BoardRepository boardRepository;

	@Autowired
	private UserRepository userRepository;

	@RequestMapping(value = "/board/{id}/comments.json", method = RequestMethod.POST)
	public @ResponseBody
	Comment createAndShow(@PathVariable Long id, String contents, HttpSession session) {
		try {
			Board board = boardRepository.findOne(id);
			Comment comment = new Comment(board, contents);
			// JSON으로 전달하기 위해 자바 객체를 전달. library를 이용해 Object -> JSON
			
			String userId = (String)session.getAttribute("userId");
			User foundUser = userRepository.findByUserId(userId);
			comment.setUser(foundUser);
			
			return commentRepository.save(comment);
		} catch (Exception e) {
			e.getMessage();
			e.getStackTrace();
			
			return null;
		}
		
	}

	@RequestMapping(value = "/board/{id}/reply", method = RequestMethod.POST)
	public String comment(Comment comment, @PathVariable Long id,
			HttpSession session) {
		try {
			// find board having that comment
			Board foundBoard = boardRepository.findOne(id);

			// set board in Comment instance
			comment.setBoard(foundBoard);
			String userId = (String) session.getAttribute("userId");
			User foundUser = userRepository.findByUserId(userId);
			comment.setUser(foundUser);
			// save comment to DB
			commentRepository.save(comment);
		} catch (Exception e) {
			e.getMessage();
			e.getStackTrace();
		}
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "board/comment/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody
	String delete(@PathVariable Long id) {
		try {
			// TODO DB에서 id에 해당하는 Comment 데이터를 조회해야 한다.
			Comment foundComment = commentRepository.findOne(id);
			// Board의 데이터를 지운다.
			commentRepository.delete(foundComment);
			return "성공";
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
			return "실패";
		}
	}
}
