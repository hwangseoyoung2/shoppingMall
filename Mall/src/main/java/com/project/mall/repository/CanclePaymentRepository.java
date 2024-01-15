package com.project.mall.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.CancelPayment;

public interface CanclePaymentRepository extends JpaRepository<CancelPayment, Long> {

	List<CancelPayment> findByImpUid(String impUid);
	
	Page<CancelPayment> findAll(Pageable pageable);
}
