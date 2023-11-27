package com.project.mall.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.project.mall.service.ItemService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public abstract class CategoryController {

	@Autowired
	ItemService itemService;

//	// 대분류
//	@RequestMapping("/{main}")
//	public String category(@PathVariable("main") String main, Model model) {
//		List<Item> list = null;
//
//		if (main.equals("dress")) {
//			main = "dress";
//		} else if (main.equals("outer")) {
//			main = "outer";
//		} else if (main.equals("top")) {
//			main = "top";
//		} else if (main.equals("knit")) {
//			main = "knit";
//		} else if (main.equals("blouse")) {
//			main = "blouse";
//		} else if (main.equals("skirt")) {
//			main = "skirt";
//		} else if (main.equals("pants")) {
//			main = "pants";
//		} else if (main.equals("training")) {
//			main = "training";
//		} else if (main.equals("homeWear")) {
//			main = "HOME WEAR";
//		} else if (main.equals("inner")) {
//			main = "inner";
//		} else if (main.equals("shoes")) {
//			main = "shoes";
//		} else if (main.equals("accBag")) {
//			main = "ACC/BAG";
//		}
//
//		list = itemService.MainCategory(main);
//		model.addAttribute("list", list);
//
//		if (main.equals("HOME WEAR")) {
//			main = "homeWear";
//		} else if (main.equals("ACC/BAG")) {
//			main = "accBag";
//		}
//		return "itemCategory" + "/" + main;
//	}

//	// 중분류
//	@RequestMapping("/{main}/{sub}")
//	public String subCategory(@PathVariable("main") String main, @PathVariable("sub") String sub, Model model) {
//
//		if (main.equals("dress")) {
//			main = "dress";
//			if (sub.equals("미니원피스")) {
//				sub = "미니원피스";
//			} else if (sub.equals("미디원피스")) {
//				sub = "미디원피스";
//			} else if (sub.equals("롱원피스")) {
//				sub = "롱원피스";
//			}
//			if (main.equals("outer")) {
//				main = "outer";
//				if (sub.equals("코트")) {
//					sub = "코트";
//				} else if (sub.equals("자켓")) {
//					sub = "자켓";
//				} else if (sub.equals("점퍼")) {
//					sub = "점퍼";
//				}
//			}
////			} else if (main.equals("top")) {
////				main = "top";
////			} else if (main.equals("knit")) {
////				main = "knit";
////			} else if (main.equals("blouse")) {
////				main = "blouse";
////			} else if (main.equals("skirt")) {
////				main = "skirt";
////			} else if (main.equals("pants")) {
////				main = "pants";
////			} else if (main.equals("training")) {
////				main = "training";
////			} else if (main.equals("homeWear")) {
////				main = "HOME WEAR";
////			} else if (main.equals("inner")) {
////				main = "inner";
////			} else if (main.equals("shoes")) {
////				main = "shoes";
////			} else if (main.equals("accBag")) {
////				main = "ACC/BAG";
////			}
//			List<Item> itemList = itemService.SubCategory(main, sub);
//
//			model.addAttribute("mainCategory", main);
//			model.addAttribute("subCategory", sub);
//			model.addAttribute("itemList", itemList);
//
//			return "itemCategory" +"/"+ main + "/" + sub;
//		}
//		return "itemCategory" +"/"+ main + "/" + sub;
//	}
}
