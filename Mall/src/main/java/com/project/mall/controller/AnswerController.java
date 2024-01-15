package com.project.mall.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mall.DTO.AnswerDTO;
import com.project.mall.entity.Answer;
import com.project.mall.exception.QuestionNotFoundException;
import com.project.mall.exception.UnauthorizedAccessException;
import com.project.mall.repository.AnswerRepository;
import com.project.mall.service.AnswerService;

@Controller
public class AnswerController {

	@Autowired
	AnswerService answerService;
	
	@Autowired
	AnswerRepository answerRepository;
	
	@PostMapping("/addAnswer")
	public ResponseEntity<String> addAnswer(@RequestBody AnswerDTO answerDTO, HttpSession session) {
	    try {
	        answerService.saveAnswer(answerDTO, session);

	        return new ResponseEntity<>("답변이 성공적으로 작성되었습니다.", HttpStatus.OK);
	    } catch (UnauthorizedAccessException e) {
	        return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
	    } catch (QuestionNotFoundException e) {
	        return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
	    } catch (Exception e) {
	        return new ResponseEntity<>("답변 작성 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@DeleteMapping("/deleteAnswer/{answerId}")
	public String deleteAnswer(@PathVariable Long answerId, HttpSession session, RedirectAttributes rttr) {
	    String memberId = (String) session.getAttribute("memberId");

	    if (memberId.equals("admin")) {
	        answerService.deleteById(answerId);
	        return "삭제되었습니다.";
	    } else {
	        rttr.addFlashAttribute("accessAnswer", "notOK");
	        return "redirect:/loginResult";
	    }
	}

	@PostMapping("/updateAnswer/{answerId}")
	public ResponseEntity<String> updateAnswer(@PathVariable Long answerId, @RequestBody AnswerDTO answerDTO, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		Answer answer = answerService.findById(answerId);
		
		if(answer != null) {
			if(memberId.equals("admin")) {
				answer.setContent(answerDTO.getContent());
				answer.setCreatedDate(answerDTO.getCreatedDate());
				answerRepository.save(answer);
				
				System.out.println("content: "+answerDTO.getContent());
				return ResponseEntity.ok("답변이 수정되었습니다.");
	        } else {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("관리자만 수정 가능합니다.");
	        }
	    } else {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("답변을 찾을 수 없습니다.");
	    }
	}
}
