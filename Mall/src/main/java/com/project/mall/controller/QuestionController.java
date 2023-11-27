package com.project.mall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mall.DTO.QuestionDTO;
import com.project.mall.entity.Answer;
import com.project.mall.entity.Item;
import com.project.mall.entity.KakaoUser;
import com.project.mall.entity.Member;
import com.project.mall.entity.Question;
import com.project.mall.service.AnswerService;
import com.project.mall.service.ItemService;
import com.project.mall.service.MemberService;
import com.project.mall.service.QuestionService;

@Controller
public class QuestionController {

	@Autowired
	QuestionService questionService;
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AnswerService answerService;
	
	
	@GetMapping("/itemQnA")
	public String itemQnA(@RequestParam("id") Long id, Model model, HttpSession session, RedirectAttributes rttr,  @RequestParam(value="page", defaultValue = "0") int page) {
		String memberId = (String) session.getAttribute("memberId");
		KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
		
		//로그인 상태에서만 Q&A 접근 가능
		if (memberId == null && kakaoUser == null) {
			rttr.addFlashAttribute("myResult", "notOK");
			return "redirect:/loginResult";
		} else if (memberId != null && kakaoUser == null){
			Page<Question> question = questionService.findByItemId(id, page);
			model.addAttribute("question", question);
			model.addAttribute("itemId", id);
			return "item/itemQnA";
		} else {
			Page<Question> question = questionService.findByItemId(id, page);
			model.addAttribute("question", question);
			model.addAttribute("itemId", id);
			return "item/itemQnA";
		}
	}
	
	@GetMapping("/itemQnARegister")
	public String  qnaRegister(@RequestParam("id") Long itemId, Model model, HttpSession session, RedirectAttributes rttr) {
		String memberId = (String) session.getAttribute("memberId");
		KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
		
		if (memberId == null && kakaoUser == null) {
			rttr.addFlashAttribute("myResult", "notOK");
			return "redirect:/loginResult";
		} else if(memberId != null && kakaoUser == null){
		    Item item = itemService.findById(itemId);
		    model.addAttribute("item",item);
		    return "item/itemQnARegister";
		} else {
		    Item item = itemService.findById(itemId);
		    model.addAttribute("item",item);
		    return "item/itemQnARegister";
		}
	}
	
	@PostMapping("itemQnARegister")
	public String itemQnARegister(@RequestParam("id") Long itemId, @ModelAttribute QuestionDTO questionDTO, HttpSession session, RedirectAttributes rttr) {
		String memberId = (String) session.getAttribute("memberId");
		Member member = memberService.findByMemberId(memberId);
		KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
		
		if (memberId == null && kakaoUser == null) {
			rttr.addFlashAttribute("myResult", "notOK");
			return "redirect:/loginResult";
		} else if(memberId != null && kakaoUser == null) {
			Item item = itemService.findById(itemId);
		    Question question = QuestionDTO.toQuestionDTO(questionDTO);
		    question.setItem(item);
		    question.setMember(member);
		    questionService.save(question);
		    return "redirect:/itemQnA?id=" + itemId;
		} else {
			Item item = itemService.findById(itemId);
			Question question = QuestionDTO.toQuestionDTO(questionDTO);
		    question.setItem(item);
		    question.setKakaoUser(kakaoUser);
		    questionService.save(question);
		    return "redirect:/itemQnA?id=" + itemId;
		}
	}
	
	@GetMapping("/itemQnADetail")
	public String qnaDetail(@RequestParam("id") Long id, Model model, HttpSession session, RedirectAttributes rttr) {
	    String memberId = (String) session.getAttribute("memberId");
	    KakaoUser kakaoUser = (KakaoUser) session.getAttribute("kakaoUser");
	    Question question = questionService.findById(id);

	    if (memberId == null && kakaoUser == null) {
	        rttr.addFlashAttribute("accessQnA", "notOK");
	        return "redirect:/loginResult";
	    } else if (kakaoUser != null && question.getKakaoUser() != null &&
	            kakaoUser.getUserId() != null && kakaoUser.getUserId().equals(question.getKakaoUser().getUserId())) {
	        model.addAttribute("question", question);
	        List<Answer> answers = answerService.findByQuestionId(id);
	        model.addAttribute("answers", answers);
	        return "item/itemQnADetail";
	    } else if (memberId != null && question.getMember() != null &&
	            memberId.equals(question.getMember().getMemberId())) {
	        model.addAttribute("question", question);
	        List<Answer> answers = answerService.findByQuestionId(id);
	        model.addAttribute("answers", answers);
	        return "item/itemQnADetail";
	    } else if ("admin".equals(memberId)) {
	        model.addAttribute("question", question);
	        List<Answer> answers = answerService.findByQuestionId(id);
	        model.addAttribute("answers", answers);
	        return "item/itemQnADetail";
	    } else {
	        rttr.addFlashAttribute("accessQnA", "notOK");
	        return "redirect:/loginResult";
	    }
	}
	
    @DeleteMapping("/deleteQuestion/{id}/{itemId}")
    public ResponseEntity<String> deleteItemQnA(@PathVariable Long id, @PathVariable Long itemId) {
        try {
            questionService.deleteById(id);
            return ResponseEntity.ok("Deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error during deletion");
        }
    }
	
    @GetMapping("/allQuestion")
    public String AllQuestion(Model model, @RequestParam(value="page", defaultValue = "0") int page) {
    	Page<Question> question = questionService.findByAll(page);
    	model.addAttribute("question",question);
    	return "item/allQuestion";
    }
    
    @GetMapping("/searchQnA")
    public String getItemQnAList(
            @RequestParam(defaultValue = "전체") String searchCategory,
            @RequestParam(required = false) String searchField,
            Pageable pageable,
            Model model) {
        Page<Question> questionPage = questionService.findBySearch(searchCategory, searchField, pageable);
        model.addAttribute("question", questionPage);
        return "item/searchQnA";
    }

}
