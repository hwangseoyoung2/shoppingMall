package com.project.mall.service;

import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.project.mall.repository.EmailService;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired
	JavaMailSender emailSender;

	public String ePw = createKey();

	private String verificationCode;

	// 회원 가입 시 발송 이메일
	private MimeMessage createMessage(String to) throws Exception {
		System.out.println("보내는 대상 : " + to);
		System.out.println("인증 번호 : " + ePw);
		MimeMessage message = emailSender.createMimeMessage();

		message.addRecipients(RecipientType.TO, to);// 보내는 대상
		message.setSubject("이메일 인증 코드");// 제목

		String msgg = "<div style='margin: 20px; font-family: Arial, sans-serif;'>";
		msgg += "<h3 style='color: #333333; text-align: center;'>ShoppingMall 인증 번호 발송</h3>";
		msgg += "<div style='background-color: #f4f4f4; padding: 15px; border-radius: 10px;'>";
		msgg += "<p style='font-size: 16px; color: #555555; line-height: 1.6; text-align: center;'>" +
		        "아래 코드를 입력해주세요</p>";
		msgg += "<div align='center' style='border: 1px solid black; font-family: Verdana;'>";
		msgg += "<h3 style='color: gray; margin-bottom: 10px;'>인증 코드입니다.</h3>";
		msgg += "<div style='font-size: 130%; color: #009688; font-weight: bold; margin-bottom: 20px;'>" +
		        "CODE : <strong>" + ePw + "</strong></div>";
		msgg += "</div>";
		msgg += "</div>";
		msgg += "<p style='font-size: 16px; color: #555555; line-height: 1.6; text-align: center;'>감사합니다.</p>";
		msgg += "</div>";
		message.setText(msgg, "utf-8", "html");// 내용
		message.setFrom(new InternetAddress("sy56977686@gmail.com", "shoppingMall"));// 보내는 사람

		this.verificationCode = ePw;
		return message;
	}

	public static String createKey() {
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 8; i++) { // 인증코드 8자리
			int index = rnd.nextInt(3); // 0~2 까지 랜덤

			switch (index) {
			case 0:
				key.append((char) ((int) (rnd.nextInt(26)) + 97));
				// a~z (ex. 1+97=98 => (char)98 = 'b')
				break;
			case 1:
				key.append((char) ((int) (rnd.nextInt(26)) + 65));
				// A~Z
				break;
			case 2:
				key.append((rnd.nextInt(10)));
				// 0~9
				break;
			}
		}
		return key.toString();
	}
	
	public static String createPw() {
		StringBuffer key = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 8; i++) { // 인증코드 8자리
			int index = rnd.nextInt(3); // 0~2 까지 랜덤

			switch (index) {
			case 0:
				key.append((char) ((int) (rnd.nextInt(26)) + 97));
				// a~z (ex. 1+97=98 => (char)98 = 'b')
				break;
			case 1:
				key.append((char) ((int) (rnd.nextInt(26)) + 65));
				// A~Z
				break;
			case 2:
				key.append((rnd.nextInt(10)));
				// 0~9
				break;
			}
		}
		return key.toString();
	}

	@Override
	public String sendSimpleMessage(String to) throws Exception {
		MimeMessage message = createMessage(to);
		try {
			emailSender.send(message);
			return ePw;
		} catch (MailException es) {
			es.printStackTrace();
			throw new IllegalArgumentException("이메일 전송에 실패하였습니다.");
		} finally {
			ePw = createKey();
		}
	}
	
	@Override
	public String sendMemberId(String to, String subject, String htmlContent) throws Exception {
	    MimeMessage message = emailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

	    helper.setTo(to);
	    helper.setSubject(subject);
	    helper.setText(htmlContent, true);
	    helper.setFrom(new InternetAddress("sy56977686@gmail.com", "shoppingMall"));
	    
	    try {
	        emailSender.send(message);
	        return ePw;
	    } catch (MailException e) {
	        e.printStackTrace();
	        throw new IllegalArgumentException("이메일 전송에 실패하였습니다.");
	    } finally {
	        ePw = createKey();
	    }
	}



	@Override
	public boolean verifyVerificationCode(String userVerificationCode) {
		boolean isValid = userVerificationCode != null && userVerificationCode.equals(this.verificationCode);

		return isValid;
	}

	@Override
	public String getVerificationCode() {
		return this.verificationCode;
	}
}