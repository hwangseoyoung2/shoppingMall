package com.project.mall.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.CanclePayment;

public interface CanclePaymentRepository extends JpaRepository<CanclePayment, Long> {

	List<CanclePayment> findByImpUid(String impUid);
	
	Page<CanclePayment> findAll(Pageable pageable);
}
