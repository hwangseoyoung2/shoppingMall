package com.project.mall.repository;

public interface EmailService {
	String sendSimpleMessage(String to) throws Exception;
	
	boolean verifyVerificationCode(String userVerificationCode);
	
	String getVerificationCode();
	
	String sendMemberId(String to, String subject, String text) throws Exception;
}
