package com.project.mall.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.mall.DTO.CancelRequest;
import com.project.mall.DTO.PaymentData;
import com.project.mall.entity.KakaoUser;
import com.project.mall.entity.Payment;
import com.project.mall.service.CartItemService;
import com.project.mall.service.PaymentService;
import com.siot.IamportRestClient.IamportClient;

@Controller
public class PayController {

	private IamportClient api;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private CartItemService cartItemService;
	
	public PayController() {
		this.api = new IamportClient("3570817181544746",
				"hcMCT9jjBouLTkCfND4MJf8xK4vWjy0NGEF" + "ebDEEzf4MHVGFMKVQS3wWiSFYPSBwcokv1Q90qeUW18sO");
	}
	
	@PostMapping("/payment/save")
	public ResponseEntity<String> savePayment(@RequestBody PaymentData paymentData, HttpSession session) {
	    Payment payment = Payment.convertPaymentDataToPayment(paymentData);

	    paymentService.savePayment(payment);
	    System.out.println("payment: "+payment);
	    return new ResponseEntity<>("Payment information successfully saved", HttpStatus.OK);
	}

    @PostMapping("/cart/remove")
    public ResponseEntity<String> removeItemsFromCart(@RequestBody List<Long> itemIds) {
        try {
            cartItemService.deleteById(itemIds);
            return ResponseEntity.ok("상품이 장바구니에서 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("상품 삭제 중 오류가 발생했습니다.");
        }
    }
    
    @GetMapping("/payedItemList")
    public String payedItemList(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
		
		if(memberId != null) {
			List<Payment> payments = paymentService.findPaymentsByBuyerId(memberId);
			System.out.println("payments: "+payments);
			model.addAttribute("payments", payments);
		}
		
		if(memberId == null && kakaoUser != null) {
			List<Payment> payments = paymentService.findPaymentsByBuyerEamil(kakaoUser.getEmail());
			model.addAttribute("payments", payments);
		}
		return "pay/payedItemList";
    }
    
    @PostMapping("/getToken")
    @ResponseBody
    public ResponseEntity<String> getToken(@RequestBody Map<String, String> request) throws IOException {
        String apiKey = request.get("apiKey");
        String secretKey = request.get("secretKey");
        String token = paymentService.getToken(apiKey, secretKey);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Authorization", "Bearer " + token);
        
        return new ResponseEntity<>("Token generated successfully", responseHeaders, HttpStatus.OK);
    }

    @Transactional
    @PostMapping("/payment/cancle/{impUid}")
    public ResponseEntity<String> refundPayment(@RequestBody CancelRequest cancleRequest) {
        try {
        	String apiKey = "3570817181544746";
        	String secretKey = "hcMCT9jjBouLTkCfND4MJf8xK4vWjy0NGEFebDEEzf4MHVGFMKVQS3wWiSFYPSBwcokv1Q90qeUW18sO";

            String access_token = paymentService.getToken(apiKey, secretKey);
            paymentService.refundRequest(cancleRequest, access_token);
            
            paymentService.deleteByImpUid(cancleRequest.getImpUid());
            return ResponseEntity.ok("결제 취소가 완료되었습니다.");
        } catch (Exception e) {
        	e.printStackTrace();
            String errorMessage = "결제 취소 중 오류가 발생했습니다. 원인: " + e.getMessage();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
        }
    }
    
    @GetMapping("/canclePayment")
    public String goCancelPage(@RequestParam Long id, Model model) {
        Payment payment = paymentService.findById(id);
        if (payment != null) {
            List<Payment> paymentList = new ArrayList<>();
            paymentList.add(payment);
            model.addAttribute("payments", paymentList);
            return "pay/canclePayment";
        } else {
            return "errorPage";
        }
    }

}
