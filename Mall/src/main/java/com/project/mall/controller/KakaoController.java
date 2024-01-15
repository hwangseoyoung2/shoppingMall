package com.project.mall.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.mall.entity.KakaoUser;
import com.project.mall.repository.KakaoService;
import com.project.mall.service.KakaoServiceImpl;

@Controller
public class KakaoController {
	
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private KakaoServiceImpl kakaoServiceImpl;

	@GetMapping("/kakaoTerms")
	public String login() {
		StringBuffer url = new StringBuffer();
		url.append("https://kauth.kakao.com/oauth/authorize?");
		url.append("client_id=" + "f4a713fc2af3367631b01a92f5b6cc9d");
		url.append("&redirect_uri=http://localhost:8080/kakaoLogin");
		url.append("&response_type=code");
		
		return "redirect:"+url.toString();
	}
	
	@RequestMapping(value = "/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) throws Exception {
	    // code로 토큰 받음
	    String access_token = kakaoService.getToken(code);
	    ArrayList<Object> list = kakaoService.getUserInfo(access_token);

	    KakaoUser kakaoUser = kakaoServiceImpl.convertToKakaoUser(list);
	    session.setAttribute("kakaoUser", kakaoUser);	//장바구니
	    session.setAttribute("access_token", access_token);	//토큰
	    
	    session.setMaxInactiveInterval(30 * 60);	//30분
	    model.addAttribute("list", list);

	    return "index";
	}

	@RequestMapping(value = "/kakaoLogout")
	public String logout(HttpSession session) {
		String access_token = (String)session.getAttribute("access_token");
		if(access_token != null && !"".equals(access_token)) {
			kakaoServiceImpl.unlink(access_token);
			session.invalidate();
		} else {
			System.out.println("accessToken is null");
		}
		return "redirect:/";
	}
}
