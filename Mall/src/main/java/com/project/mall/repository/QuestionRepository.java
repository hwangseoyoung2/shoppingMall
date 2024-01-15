package com.project.mall.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.project.mall.entity.Question;

public interface QuestionRepository extends JpaRepository<Question, Long>, JpaSpecificationExecutor<Question> {

	Page<Question> findByItemId(Long id, Pageable pageable);
	
	Page<Question> findByItemTitleContaining(String title, Pageable pageable);
	
	Page<Question> findByMemberMemberIdContaining(String memberId, Pageable pageable);
	
	Page<Question> findByKakaoUserUserIdContaining(String userId, Pageable pageable);
	
	Page<Question> findByCategoryContaining(String category, Pageable pageable);

	boolean existsByMemberMemberIdContaining(String memberId);
	
	 Page<Question> findAllByContentContainingOrCategoryContainingOrItemTitleContainingOrMemberMemberIdContainingOrKakaoUserUserIdContaining(
		        String content, String category, String itemTitle, String memberMemberId, String kakaoUserUserId, Pageable pageable);
}
