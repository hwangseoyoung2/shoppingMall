package com.project.mall.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mall.entity.Cart;
import com.project.mall.entity.CartItem;
import com.project.mall.repository.CartItemRepository;
import com.project.mall.repository.CartRepository;

@Service
public class CartItemService {

	@Autowired
	CartItemRepository cartItemRepository;

	@Autowired
	CartRepository cartRepository;

	public CartItem save(CartItem cartItem) {
		return cartItemRepository.save(cartItem);
	}

	@Transactional
	public List<CartItem> cartItemAll() {
		return cartItemRepository.findAll();
	}

	@Transactional
	public void deleteByItemId(List<Long> itemId) {
		cartItemRepository.deleteByItemIdIn(itemId);
	}

	public List<CartItem> getCartItemsByMemberId(String memberId) {
		return cartItemRepository.findByMemberMemberId(memberId);
	}

	public List<CartItem> getCartItemsByKakaoUserId(String userId) {
		return cartItemRepository.findByKakaoUserUserId(userId);
	}

	public CartItem findByCartItemId(Long id) {
		return cartItemRepository.findByItemId(id);
	}

	@Transactional
	public void deleteById(List<Long> cartItemIds) {
		for (Long cartItemId : cartItemIds) {
			CartItem cartItem = cartItemRepository.findById(cartItemId).orElse(null);
			if (cartItem != null) {
				Cart cart = cartItem.getCart();
				cart.setQuantity(cart.getQuantity() - cartItem.getQuantity());
				cartRepository.save(cart);

				// CartItem 삭제
				cartItemRepository.deleteById(cartItemId);
			}
		}
	}

	public boolean deleteCartItemByPaymentId(Long paymentId) {
		List<CartItem> cartItems = cartItemRepository.findByPaymentId(paymentId);

		for (CartItem cartItem : cartItems) {
			cartItemRepository.delete(cartItem);
		}

		return true;
	}

	public List<CartItem> findCartItemsByPaymentId(Long paymentId) {
		System.out.println("cartItemService paymentId: " + paymentId);
		return cartItemRepository.findByPaymentId(paymentId);
	}

	public void deleteCartItems(List<CartItem> cartItems) {
		cartItemRepository.deleteAll(cartItems);
	}

	public CartItem findCartItemById(Long id) {
		return cartItemRepository.findById(id).orElse(null);
	}

	public List<CartItem> findCartItemsByIds(List<Long> cartItemIds) {
		return cartItemRepository.findAllById(cartItemIds);
	}

	public void save(List<CartItem> cartItems) {
		cartItemRepository.saveAll(cartItems);
	}
	
    public List<CartItem> getCartItemsForUser(String memberId) {
        return cartItemRepository.findByMemberMemberId(memberId);
    }
}
