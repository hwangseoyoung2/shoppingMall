package com.project.mall.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mall.DTO.VerificationRequest;
import com.project.mall.entity.Member;
import com.project.mall.repository.EmailService;
import com.project.mall.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	EmailService emailService;

	// 가입
	@GetMapping("/join")
	public String goJoin() {
		return "member/join";
	}

	@PostMapping("/join")
	public String join(Member member) {
		memberService.save(member);
		return "redirect:/login";
	}

	// 아이디 중복확인
	@ResponseBody
	@PostMapping("/checkDuplicateId")
	public Map<String, Boolean> checkDuplicateId(@RequestParam String memberId) {
		boolean isDuplicate = memberService.checkMemberId(memberId);
		Map<String, Boolean> response = new HashMap<>();
		response.put("isDuplicate", isDuplicate);
		return response;
	}
	
	@PostMapping("/checkDuplicateEmail")
	public ResponseEntity<Map<String, Boolean>> checkDuplicateEmail(@RequestParam String email) {
	    // email 중복 체크
	    boolean isDuplicate = memberService.emailExists(email);

	    Map<String, Boolean> response = new HashMap<>();
	    response.put("isDuplicate", isDuplicate);

	    return ResponseEntity.ok(response);
	}

	// 로그인
	@GetMapping("/login")
	public String login(Member member) {
		return "member/login";
	}

	@PostMapping("/login")
	public String memberLogin(@RequestParam String memberId, @RequestParam String password, HttpSession session,
			RedirectAttributes rttr, Model model) {
		int loginResult = memberService.loginCheck(memberId, password);

		if (loginResult == 0) {
			rttr.addFlashAttribute("result", "OK");
			
			Member member = memberService.findByMemberId(memberId);
			Long memberIdNum = member.getId();
			
			session.setAttribute("memberId", memberId);
			session.setAttribute("memberIdNum", memberIdNum);
			
			session.setMaxInactiveInterval(30 * 60); // 30분
		} else if (loginResult == 1) {
			rttr.addFlashAttribute("result", "FAIL");
		} else if (loginResult == 2) {
			rttr.addFlashAttribute("result", "NONE_ID");
		}

		return "redirect:/loginResult";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String memberLogout(HttpSession session, RedirectAttributes rttr) {
		// 세션에서 사용자 정보 삭제
		session.invalidate();

		// 로그아웃 성공 메시지 설정 후 리다이렉트
		rttr.addFlashAttribute("result", "LOGOUT_SUCCESS");
		return "redirect:/loginResult";
	}

	@RequestMapping("/loginResult")
	public String showLoginResultPage() {
		return "member/loginResult";
	}

	// 마이페이지
	@GetMapping("/myPage")
	public String goMyPage(HttpSession session, RedirectAttributes rttr, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);

		if (memberId == null) {
			rttr.addFlashAttribute("myResult", "notOK");
			return "redirect:/loginResult";
		} else {
			model.addAttribute("member", member);
		}
		return "member/myPage";
	}

	// 회원탈퇴
	@PostMapping("/delete")
	public String delete(HttpSession session, RedirectAttributes rttr) {
		String memberId = (String) session.getAttribute("memberId");
		memberService.deleteByMemberId(memberId);
		session.removeAttribute("memberId");
		return "redirect:/";
	}

	// 회원정보 수정
	@GetMapping("/modifyMember")
	public String modify(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);
		model.addAttribute("member",member);
		
		return "member/modifyMember";
	}

	@PostMapping("/modifyMember")
	public String modifyMember(@ModelAttribute Member modifiedMember, HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		Member originalMember = memberService.findByMemberId(memberId);

		// 복사된 속성 값으로 업데이트
		BeanUtils.copyProperties(modifiedMember, originalMember, "id", "memberId", "password");
		memberService.save(originalMember);

		return "redirect:/myPage";
	}

	// 세션 만료
	@GetMapping("/sessionOver")
	public String sessionover(HttpSession session) {
		session.setAttribute("noSession", "NO");
		return "member/sessionOver";
	}

	// 비밀번호 변경
	@GetMapping("/pwUpdate")
	public String pwUpdate(HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);
		session.setAttribute("member", member);
		return "member/pwUpdate";
	}
	
	@PostMapping("/pwUpdate")
	public String goPwUpdate(HttpSession session, @RequestParam("password") String password) {
		Member member = (Member) session.getAttribute("member");
		member.setPassword(password);
		memberService.save(member);
		session.setAttribute("memberId", member.getMemberId());
		return "redirect:/myPage";
	}
	
	@GetMapping("/findMemberId")
	public String findId() {
		return "member/findMemberId";
	}

    @PostMapping("/sendMemberId")
    public ResponseEntity<String> findMemberId(@RequestBody VerificationRequest verificationRequest) {
        String email = verificationRequest.getEmail();

        if (memberService.emailExists(email)) {
            String memberId = memberService.findByEmail(email);

            // 아이디를 이메일로 전송
            try {
                // 메일 내용 작성
                String subject = "회원님의 ShoppingMall 아이디입니다";
                String text = "<div style='margin: 20px; font-family: Arial, sans-serif;'>" +
                        "<h3 style='color: #333333; text-align: center;'>ShoppingMall 아이디 안내</h3>" +
                        "<div style='background-color: #f4f4f4; padding: 15px; border-radius: 10px;'>" +
                        "<p style='font-size: 16px; color: #555555; line-height: 1.6; margin-bottom: 15px;'>" +
                        "회원님의 ShoppingMall 아이디 안내</p>" +
                        "<p style='font-size: 18px; color: #009688; font-weight: bold; margin-bottom: 20px;'>" +
                        "아이디: <strong>" + memberId + "</strong></p>" +
                        "<p style='font-size: 16px; color: #555555; line-height: 1.6;'>감사합니다.</p>" +
                        "</div>" +
                        "</div>";
                // 아이디를 이메일로 전송
                emailService.sendMemberId(email, subject, text);

                return ResponseEntity.ok("Member ID sent to your email");
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send email");
            }
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Email not found");
        }
    }
    
    @GetMapping("/findPassword")
    public String findPw() {
    	return "member/findPassword";
    }
    
    @PostMapping("/findMemberIdByEmail")
    public String findMemberIdByEmail(@RequestParam("email") String email, Model model) {
        try {
            String memberId = memberService.findMemberIdByEmail(email);

            // 아이디 찾기 성공 시 메시지 전달
            model.addAttribute("successMessage", "회원 아이디: " + memberId);

            // 아이디 찾기 성공 시 로그인 페이지로 리다이렉트 또는 다른 페이지로 이동하도록 설정
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            // 아이디 찾기 실패 시 에러 메시지 전달
            model.addAttribute("errorMessage", e.getMessage());

            // 실패 시 다시 아이디 찾기 페이지로 이동
            return "member/findMemberId";
        } catch (Exception e) {
            // 예외 발생 시 에러 메시지 전달
            model.addAttribute("errorMessage", "아이디 찾기 중 오류가 발생하였습니다.");

            // 실패 시 다시 아이디 찾기 페이지로 이동
            return "member/findMemberId";
        }
    }

    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam("memberId") String memberId,
                                @RequestParam("email") String email,
                                Model model) {
        try {
            // 비밀번호 재설정
            memberService.resetPassword(memberId, email);

            // 비밀번호 재설정 성공 시 메시지 전달
            model.addAttribute("successMessage", "임시 비밀번호가 발송되었습니다. 이메일을 확인해주세요.");

            // 비밀번호 재설정 성공 시 로그인 페이지로 리다이렉트 또는 다른 페이지로 이동하도록 설정
            return "member/findPassword";
        } catch (IllegalArgumentException e) {
            // 비밀번호 재설정 실패 시 에러 메시지 전달
            model.addAttribute("errorMessage", e.getMessage());

            // 실패 시 다시 비밀번호 찾기 페이지로 이동
            return "member/findPassword";
        } catch (Exception e) {
            // 예외 발생 시 에러 메시지 전달
            model.addAttribute("errorMessage", "비밀번호 찾기 중 오류가 발생하였습니다.");

            // 실패 시 다시 비밀번호 찾기 페이지로 이동
            return "member/findPassword";
        }
    }

}
