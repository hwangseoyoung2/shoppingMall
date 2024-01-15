package com.project.mall.DTO;

import com.project.mall.entity.Cart;
import com.project.mall.entity.CartItem;
import com.project.mall.entity.Item;
import com.project.mall.entity.Member;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CartItemDTO {
	
	private Long id;
	private int quantity;
	private Member member;
	private Item item;
	private Cart cart;
	
	public static CartItem toCartItem(CartItemDTO dto) {
		return CartItem.builder()
				.id(dto.getId())
				.quantity(dto.getQuantity())
				.member(dto.getMember())
				.item(dto.getItem())
				.build();
	}

}
