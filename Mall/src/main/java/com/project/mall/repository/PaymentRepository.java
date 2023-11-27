package com.project.mall.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
	
    List<Payment> findByBuyerId(String userId);
    
    void deleteByImpUid(String impUid);
    
    List<Payment> findByBuyerEmail(String email);
    
    List<Payment> findByImpUid(String impUid);
    
    Page<Payment> findAll(Pageable pageable);

    Payment findSingleByBuyerEmail(String email);

}
