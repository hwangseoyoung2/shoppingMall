package com.project.mall.DTO;

import java.time.LocalDate;
import java.util.List;

import com.project.mall.entity.CartItem;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentData {

	private Long id;
	private String pay_method;
	private String imp_uid;
	private String merchant_uid;
	private String name;
	private int amount;
	private String buyer_name;
	private String buyer_id;
	private String buyer_email;
	private String buyer_tel;
	private String buyer_addr;
	private LocalDate payedDate = LocalDate.now();
	private List<CartItem> cartItems;
}
