package com.project.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.Answer;

public interface AnswerRepository extends JpaRepository<Answer, Long> {

	List<Answer> findByQuestionId(Long id);
}
