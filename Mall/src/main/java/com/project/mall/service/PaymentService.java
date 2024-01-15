package com.project.mall.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.net.ssl.HttpsURLConnection;
import javax.transaction.Transactional;

import org.apache.jasper.tagplugins.jstl.core.Url;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.nimbusds.oauth2.sdk.Response;
import com.project.mall.DTO.CancelRequest;
import com.project.mall.entity.CancelPayment;
import com.project.mall.entity.CartItem;
import com.project.mall.entity.Payment;
import com.project.mall.repository.CanclePaymentRepository;
import com.project.mall.repository.CartItemRepository;
import com.project.mall.repository.PaymentRepository;

@Service
public class PaymentService {

	@Autowired
	PaymentRepository paymentRepository;

	@Autowired
	CartItemRepository cartItemRepository;
	
	@Autowired
	CanclePaymentRepository canclePaymentRepository;

	public Payment savePayment(Payment payment) {
	    payment = paymentRepository.save(payment);
	    System.out.println("save payment: "+payment);
	    return payment;
	}

	@Transactional
	public List<Payment> findPaymentsByBuyerId(String userId) {
		List<Payment> payments = paymentRepository.findByBuyerId(userId);
		for (Payment payment : payments) {
			List<CartItem> cartItems = payment.getCartItems();
		}
		return payments;
	}
	
	@Transactional
	public List<Payment> findPaymentsByBuyerEamil(String email) {
		List<Payment> payments = paymentRepository.findByBuyerEmail(email);
		for (Payment payment : payments) {
			List<CartItem> cartItems = payment.getCartItems();
		}
		return payments;
	}

	public Payment findById(Long id) {
		return paymentRepository.findById(id).orElse(null);
	}
	
	public Page<Payment> findAllPayedList(int page) {
		Sort sort = Sort.by(Sort.Order.desc("payedDate"));
	    Pageable pageable = PageRequest.of(page, 10, sort);
		return paymentRepository.findAll(pageable);
	}
	
	@Transactional
	public void deleteByImpUid(String impUid) {
	        paymentRepository.deleteByImpUid(impUid);
	}

	//결제 취소 토큰 발급
	public String getToken(String apiKey, String secretKey) throws IOException {
	    URL url = new URL("https://api.iamport.kr/users/getToken");

	    HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-Type", "application/json");
	    conn.setRequestProperty("Accept", "application/json");
	    conn.setDoOutput(true);

	    JsonObject json = new JsonObject();
	    json.addProperty("imp_key", apiKey);
	    json.addProperty("imp_secret", secretKey);

	    try (OutputStream os = conn.getOutputStream();
	         BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"))) {
	        writer.write(json.toString());
	        writer.flush();
	    }
	    int responseCode = conn.getResponseCode();
	    if (responseCode == HttpURLConnection.HTTP_OK) {
	        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
	            String response = br.readLine();
	            Gson gson = new Gson();
	            Map<String, Object> responseMap = gson.fromJson(response, Map.class);
	            Object responseObj = responseMap.get("response");
	            
	            if (responseObj instanceof String) {
	                String accessToken = (String) responseObj;
	                return accessToken;
	            } else if (responseObj instanceof Map) {
	                // JSON 객체를 다른 형태로 처리
	                Map<String, Object> responseJson = (Map<String, Object>) responseObj;
	                // 다음과 같은 방식으로 필요한 값을 추출
	                String accessToken = (String) responseJson.get("access_token");
	                return accessToken;
	            } else {
	                System.err.println("Unexpected response type: " + responseObj.getClass());
	                return null;
	            }
	        }
	    } else {
	        System.err.println("HTTP Error: " + responseCode);
	        return null;
	    }
	}

	//결제 취소
	@Transactional
	public void refundRequest(CancelRequest cancleRequest, String access_token) throws IOException {
	    URL url = new URL("https://api.iamport.kr/payments/cancel");
	    HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Content-type", "application/json");
	    conn.setRequestProperty("Accept", "application/json");
	    conn.setRequestProperty("Authorization", access_token);

	    conn.setDoOutput(true);

	    JsonObject json = new JsonObject();
	    json.addProperty("cancel_request_amount", cancleRequest.getCancel_request_amount());
	    json.addProperty("imp_uid", cancleRequest.getImpUid());
	    json.addProperty("reason", cancleRequest.getReason());

	    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	    bw.write(json.toString());
	    bw.flush();
	    bw.close();

	    int responseCode = conn.getResponseCode();
	    if (responseCode == 200) {
	        CancelPayment canclePayment = new CancelPayment();
	        canclePayment.setImpUid(cancleRequest.getImpUid());
	        canclePayment.setCancle_request_amount(cancleRequest.getCancel_request_amount());
	        canclePayment.setReason(cancleRequest.getReason());
	        canclePayment.setBuyerAddr(cancleRequest.getBuyerAddr());
	        canclePayment.setBuyerName(cancleRequest.getBuyerName());
	        canclePayment.setBuyerTel(cancleRequest.getBuyerTel());
	        canclePayment.setProductName(cancleRequest.getProductName());
	        canclePayment.setCancelDate(cancleRequest.getCancelDate());
	        canclePayment.setBuyerEmail(cancleRequest.getBuyerEmail());
	        canclePaymentRepository.save(canclePayment);
	    } else {
	        System.err.println("결제 취소 실패. 응답 코드: " + responseCode);
	    }

	    conn.disconnect();
	}

	public List<Payment> selectOne(String impUid) {
		return paymentRepository.findByImpUid(impUid);
	}
	
	public String findBuyerEmail(String email) {
	    Payment payment = paymentRepository.findSingleByBuyerEmail(email);
	    return (payment != null) ? payment.getBuyerEmail() : null;
	}

    public void updatePaymentCartItemsToEmpty(Long paymentId) {
        Optional<Payment> optionalPayment = paymentRepository.findById(paymentId);
        if (optionalPayment.isPresent()) {
            Payment payment = optionalPayment.get();
            payment.setCartItems(new ArrayList<>()); // 비워주는 로직
            paymentRepository.save(payment); // 업데이트
        }
    }
}
