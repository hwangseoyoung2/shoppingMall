package com.project.mall.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mall.DTO.AnswerDTO;
import com.project.mall.entity.Answer;
import com.project.mall.entity.Question;
import com.project.mall.exception.QuestionNotFoundException;
import com.project.mall.exception.UnauthorizedAccessException;
import com.project.mall.repository.AnswerRepository;
import com.project.mall.repository.QuestionRepository;

@Service
public class AnswerService {

	@Autowired
	AnswerRepository answerRepository;
	
	@Autowired
	QuestionRepository questionRepository;
	
	public List<Answer> findByQuestionId(Long id) {
		return answerRepository.findByQuestionId(id);
	}
	
	public void saveAnswer(AnswerDTO answerDTO, HttpSession session) {
	    Long questionId = answerDTO.getQuestionId();
	    
	    String memberId = (String) session.getAttribute("memberId");
	    
	    Question question = questionRepository.findById(questionId).orElse(null);

	    if (question != null) {
	        if ("admin".equals(memberId)) {
	            Answer answer = Answer.builder()
	                    .content(answerDTO.getContent())
	                    .createdDate(answerDTO.getCreatedDate())
	                    .question(question)
	                    .build();
	            answerRepository.save(answer);
	        } else {
	            throw new UnauthorizedAccessException("관리자만 작성 가능합니다");
	        }
	    } else {
	        throw new QuestionNotFoundException("게시글을 찾는 중 오류가 발생했습니다");
	    }
	}

	public void deleteById(Long id) {
		answerRepository.deleteById(id);
	}
	
	public Answer findById(Long id) {
		return answerRepository.findById(id).orElse(null);
	}
} 
