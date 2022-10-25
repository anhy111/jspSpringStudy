package kr.or.ddit.Controller;

import java.lang.annotation.Target;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.cache.interceptor.BeanFactoryCacheOperationSourceAdvisor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.BookVO;
import lombok.val;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/board")
@Slf4j
@Controller
public class BoardController {
	
	/*
	 	요청 경로는 반드시 설정해야 하는 필수 정보
	 	컨트롤러의 클래스 레벨과 메서드 레벨로 지정할 수 있음
	 	클래스 레벨로 요청 경로를 지정시 메서드 레벨에서 지정한 경로의 기본경로로 취급
	 	클래스 레벨 경로 + 메서드 레벨 경로
	 	메서드방식은 기본 GET방식(default)
	 	
	 */
	@RequestMapping(value="/register")
	public void registerForm() {
		log.info("registerForm");
	}
	
	@RequestMapping("/modify")
	public void modifyForm() {
		log.info("modifyForm");
	}
	
	/*
	 2. 경로 패턴 매핑
	 	요청 경로를 동적으로 표현이 가능한 경로 패턴을 지정할 수 있음
	 		url 경로 상의 변하는 값을 경로 변수로 취급
	 		경로 변수에 해당하는 값을 파라미터 변수에 설정할 수 있음
	 */
	//요청 URI : http://localhost/board/read/100 => 100번글
	//요청 URI : http://localhost/board/read/101 => 101번글
	//요청 URI : http://localhost/board/read/102 => 102번글
	
	@RequestMapping("/read/{boardNo}")
	public String read(@PathVariable("boardNo") int boardNo) {
		log.info("boardNo:" + boardNo);
		
		return "board/read";
	}
	
	@RequestMapping("/formHome")
	public String formHome() {
		return "board/formHome";
	}
	
	/*
		3. Http 메서드 매핑
		method 속성을 사용하여 HTTP메서드를 매핑 조건으로 지정 가능
		화면으로 응답하는 경우 HTTP 메서드로 GET방식과 POST 방식 두 가지를 사용함
	 */
	@RequestMapping(value = "/register2", method = RequestMethod.GET)
	public String register2(Model model) {
		// Model 인터페이스 => 데이터 담당
		model.addAttribute("name","개똥이");
		
		// forwading 경로 담당
		return "board/formHome";
	}
	
	@RequestMapping(value = "/register2", method = RequestMethod.POST)
	public String register2Post(Model model) {
		model.addAttribute("name","메뚜기");
		
		return "board/formHome";
	}

	
	/*
		4. Params 매핑
			요청 파라미터를 매핑 조건으로 지정되는 경우 params 속성을 사용함
			버튼이나 링크에 따라 호출할 메서드를 바꿔야 할 때 사용
	*/
	@RequestMapping(value = "/get",method = RequestMethod.GET, params = "register")
	public String getRegister() {
		log.info("getRegister");
		return "board/formHome";
	}
	@RequestMapping(value = "/get",method = RequestMethod.GET, params = "modify")
	public String getModify() {
		log.info("getModify");
		return "board/formHome";
	}
	
	@RequestMapping(value = "/post",method = RequestMethod.POST, params = "register")
	public String getRegisterPost() {
		log.info("postRegister");
		return "board/formHome";
	}
	@RequestMapping(value = "/post",method = RequestMethod.POST, params = "modify")
	public String getModifyPost() {
		log.info("postModify");
		return "board/formHome";
	}
	
	/*
	  	5. Header 매핑
	  	요청 헤더를 매핑 조건으로 지정하는 경우에는 headers 속성을 사용함
	 */
	// 요청URI : http://localhost/board/ajaxHome
	@RequestMapping("/ajaxHome")
	public String ajaxHome() {
		log.info("ajaxHome");
		return "board/ajaxHome";
	}
	
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.PUT)
	public ResponseEntity<String> ajaxModify(@PathVariable("boardNo") int boardNo){
		log.info("boardNo:" + boardNo);
		
		// 헤더에 String 데이터인 "SUCCESS"데이터를 넣음
		ResponseEntity<String> entity = 
					new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		
		return entity;
	}
	
	// 요청 $.get("/board/"+boardNo,function(data)
	@RequestMapping(value = "/{boardNo}", method = RequestMethod.GET)
	public ResponseEntity<BookVO> getRead(
					@PathVariable("boardNo") int boardNo){
		log.info("boardNo : " + boardNo);
		
		BookVO bookVO = new BookVO();
		bookVO.setBookId(boardNo);
		bookVO.setTitle("천원짜리 변호사");
		bookVO.setCategory("드라마");
		bookVO.setPrice(10000);
		bookVO.setInsertDate(new Date());
		
		// vo를 응답데이터에 포함해보자
		// HttpStatus.OK : 통신 상태 200
		ResponseEntity<BookVO> entity =
				new ResponseEntity<BookVO>(bookVO,HttpStatus.OK);
		
		return entity;
	}
	
	//요청URI : /board/getBook
	//data : {"boardNo":"7"}
	@ResponseBody
	@RequestMapping(value = "/getBook",method = RequestMethod.POST)
	public List<BookVO> getBook(@RequestBody String boardNo) {
		log.info("boardNo : " + boardNo);
		
		List<BookVO> bookVOList = new ArrayList<BookVO>();
		
		BookVO bookVO = new BookVO();
		bookVO.setBookId(7);
		bookVO.setTitle("천원짜리 변호사");
		bookVO.setCategory("드라마");
		bookVO.setPrice(10000);
		bookVO.setInsertDate(new Date());
		
		bookVOList.add(bookVO);
		
		bookVO = new BookVO();
		bookVO.setBookId(8);
		bookVO.setTitle("모놀로그");
		bookVO.setCategory("음악");
		bookVO.setPrice(10000);
		bookVO.setInsertDate(new Date());
		
		bookVOList.add(bookVO);
		
		return bookVOList;
	}
}
