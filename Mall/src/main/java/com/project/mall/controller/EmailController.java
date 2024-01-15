package com.project.mall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.mall.DTO.VerificationRequest;
import com.project.mall.repository.EmailService;

@Controller
public class EmailController {

	@Autowired
	EmailService emailService;

	@PostMapping("/emailConfirm")
	public String emailConfirm(@RequestParam String email) throws Exception {

		String confirm = emailService.sendSimpleMessage(email);

		return confirm;
	}

	@PostMapping("/sendVerificationCode")
	public ResponseEntity<String> sendVerificationCode(@RequestParam String email) {
	    try {
	        emailService.sendSimpleMessage(email);
	        return ResponseEntity.ok("Verification code sent successfully");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send verification code");
	    }
	}
	
	@PostMapping("/verifyVerificationCode")
	public ResponseEntity<String> verifyVerificationCode(@RequestBody VerificationRequest verificationRequest) {
	    String userVerificationCode = verificationRequest.getUserVerificationCode();
	    boolean isValid = emailService.verifyVerificationCode(userVerificationCode);
	    
	    if (isValid) {
	        return ResponseEntity.ok("Verification successful");
	    } else {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid verification code");
	    }
	}

}
