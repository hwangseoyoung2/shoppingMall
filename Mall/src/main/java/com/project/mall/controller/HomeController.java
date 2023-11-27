package com.project.mall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.mall.DTO.ItemDTO;
import com.project.mall.service.ItemService;

@Controller
public class HomeController {

	@Autowired
	ItemService itemService;
	
	@GetMapping("/")
	public String home(Model model) {
		List<ItemDTO> list = itemService.allListWithImages();
		model.addAttribute("listItem", list);
		return "index";
	}
}
