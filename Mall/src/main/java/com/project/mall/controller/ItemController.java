package com.project.mall.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.mall.DTO.ItemDTO;
import com.project.mall.entity.Item;
import com.project.mall.service.ImageService;
import com.project.mall.service.ItemService;

@Controller
public class ItemController {

   @Autowired
   ItemService itemService;

   @Autowired
   ImageService imageService;

   // 게시글 저장
   @GetMapping("/register")
   public String register() {
      return "item/register";
   }

   @PostMapping("/register")
   public String saveItem(Item item, @RequestParam("files") List<MultipartFile> imageFiles) throws Exception {
      itemService.saveItemWithImages(item, imageFiles);
      return "redirect:/";
   }

   // 게시글 하나
   @GetMapping("/itemContent")
   public String content(@RequestParam("id") Long id, Model model, HttpSession session) {
       ItemDTO itemDTO = itemService.selectOne(id);
       model.addAttribute("item", itemDTO);
       
       //목록 버튼
       if(session.getAttribute("listBtn")!=null) {
          session.setAttribute("btnNum", 3);
          session.removeAttribute("listBtn");
       } else {
          session.setAttribute("btnNum", 1);
       }
       
       return "item/content";
   }


   // 게시글 삭제
   @RequestMapping("/deleteItem")
   public String delete(@RequestParam Long id) {
      itemService.Delete(id);
      return "redirect:/";
   }

   // 게시글 수정
   @GetMapping("/modify")
   public String modify(@RequestParam Long id, Model model, HttpSession session) {
       ItemDTO itemDTO = itemService.selectOne(id);
       model.addAttribute("modify", itemDTO);
       model.addAttribute("images", itemDTO.getImages());
       model.addAttribute("mainCategory", itemDTO.getMainCategory());

       String previousCategory = itemService.selectOne(id).getMainCategory();
       model.addAttribute("previousCategory", previousCategory);
       return "item/modify";
   }
   
   @PostMapping("/modify")
   public ResponseEntity<String> updateItem(@ModelAttribute ItemDTO itemDTO, @RequestParam("files") MultipartFile[] files, HttpSession session) {
       try {
           if (files != null && files.length > 0 && !files[0].isEmpty()) {
               // 새로운 파일을 업로드하고 기존 파일을 대체
               itemService.updateItem(itemDTO, files);
           } else {
               // 새로운 파일을 선택하지 않은 경우, 기존 파일을 그대로 유지
               itemService.updateItemWithoutImages(itemDTO);
           }
           session.setAttribute("listBtn", 2);
           return new ResponseEntity<>("게시글이 수정되었습니다.", HttpStatus.OK);
       } catch (IOException e) {
           e.printStackTrace();
           return new ResponseEntity<>("오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
       }
   }
   //카테고리 대분류
   @RequestMapping("/{main}")
   public String category(@PathVariable("main") String main, Model model) {
      List<Item> list = null;

      if (main.equals("dress")) {
         main = "dress";
      } else if (main.equals("outer")) {
         main = "outer";
      } else if (main.equals("top")) {
         main = "top";
      } else if (main.equals("knit")) {
         main = "knit";
      } else if (main.equals("blouse")) {
         main = "blouse";
      } else if (main.equals("skirt")) {
         main = "skirt";
      } else if (main.equals("pants")) {
         main = "pants";
      } else if (main.equals("training")) {
         main = "training";
      } else if (main.equals("homeWear")) {
         main = "HOME WEAR";
      } else if (main.equals("inner")) {
         main = "inner";
      } else if (main.equals("shoes")) {
         main = "shoes";
      } else if (main.equals("accBag")) {
         main = "ACC/BAG";
      }

      list = itemService.MainCategory(main);
      model.addAttribute("list", list);

      if (main.equals("HOME WEAR")) {
         main = "homeWear";
      } else if (main.equals("ACC/BAG")) {
         main = "accBag";
      }
      return "itemCategory" + "/" + main;
   }
   
    //검색 기능
    @GetMapping("/products")
    public ModelAndView listProducts(@RequestParam(name = "keyword", required = false) String keyword, Model model) {
        ModelAndView modelAndView = new ModelAndView("item/searchProduct");

        List<Item> products;

        if (keyword != null && !keyword.isEmpty()) {
            products = itemService.findByTitle(keyword);
        } else {
            products = itemService.findAll();
        }
        modelAndView.addObject("products", products);
        return modelAndView;
    }

}