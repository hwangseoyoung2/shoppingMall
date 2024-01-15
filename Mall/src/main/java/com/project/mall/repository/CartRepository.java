package com.project.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


import com.project.mall.entity.Cart;
import com.project.mall.entity.Member;

public interface CartRepository extends JpaRepository<Cart, Long> {
	
	Cart findByMemberId(Long id);
	
	Cart findByMemberMemberId(String memberId);
	
	List<Cart> findByMember(Member member);
	
	Cart findByKakaoUserUserId(String userId);

}
