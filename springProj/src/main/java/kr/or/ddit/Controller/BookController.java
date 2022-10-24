package kr.or.ddit.Controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

/*
	Controller 어노테이션
	스프링 프레임워크에게 이 클래스는 웹브라우저의 요청(request)를 받는 컨트롤러라고 알려줌
	
	servlet-context.xml의 context:component-scan 설정에 의해
	클래스를 자바빈 객체로 등록(메모리에 바인딩)
	ex) <context:component-scan base-package="kr.or.ddit" />
	kr.or.ddit 패키지 밑 하위 모든 클래스를 훑으면서 @Controller를 찾아서 등록
 */
@Slf4j
@Controller
public class BookController {
	// 도서관리 프로그램
	// BookService 서비스를 호출하기 위해 의존성 주입(DI)
	
	@Autowired
	BookService bookService;
	// URI => http://localhost/create
	// Request : client가 server에 URI요청
	// Mapping : create() 메소드 실행
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		/*
			ModelAdnView
			1) Model : return할 데이터(String, int, List, Map, VO.. 등)를 담당
			2) View : 화면을 담당(뷰(view : JSP)의 경로)
				ViewResolver => prefix + jsp파일명 + suffix
		 */
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("book/create");
		// forwarding
		return mav;
	}
	
	// URI : http://localhost/create
	// 요청 파라미터: {"title":"개똥이월드","category":"소설","price":"10000"}
	// BookVO 	: {"bookId":0, "title":"개똥이월드","category":"소설","price":"10000","insertDate",""}
	// <form action="/create" method="post">
	
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public ModelAndView createPost(ModelAndView mav,
					@ModelAttribute BookVO bookVO) {
		
		int result = this.bookService.insert(bookVO);
		
		
		if(result < 1) {
			// /create(get방식) URI를 재요청
			// 책 입력 화면으로 이동
			mav.setViewName("redirect:/create");
		} else {
			mav.setViewName("redirect:/detail?bookId="+bookVO.getBookId());
		}
		
		return mav;
	}
	
	// 책 상세보기
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, @ModelAttribute BookVO bookVO) {
		
		
		// select 결과 1행을 bookVO에 담는다
		BookVO data = this.bookService.selectDetail(bookVO);
		
		// forwarding => "/WEB-INF/view/book/detail.jsp"를 찾아서
		// 해석, 컴파일하여 html을 응답
		// 데이터(BookVO) 1행을 함께 응답.
		// but, redirect는 데이터를 응답해주지 못함
		mav.setViewName("book/detail");
		mav.addObject("data",data);
		mav.addObject("bookId", data.getBookId());
		return mav;
	}
	
	
	// @RequestParam(value="parameterName", required = false)
	// => 필수가 아니라 선택(없을 수도 있는 매개변수)
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value = "keyword", required = false) String keyword) {
		
		List<BookVO> list = this.bookService.list(keyword);
		
		mav.setViewName("book/list");
		mav.addObject("data",list);
		
		return mav;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(BookVO bookVO, ModelAndView mav) {
		
		BookVO data = this.bookService.selectDetail(bookVO);
		
		mav.addObject("data",data);
		
		mav.setViewName("book/update");
		return mav;
	}
	
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView updatePost(@ModelAttribute BookVO bookVO, ModelAndView mav) {
		
		int result = this.bookService.update(bookVO);
		
		if(result > 0) {
			mav.setViewName("redirect:/detail?bookId="+bookVO.getBookId());
		} else {
			mav.setViewName("redirect:/update?bookId="+bookVO.getBookId());			
		}
		
		return mav;
	}
	
	// 스프링에서는 요청 파라미터를 매개변수로 받을 수 있음
	// 매개변수 타입이 int 타입으로 자동 형 변환 됨
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public ModelAndView delete(ModelAndView mav, int bookId) {
		
		int result = this.bookService.delete(bookId);
		
		if(result > 0) {
			mav.setViewName("redirect:/list");
		} else {
			mav.setViewName("redirect:/detail?bookId="+bookId);			
		}
		
		return mav;
	}
}
