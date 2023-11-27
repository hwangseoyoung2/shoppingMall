package com.project.mall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.mall.DTO.CancleRequest;
import com.project.mall.entity.CanclePayment;
import com.project.mall.repository.CanclePaymentRepository;

@Service
public class CanclePaymentService {

	@Autowired
	CanclePaymentRepository canclePaymentRepository;
	
    public void saveCancelPayment(CancleRequest cancelRequest) {
        CanclePayment cancelPayment = CanclePayment.convertCancelRequestToCancelPayment(cancelRequest);
        canclePaymentRepository.save(cancelPayment);
    }
    
    public List<CanclePayment> selectOne(String impUid) {
    	return canclePaymentRepository.findByImpUid(impUid);
    }
    
    public Page<CanclePayment> findByAllRefundList(int page) {
    	Sort sort = Sort.by(Sort.Order.desc("cancleDate"));
    	Pageable pageable = PageRequest.of(page, 10, sort);
    	return canclePaymentRepository.findAll(pageable);
    }
}
