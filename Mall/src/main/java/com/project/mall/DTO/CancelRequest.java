package com.project.mall.DTO;

import java.time.LocalDate;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CancelRequest {
	
	private long id;
	private String impUid;
	private int cancel_request_amount;
	private String reason;
	private String buyerAddr;
	private String buyerName;
	private String productName;
	private String buyerTel;
	private String buyerEmail;
	private LocalDate cancelDate = LocalDate.now();
}
