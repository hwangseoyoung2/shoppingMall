package com.project.mall.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.mall.entity.Question;
import com.project.mall.repository.QuestionRepository;

@Service
public class QuestionService {

	@Autowired
	QuestionRepository questionRepository;
	
	public Page<Question> findByItemId(Long id, int page) { 
		Sort sort = Sort.by(Sort.Order.desc("createdDate"));
	    Pageable pageable = PageRequest.of(page, 10, sort);
		return questionRepository.findByItemId(id, pageable);
	}
	
	public Question save(Question question) {
		 return questionRepository.save(question);
	}
	
	public Question findById(Long id) {
		return questionRepository.findById(id).orElse(null);
	}
	
	public void deleteById(Long id) {
		questionRepository.deleteById(id);
	}
	
	public Page<Question> findByAll(int page) {
		Sort sort = Sort.by(Sort.Order.desc("createdDate"));
	    Pageable pageable = PageRequest.of(page, 10, sort);
	    return questionRepository.findAll(pageable);
	}
	
	public Page<Question> findBySearch(String searchCategory, String searchField, Pageable pageable) {
	    if ("전체".equals(searchCategory)) {
	        return questionRepository.findAllByContentContainingOrCategoryContainingOrItemTitleContainingOrMemberMemberIdContainingOrKakaoUserUserIdContaining(
	            searchField, searchField, searchField, searchField, searchField, pageable);
	    } else {
	        switch (searchCategory) {
	            case "category":
	                return questionRepository.findByCategoryContaining(searchField, pageable);
	            case "itemTitle":
	                return questionRepository.findByItemTitleContaining(searchField, pageable);
	            case "userName":
	                if (questionRepository.existsByMemberMemberIdContaining(searchField)) {
	                    return questionRepository.findByMemberMemberIdContaining(searchField, pageable);
	                } else {
	                    return questionRepository.findByKakaoUserUserIdContaining(searchField, pageable);
	                }
	            default:
	                return questionRepository.findAll(pageable);
	        }
	    }
	}

}
