package com.project.mall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mall.entity.Cart;
import com.project.mall.entity.CartItem;
import com.project.mall.entity.Item;
import com.project.mall.entity.KakaoUser;
import com.project.mall.entity.Member;
import com.project.mall.service.CartItemService;
import com.project.mall.service.CartService;
import com.project.mall.service.ItemService;
import com.project.mall.service.MemberService;

@Controller
public class CartController {

	@Autowired
	CartService cartService;

	@Autowired
	CartItemService cartItemService;

	@Autowired
	MemberService memberService;

	@Autowired
	ItemService itemService;

	// 장바구니 페이지
	@GetMapping("/myCart")
	public String myCart(Cart cart, Model model, HttpSession session) {
	    String memberId = (String) session.getAttribute("memberId");
	    Member member = memberService.findByMemberId(memberId);
	    KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");

	    List<CartItem> itemList = new ArrayList<>();
	    boolean isKakaoLogin = false;
	    // 일반 회원
	    if (memberId == null && kakaoUser == null) {
	        return "redirect:/sessionOver";
	    } else {
	        if (memberId != null) {
	            itemList.addAll(cartItemService.getCartItemsByMemberId(memberId));
	            model.addAttribute("member",member);
	            model.addAttribute("loginMethod", "member");
	        }	

	        if (kakaoUser != null) {
	        	//주문 시 카카오 로그인, 일반 로그인 구분을 위해
	        	isKakaoLogin = true;
	        	model.addAttribute("kakaoUser", kakaoUser);
	            itemList.addAll(cartItemService.getCartItemsByKakaoUserId(kakaoUser.getUserId()));
	            model.addAttribute("loginMethod", "kakao");
	        }

	        model.addAttribute("itemList2", itemList);
	        session.setAttribute("itemList", itemList);
	        model.addAttribute("isKakaoLogin", isKakaoLogin);
	    }

	    return "cart/myCart";
	}

	@PostMapping("/addCart")
	public String addCartItem(@RequestParam("id") Long id, HttpSession session, Model model,
			@RequestParam("amount") int amount) {
		try {
			Item addItem = itemService.findById(id);
			String memberId = (String) session.getAttribute("memberId");
			Member member = memberService.findByMemberId(memberId);
			model.addAttribute("member", member);
			model.addAttribute("addItem", addItem);

			KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");

			if (kakaoUser != null) {
				cartService.addCart(kakaoUser, addItem, amount);
			} else if (memberId != null) {
				cartService.addCart(member, addItem, amount);
			} else {
				throw new IllegalArgumentException("지원되지 않는 사용자 유형입니다.");
			}
		} catch (IllegalArgumentException e) {
			String errorMessage = "지원되지 않는 사용자 유형입니다.";
			model.addAttribute("error", errorMessage);
			return "errorPage";
		} catch (Exception e) {
			String errorMessage = "장바구니에 상품을 추가하는 중에 오류가 발생했습니다.";
			model.addAttribute("error", errorMessage);
			e.printStackTrace();
			return "errorPage";
		}
		return "redirect:/";
	}

	// 장바구니 아이템 삭제
	@PostMapping("/deleteCartMenu")
	public ResponseEntity<String> deleteMenu(@RequestBody List<Long> ids) {
		try {
			if (ids.isEmpty()) {
				return new ResponseEntity<>("BAD REQUEST", HttpStatus.BAD_REQUEST);
			}
			cartItemService.deleteById(ids);
			return new ResponseEntity<>("OK", HttpStatus.OK);
		} catch (Exception e) {
			System.err.println("?먮윭: " + e.getMessage());
			e.printStackTrace(System.err);
			return new ResponseEntity<>("SERVER ERROR", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/checkMemberInfo")
	public String checkInfo(HttpSession session, RedirectAttributes rttr, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);
		List<CartItem> itemList = (List<CartItem>) session.getAttribute("itemList");

		if (memberId == null) {
			rttr.addFlashAttribute("myPageResult", "notOK");
			return "redirect:/loginResult";
		} else {
			model.addAttribute("member", member);
		}
		return "cart/checkMemberInfo";
	}

	@GetMapping("/checkKakaoInfo")
	public String checkInfo2(HttpSession session, Model model, RedirectAttributes rttr) {

		KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
		List<CartItem> itemList = (List<CartItem>) session.getAttribute("itemList");

		if (kakaoUser == null) {
			rttr.addFlashAttribute("myPageResult", "notOK");
			return "redirect:/loginResult";
		} else {
			model.addAttribute("kakaoUser", kakaoUser);
		}
		return "cart/checkKakaoInfo";
	}
}
