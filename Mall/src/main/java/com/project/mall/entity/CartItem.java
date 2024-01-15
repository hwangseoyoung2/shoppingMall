package com.project.mall.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "cart_item")
public class CartItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private KakaoUser kakaoUser;

	@ManyToOne
	@JoinColumn(name = "item_id")
	private Item item;

	@ManyToOne
	@JoinColumn(name = "cart_id")
	private Cart cart;

	@ManyToOne
    @JoinColumn(name = "payment_id")
    private Payment payment;

	@Column
	private int quantity;

	public void addQuantity(int quantity) {
		this.quantity += quantity;
	}

	public static CartItem createCartItem(Cart cart, Item item, int amount) {
		CartItem cartItem = new CartItem();
		cartItem.setCart(cart);
		cartItem.setItem(item);
		cartItem.setQuantity(amount);

		// 일반 로그인
		if (cart.getMember() != null) {
			cartItem.setMember(cart.getMember());
		}

		// 카카오 로그인
		if (cart.getKakaoUser() != null) {
			cartItem.setKakaoUser(cart.getKakaoUser());
		}

		return cartItem;
	}

	@Override
	public String toString() {
		return "CartItem{" + "id=" + id + ", cart=" + (cart != null ? cart.getId() : null) + ", item="
				+ (item != null ? item.getId() : null) + ", quantity=" + quantity + '}';
	}

	public String getUserId() {
		if (cart != null) {
			if (cart.getKakaoUser() != null) {
				return cart.getKakaoUser().getUserId();
			}
		}
		return cart.getKakaoUser().getUserId();
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

}
