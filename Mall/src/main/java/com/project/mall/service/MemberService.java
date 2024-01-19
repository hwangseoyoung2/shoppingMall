package com.project.mall.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.project.mall.entity.Member;
import com.project.mall.repository.EmailService;
import com.project.mall.repository.MemberRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

	@Autowired
	MemberRepository memberRepository;

	@Autowired
	EmailService emailService;

	public Member save(Member member) {
		return memberRepository.save(member);
	}

	public Member findByMemberId(String memberId) {
		return memberRepository.findByMemberId(memberId);
	}

	public Member findById(Long id) {
		return memberRepository.findById(id).orElse(null);
	}

	public Page<Member> searchByMemberId(String keyword, int page) {
		Pageable pageable = PageRequest.of(page, 10);
		return memberRepository.findByMemberIdContaining(keyword, pageable);
	}

	// 아이디 중복확인
	public boolean checkMemberId(String memberId) {
		return memberRepository.existsBymemberId(memberId);
	}

	public int loginCheck(String memberId, String password) {
		if (memberRepository.existsBymemberId(memberId)) {
			Member member = memberRepository.findByMemberId(memberId);
			if (member.getPassword().equals(password)) {
				return 0; // 로그인 성공
			} else {
				return 1; // 비밀번호 불일치
			}
		} else {
			return 2; // 아이디 없음
		}
	}

	public void deleteByMemberId(String memberId) {
		memberRepository.deleteByMemberId(memberId);
	}

	public Member getById(Long id) {
		return memberRepository.getById(id);
	}

	public Page<Member> findAllMember(int page) {
		Pageable pageable = PageRequest.of(page, 10);
		return memberRepository.findAll(pageable);
	}

	public boolean emailExists(String email) {
		Member member = memberRepository.findByEmail(email);
		return member != null;
	}

	public String findByEmail(String email) {
		Member member = memberRepository.findByEmail(email);
		if (member != null) {
			return member.getMemberId();
		}
		return null; // 또는 예외 처리 등을 수행할 수 있습니다.
	}

	public String findMemberIdByEmail(String email) {
		Member member = memberRepository.findByEmail(email);

		if (member != null) {
			return member.getMemberId();
		} else {
			throw new IllegalArgumentException("입력하신 이메일로 등록된 아이디를 찾을 수 없습니다.");
		}
	}

	public void resetPassword(String memberId, String email) throws Exception {
		// 1. 아이디로 회원 정보 조회
		Member member = memberRepository.findByMemberId(memberId);

		if (member != null && email.equals(member.getEmail())) {

			String newPassword = generateNewPassword(); // 새로운 비밀번호 생성
			member.setPassword(newPassword);
			memberRepository.save(member);

			// 사용자에게 새로운 비밀번호를 이메일로 전송
            String subject = "임시 비밀번호 안내";
            String htmlContent = "<div style='margin: 20px; font-family: Arial, sans-serif;'>" +
                    "<h3 style='color: #333333; text-align: center;'>ShoppingMall 새로운 비밀번호 안내</h3>" +
                    "<div style='background-color: #f4f4f4; padding: 15px; border-radius: 10px;'>" +
                    "<p style='font-size: 16px; color: #555555; line-height: 1.6; margin-bottom: 15px;'>" +
                    "회원님의 ShoppingMall 새로운 비밀번호 안내</p>" +
                    "<p style='font-size: 18px; color: #009688; font-weight: bold; margin-bottom: 20px;'>" +
                    "새로운 비밀번호: <strong>" + newPassword + "</strong></p>" +
                    "<p style='font-size: 16px; color: #555555; line-height: 1.6;'>감사합니다.</p>" +
                    "</div>" +
                    "</div>";
			emailService.sendMemberId(email, subject, htmlContent);
		} else {
			throw new IllegalArgumentException("입력하신 아이디 또는 이메일을 확인해주세요.");
		}
	}

	private String generateNewPassword() {
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
}
