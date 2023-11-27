package com.project.mall.entity;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.project.mall.DTO.CancleRequest;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "cancle_payment")
public class CanclePayment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String impUid;
	private int cancle_request_amount;
	private String reason;
	private String buyerAddr;
	private String buyerName;
	private String productName;
	private String buyerTel;
	private String buyerEmail;
	
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private LocalDate cancleDate;
	
	public static CanclePayment convertCancelRequestToCancelPayment(CancleRequest cancleRequest) {
		CanclePayment canclePayment = new CanclePayment();
		canclePayment.setImpUid(cancleRequest.getImpUid());
		canclePayment.setCancle_request_amount(cancleRequest.getCancle_request_amount());
		canclePayment.setReason(cancleRequest.getReason());
		canclePayment.setBuyerAddr(cancleRequest.getBuyerAddr());
		canclePayment.setBuyerName(cancleRequest.getBuyerName());
		canclePayment.setProductName(cancleRequest.getProductName());
		canclePayment.setBuyerTel(cancleRequest.getBuyerTel());
		canclePayment.setCancleDate(cancleRequest.getCancleDate());
		canclePayment.setBuyerEmail(cancleRequest.getBuyerEmail());
		
		return canclePayment;
	}
}
