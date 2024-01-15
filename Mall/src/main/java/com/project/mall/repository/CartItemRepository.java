package com.project.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


import com.project.mall.entity.CartItem;


public interface CartItemRepository extends JpaRepository<CartItem, Long> {

	CartItem findByCartIdAndItemId(Long cartId, Long itemId);
	
    List<CartItem> findByMemberMemberId(String memberId);
    
    void deleteByItemIdIn(List<Long> itemIds);
	
	CartItem findByItemId(Long itemId);
	
	List<CartItem> findByKakaoUserUserId(String userId);

	void deleteByIdIn(List<Long> id);
	
	List<CartItem> findByPaymentImpUid(String imp_uid);
	
	List<CartItem> findByPaymentId(Long paymentId);
	
	List<CartItem> findCartItemsByIdIn(List<Long> cartItemIds);

	void save(List<CartItem> cartItems);

    void deleteCartItemsByIdIn(List<Long> cartItemIds);
    
    List<CartItem> findByMemberId(String memberId);
}
