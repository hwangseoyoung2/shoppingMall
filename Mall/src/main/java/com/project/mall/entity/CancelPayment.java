package com.project.mall.entity;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.project.mall.DTO.CancelRequest;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "cancel_payment")
public class CancelPayment {
	
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
	private LocalDate cancelDate;
	
	public static CancelPayment convertCancelRequestToCancelPayment(CancelRequest cancelRequest) {
		CancelPayment canclePayment = new CancelPayment();
		canclePayment.setImpUid(cancelRequest.getImpUid());
		canclePayment.setCancle_request_amount(cancelRequest.getCancel_request_amount());
		canclePayment.setReason(cancelRequest.getReason());
		canclePayment.setBuyerAddr(cancelRequest.getBuyerAddr());
		canclePayment.setBuyerName(cancelRequest.getBuyerName());
		canclePayment.setProductName(cancelRequest.getProductName());
		canclePayment.setBuyerTel(cancelRequest.getBuyerTel());
		canclePayment.setCancelDate(cancelRequest.getCancelDate());
		canclePayment.setBuyerEmail(cancelRequest.getBuyerEmail());
		
		return canclePayment;
	}
}
