package com.project.mall.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.project.mall.DTO.PaymentData;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "payment")
public class Payment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String pay_method;
	private String impUid;
	private String merchantUid;
	private String name;
	private int amount;
	private String buyerName;
	private String buyerId;
	private String buyerEmail;
	private String buyerTel;
	private String buyerAddr;

	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private LocalDate payedDate;

	@OneToMany(mappedBy = "payment", cascade = CascadeType.MERGE, fetch = FetchType.EAGER, orphanRemoval = false)
	private List<CartItem> cartItems;

	@ManyToOne
	@JoinColumn(name = "item_id")
	private Item item;

	public static Payment convertPaymentDataToPayment(PaymentData paymentData) {
	    Payment payment = new Payment();
	    payment.setPay_method(paymentData.getPay_method());
	    payment.setImpUid(paymentData.getImp_uid());
	    payment.setMerchantUid(paymentData.getMerchant_uid());
	    payment.setName(paymentData.getName());
	    payment.setAmount(paymentData.getAmount());
	    payment.setBuyerName(paymentData.getBuyer_name());
	    payment.setBuyerAddr(paymentData.getBuyer_addr());
	    payment.setBuyerEmail(paymentData.getBuyer_email());
	    payment.setBuyerTel(paymentData.getBuyer_tel());
	    payment.setPayedDate(paymentData.getPayedDate());
	    payment.setBuyerId(paymentData.getBuyer_id());
	    payment.setCartItems(new ArrayList<>());
	    List<CartItem> cartItems = paymentData.getCartItems();
	    payment.getCartItems().addAll(cartItems);

	    return payment;
	}

	public void addCartItem(CartItem cartItem) {
		if (cartItems == null) {
			cartItems = new ArrayList<>();
		}
		cartItems.add(cartItem);
		cartItem.setPayment(this);
	}

}
