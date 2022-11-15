package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/gallery")
@Slf4j
@Controller
public class GalleryController {

	@Autowired
	GalleryService galleryService;
	
	@GetMapping("/list")
	public String list(Model model, BookVO bookVO) {
		
		bookVO.setBookId(1);
		
		bookVO = this.galleryService.list(bookVO);
		
		log.info("bookVO : " + bookVO);
		
		model.addAttribute("bodyTitle","이미지 목록");
		model.addAttribute("bookVO",bookVO);
		
		return "gallery/list";
	}
}
