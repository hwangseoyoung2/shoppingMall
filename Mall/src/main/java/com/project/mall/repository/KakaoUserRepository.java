package com.project.mall.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.KakaoUser;

public interface KakaoUserRepository extends JpaRepository<KakaoUser, String>{

	//검색
	Page<KakaoUser> findByNameContaining(String keyword, Pageable pageable);
	
	Page<KakaoUser> findAll(Pageable pageable);
	
	
}
