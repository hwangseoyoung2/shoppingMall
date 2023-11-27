package com.project.mall.DTO;


import java.time.LocalDate;

import com.project.mall.entity.Cart;
import com.project.mall.entity.Member;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CartDTO {
	
	private Long id;
	private Member member;
	private int quantity;
	private LocalDate createDate;

	public static Cart toCart(CartDTO dto) {
		return Cart.builder()
				.id(dto.getId())
				.member(dto.getMember())
				.quantity(dto.getQuantity())
				.createDate(dto.getCreateDate())
				.build();
	}
}
