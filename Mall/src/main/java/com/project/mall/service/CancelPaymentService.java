package com.project.mall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.mall.DTO.CancelRequest;
import com.project.mall.entity.CancelPayment;
import com.project.mall.repository.CanclePaymentRepository;

@Service
public class CancelPaymentService {

	@Autowired
	CanclePaymentRepository canclePaymentRepository;
	
    public void saveCancelPayment(CancelRequest cancelRequest) {
        CancelPayment cancelPayment = CancelPayment.convertCancelRequestToCancelPayment(cancelRequest);
        canclePaymentRepository.save(cancelPayment);
    }
    
    public List<CancelPayment> selectOne(String impUid) {
    	return canclePaymentRepository.findByImpUid(impUid);
    }
    
    public Page<CancelPayment> findByAllRefundList(int page) {
    	Sort sort = Sort.by(Sort.Order.desc("cancelDate"));
    	Pageable pageable = PageRequest.of(page, 10, sort);
    	return canclePaymentRepository.findAll(pageable);
    }
}
