package org.nhnnext.web;

import javax.servlet.http.HttpSession;

import org.nhnnext.repository.BoardRepository;
import org.nhnnext.repository.UserRepository;
import org.nhnnext.support.FileUploader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@RequestMapping("/form")
	public String form() {
		return "form";
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public String create(Board board, MultipartFile file, HttpSession session) {
		try {
			// 파일을 서버에 업로드 한다.
			String fileName = FileUploader.upload(file);
			// Board에 파일 이름을 넣는다. 
			board.setFileName(fileName);
			// 로그인한 유저의 userId를 받아온다. 
			String userId = (String)session.getAttribute("userId");
			// 받아온 userId로 User DB의 user를 찾는다. 
			User foundUser = userRepository.findByUserId(userId);
			// board에 user를 세팅한다. 세팅한 유저가 게시글을 업로드 한 것이다.
			board.setUser(foundUser);
			// board DB 에 게시글을 저장한다.
			Board savedBoard = boardRepository.save(board);
			return "redirect:/board/" + savedBoard.getId();
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
			return null;
		}
		
	}
	
	@RequestMapping(value = "/modify/{id}")
	public String modify() {
		return "modify";
	}
	
	@RequestMapping(value = "/modify/{id}", method = RequestMethod.POST)
	public String modify(Board board, MultipartFile file, @PathVariable Long id, Model model) {
		try {
			// TODO DB에서 id에 해당하는 Board 데이터를 조회해야 한다.
			Board foundBoard = boardRepository.findOne(id);
			// 찾은 Board 데이터에 파일 이름 입
			String fileName = FileUploader.upload(file);
			foundBoard.setFileName(fileName);
			// TODO 조회한 Board 데이터를 Model에 저장해야 한다.
			foundBoard = boardRepository.save(foundBoard);
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		return "redirect:/board/" + id;
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	public String modify(@PathVariable Long id) {
		try {
			// TODO DB에서 id에 해당하는 Board 데이터를 조회해야 한다.
			Board foundBoard = boardRepository.findOne(id);
			// Board의 데이터를 지운다.
			boardRepository.delete(foundBoard);
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@RequestMapping("/{id}")
	public String show(@PathVariable Long id, Model model) {
		// TODO DB에서 id에 해당하는 Board 데이터를 조회해야 한다.
		Board foundBoard = boardRepository.findOne(id);
		// TODO 조회한 Board 데이터를 Model에 저장해야 한다.
		model.addAttribute("board", foundBoard);
		
		return "show";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		// Board의 모든 데이터 조회 
		model.addAttribute("boards", boardRepository.findAll());
		return "list";
	}
}