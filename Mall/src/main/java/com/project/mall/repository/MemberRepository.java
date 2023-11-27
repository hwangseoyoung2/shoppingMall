package com.project.mall.repository;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

	Member findByPassword(String password);

	boolean existsBymemberId(String memberId);

	Member findByMemberId(String memberId);

	@Transactional
	void deleteByMemberId(String memberId);

	Page<Member> findByMemberIdContaining(String keyword, Pageable pageable);

	Page<Member> findAll(Pageable pageable);

	Member findByEmail(String email);

	String findEmailById(String memberId);
	
}
