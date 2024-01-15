
package com.project.mall.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mall.entity.Cart;
import com.project.mall.entity.CartItem;
import com.project.mall.entity.Item;
import com.project.mall.entity.KakaoUser;
import com.project.mall.entity.Member;
import com.project.mall.repository.CartItemRepository;
import com.project.mall.repository.CartRepository;
import com.project.mall.repository.ItemRepository;

@Service
public class CartService {
	
	@Autowired
	CartRepository cartRepository;
	
	@Autowired
	ItemRepository itemRepository;
	
	@Autowired
	CartItemRepository cartItemRepository;

	public Cart cartSave(Cart cart) {
		return cartRepository.save(cart);
	}
	
	@Transactional
	public List<Cart> cartAll() {
		return cartRepository.findAll();
	}
	
	public List<Cart> findCart(Member member) {
		return cartRepository.findByMember(member);
	}
	
	@Transactional
	public void addCart(Object user, Item newItem, int amount) {
	    if (user instanceof Member) {
	        addCartForMember((Member) user, newItem, amount);
	    } else if (user instanceof KakaoUser) {
	        addCartForKakaoUser((KakaoUser) user, newItem, amount);
	    } else {
	        throw new IllegalArgumentException("지원되지 않는 사용자 유형입니다.");
	    }
	}

	// 일반회원 장바구니 추가
	private void addCartForMember(Member member, Item newItem, int amount) {
	    Cart cart = cartRepository.findByMemberId(member.getId());
	    
	    if (cart == null) {
	        cart = Cart.createCart(member);
	        cartRepository.save(cart);
	    }
	    
	    Item item = itemRepository.findByIdWithImages(newItem.getId());
	    CartItem cartItem = cartItemRepository.findByCartIdAndItemId(cart.getId(), item.getId());
	    
	    if (cartItem == null) {
	        cartItem = CartItem.createCartItem(cart, item, amount);
	    } else {
	        cartItem.addQuantity(amount);
	    }
	    
	    cartItemRepository.save(cartItem);
	    cart.setQuantity(cart.getQuantity() + amount);
	}

	// 카카오회원 장바구니 추가
	private void addCartForKakaoUser(KakaoUser kakaoUser, Item newItem, int amount) {
	    Cart cart = cartRepository.findByKakaoUserUserId(kakaoUser.getUserId());
	    
	    if (cart == null) {
	        cart = Cart.createKakaoUserCart(kakaoUser);
	        cartRepository.save(cart);
	    }
	    
	    Item item = itemRepository.findByIdWithImages(newItem.getId());
	    CartItem cartItem = cartItemRepository.findByCartIdAndItemId(cart.getId(), item.getId());
	    
	    if (cartItem == null) {
	        cartItem = CartItem.createCartItem(cart, item, amount);
	    } else {
	        cartItem.addQuantity(amount);
	    }
	    
	    cartItemRepository.save(cartItem);
	    cart.setQuantity(cart.getQuantity() + amount);
	}
	
	public Cart getById(Long id) {
		return cartRepository.getById(id);
	}

}
