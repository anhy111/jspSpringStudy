package kr.or.ddit.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aspectj.apache.bcel.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@RequestMapping("/book")
@Controller
public class BookController {
	
	@Autowired
	BookService bookService;
	
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<BookVO> bookVOList = this.bookService.list();
		
		model.addAttribute("bodyTitle","도서 목록");
		model.addAttribute("bookVOList",bookVOList);
		
		return "book/list";
	}
	
	@ResponseBody
	@GetMapping("/listAjax")
	public List<BookVO> listAjax(){
		
		List<BookVO> list = this.bookService.list();
		
		log.info("list : " + list);
		
		return list;
	}
	
	@GetMapping("/detail")
	public String detail(String bookId, Model model) {
		BookVO bookVO = bookService.detail(bookId);
		model.addAttribute("bodyTitle","도서 정보");
		model.addAttribute("bookVO",bookVO);
		return "book/detail";
	}
	
	
	@PostMapping("/update")
	public String updatePost(BookVO bookVO) {
		log.info("bookbVO : " + bookVO);
		
		bookService.update(bookVO);
		
		return "redirect:/book/detail?bookId="+bookVO.getBookId();			
		
	}
	
	@PostMapping("/delete")
	public String deletePost(BookVO bookVO) {
		
		bookService.delete(bookVO);
		
		return "redirect:/book/list";
	}
	
	@GetMapping("/insert")
	public String write(Model model) {
		model.addAttribute("bookVO",new BookVO());
		model.addAttribute("bodyTitle","도서 입력");
		return "book/insert";
	}
	
	@PostMapping("/insert")
	public String writePost(BookVO bookVO) {
		
		bookService.insert(bookVO);
		
		return "redirect:/book/detail?bookId=" + bookVO.getBookId();
	}
	
	@ResponseBody
	@GetMapping("/getBookId")
	public String getBookId() {
		int bookId = bookService.getBookId();
		
		return ""+bookId;
	}
	
	@ResponseBody
	@PostMapping("/searchBook")
	public List<BookVO> searchBook(@RequestBody BookVO bookVO){
		log.info("bookVO : " + bookVO);
		return this.bookService.searchBook(bookVO);
	}
	
	
}
