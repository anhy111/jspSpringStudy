package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class BookController {
	
	@Autowired
	BookService bookService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/addBook", method = RequestMethod.GET)
	public String addBook() {
		return "book/addBook";
	}
	
	@RequestMapping(value = "/addBook", method = RequestMethod.POST)
	public String addBookPost(BookVO bookVO) {
		int cnt = bookService.insertBook(bookVO);
		return "redirect:/book?bookId="+bookVO.getBookId();
	}
	
	@RequestMapping(value = "/books",method = RequestMethod.GET)
	public ModelAndView books(ModelAndView mav) {
		
		mav.setViewName("book/books");
		
		List<BookVO> list = bookService.list();
		
		mav.addObject("listOfBooks",list);
		return mav;
	}
	
	@RequestMapping(value = "/book", method = RequestMethod.GET)
	public ModelAndView book(ModelAndView mav, BookVO bookVO) {
		
		bookVO = bookService.selectDetail(bookVO);
		
		mav.setViewName("book/book");
		mav.addObject("bookVO",bookVO);
		
		return mav;
	}
}
