package com.project.mall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.mall.entity.CancelPayment;
import com.project.mall.entity.KakaoUser;
import com.project.mall.entity.Member;
import com.project.mall.entity.Notice;
import com.project.mall.entity.Payment;
import com.project.mall.service.CancelPaymentService;
import com.project.mall.service.CartItemService;
import com.project.mall.service.KakaoServiceImpl;
import com.project.mall.service.MemberService;
import com.project.mall.service.NoticeService;
import com.project.mall.service.PaymentService;

@Controller
public class AdminController {
	
	@Autowired
	CartItemService cartItemService;
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	KakaoServiceImpl kakaoService;
	
	@Autowired
	CancelPaymentService canclePaymentService;
	
	@Autowired
	NoticeService noticeService;
	
	//모든 주문 내역
	@GetMapping("/allPayedList")
	public String AllPayedList(Model model, @RequestParam(value="page", defaultValue = "0") int page) {
        Page<Payment> payments = paymentService.findAllPayedList(page);
        model.addAttribute("payments", payments);
        return "admin/allPayedList";
    }
	
	@GetMapping("/adminCheckMember")
	public String AllMember(Model model,  @RequestParam(value="page", defaultValue = "0") int page) {
		Page<Member> allMember = memberService.findAllMember(page);
		model.addAttribute("allMember", allMember);
		return "admin/adminCheckMember";
	}
	
	@GetMapping("/adminCheckKakaoMember")
	public String AllKakaoMember(Model model, @RequestParam(value="page", defaultValue = "0") int page) {
		Page<KakaoUser> allKakaoMember = kakaoService.findAllKakaoMember(page);
		model.addAttribute("allKakaoMember",allKakaoMember);
		return "admin/adminCheckKakaoMember";
	}
	
	// 모든 환불 내역
	@GetMapping("/allRefundList")
	public String AllRefundList(Model model, @RequestParam(value="page", defaultValue = "0") int page) {
		Page<CancelPayment> refundList = canclePaymentService.findByAllRefundList(page);
		model.addAttribute("refundList",refundList);
		return "admin/allRefundList";
	}
	
	@GetMapping("/payedInfo")
	public String payedInfo(Model model, @RequestParam("impUid") String impUid) {
		List<Payment> paymentUid = paymentService.selectOne(impUid);
		model.addAttribute("paymentUid", paymentUid);
		return "admin/payedInfo";
	}
	
	@GetMapping("/refundInfo")
	public String refundInfo(Model model, @RequestParam("impUid") String impUid) {
		List<CancelPayment> refundUid = canclePaymentService.selectOne(impUid);
		model.addAttribute("refundUid", refundUid);
		return "admin/refundInfo";
	}
	
	@GetMapping("/selectOneMember")
	public String selectOneMember(Model model, @RequestParam("memberId") String memberId) {
		List<Payment> paymentList = paymentService.findPaymentsByBuyerId(memberId);
		model.addAttribute("paymentList",paymentList);
		return "admin/selectOneMember";
	}
	
	@GetMapping("/selectOneKakaoMember")
	public String selectOneKakaoMember(Model model, @RequestParam("userId") String userId) {
		List<Payment> paymentList = paymentService.findPaymentsByBuyerId(userId);
		model.addAttribute("paymentList",paymentList);
		return "admin/selectOneKakaoMember";
	}
	
	@GetMapping("/searchMember")
	public String searchMember(@RequestParam(name = "keyword", required = false) String keyword,
	                           @RequestParam(value = "page", defaultValue = "0") int page,
	                           Model model) {
	    Page<Member> memberPage = memberService.searchByMemberId(keyword, page);
	    model.addAttribute("members", memberPage);
	    model.addAttribute("currentPage", memberPage.getNumber());
	    model.addAttribute("totalPages", memberPage.getTotalPages());
	    model.addAttribute("totalItems", memberPage.getTotalElements());

	    return "admin/searchMember";
	}
	
	@GetMapping("/searchKakaoMember")
	public String searchKakaoMember(@RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "0") int page,
            Model model) {
	    Page<KakaoUser> kakaoUser = kakaoService.findByName(keyword, page);
	    model.addAttribute("kakaoUser", kakaoUser);
	    model.addAttribute("currentPage", kakaoUser.getNumber());
	    model.addAttribute("totalPages", kakaoUser.getTotalPages());
	    model.addAttribute("totalItems", kakaoUser.getTotalElements());

		return "admin/searchKakaoMember";
	}
	
	@GetMapping("/noticeRegister")
	public String notice() {
		return "admin/noticeRegister";
	}
	
	@PostMapping("/noticeRegister")
	public String noticeRegister(Notice notice, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);
		notice.setMember(member);
		noticeService.save(notice);
		return "redirect:/notice";
	}
	
	@GetMapping("/notice")
	public String noticeList(Model model) {
		List<Notice> noticeList = noticeService.noticeAll();
		model.addAttribute("notice",noticeList);
		return "admin/notice";
	}
	
	@GetMapping("/noticeDetail")
	public String oneNotice(Model model, @RequestParam Long id) {
		Notice notice = noticeService.findById(id);
		model.addAttribute("notice", notice);
		return "admin/noticeDetail";
	}

	@DeleteMapping("/deleteNotice/{id}")
	public ResponseEntity<String> delete(@PathVariable Long id) {
	    System.out.println("deleteId: " + id);

	    try {
	        noticeService.deleteById(id);
	        return new ResponseEntity<>("공지가 삭제되었습니다.", HttpStatus.NO_CONTENT);
	    } catch (Exception e) {
	        return new ResponseEntity<>("삭제 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

}	
