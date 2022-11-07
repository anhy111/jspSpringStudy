package kr.or.ddit.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

//클래스 레벨 요청 경로 지정
@RequestMapping("/board")
@Slf4j
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping("/")
	public void Home() {
		// views/board.jsp
	}
	
	//메서드 레벨 요청 경로 지정
	//value 속성에 요청 경로 설정
	//골뱅이RequestMapping(value="/board/register")
	//속성이 하나일때는 속성명을 생략할 수 있음
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public void registerForm() {
//		logger.info(msg);
		log.info("registerForm");
		//리턴타입이 void의 경우 요청경로가 
		//forwarding 경로가 됨
//		return "board/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public void registerFormPost() {
//		logger.info(msg);
		log.info("registerFormPost");
		//리턴타입이 void의 경우 요청경로가 
		//forwarding 경로가 됨
//		return "board/register";
	}
	
	// /board/modify 요청에 대한 경로를 지정해보자
	//log.info("modifyForm")
	@RequestMapping("/modify")
	public void modifyForm() {
		log.info("modifyForm");
//		return "board/modify";
	}
	
	//P.54
	//경로 패턴 매핑
	//경로(path) 변수(variable => boardNo)를 100으로 지정
	// /board/read/100 => 100번(기본키-BOARD테이블의 BOARD_NO=>boardNo) 글
	@RequestMapping("/read/{boardNo}")
	public String read(@PathVariable("boardNo") int boardNo) {
		//100
		log.info("read boardNo : " + boardNo);
		
		//경로가 동적으로 변하므로 뷰 이름 지정
		///WEB-INF/views/ .jsp
		return "board/read";
	}
	
	// /board/formHome
	@RequestMapping(value="/formHome")
	public String formHome() {
		//forwarding
		return "board/formHome";
	}
	
	// 1) /board/list 요청을 처리해보자. method는 get. list.jsp는 다음과 같음
	//		가) get일 때 log.info("update->get");  후에 return "board/update";
	//		나) post일 때 log.info("update->post"); 후에 return "board/update";
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list() {
		//forwarding
		return "board/list";
	}
	
	/* 2) 
	 <a href="/board/update">개똥이</a>
	 <form action="/board/update" method="post">
	 	<input type="text" name="title" value="개똥이" />
	 	<button type="submit">변경</button>
	 </form>
	 */
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String update() {
		log.info("update->get");  
		return "board/update";
	}
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String updatePost() {
		log.info("update->post"); 
		return "board/update";
	}
	//3) update.jsp의 내용은 <h2>변경완료</h2>로 구성해보자
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write() {
		/* write.jsp 내용 : 
		 <a href="/board/insert">목록</a>
		 <form action="/board/insert" method="post">
		 	<input type="text" name="title" value="개똥이" />
		 	<input type="submit" value="입력" />
		  </form>
		 */
		//forwarding
		return "board/write";
	}
	
	// /board/insert?id=asdf (get)
	@RequestMapping(value="/insert",method=RequestMethod.GET)
	public String insert(@RequestParam(value="id",required=false) String id, Model model) {
		model.addAttribute("id", id);
		return "board/insert";
	}
	
	// /board/insert (post)
	@RequestMapping(value="insert",method=RequestMethod.POST)
	public void insertPost(@RequestParam String title) {
//		return "board/insert";
	}
	
	// /board/get?register
	@RequestMapping(value="/get",method=RequestMethod.GET, params="register")
	public String registerParams() {
		log.info("registerParams");
		
		return "board/register";
	}
	
	// /board/post?register
	@RequestMapping(value="/post",method=RequestMethod.POST, params="register")
	public String registerParamsPost() {
		log.info("registerParamsPost");
		
		return "board/register";
	}
	
	// /board/ajaxHome
	@RequestMapping(value="/ajaxHome", method=RequestMethod.GET)
	public String ajaxHome() {
		return "board/ajaxHome";
	}
	
	// /board/ajaxHome
	@RequestMapping(value="/ajaxHomePost", method=RequestMethod.GET)
	public String ajaxHomePost() {
		//forwarding
		return "board/ajaxHomePost";
	}
	
	//요청 URI /board/100 => 100은 boardNo(게시판 기본키) => 동적으로 바뀜
	//data : {"boardNo":"1","title":"2","content":"3","writer":"4"}
	@RequestMapping(value="/{boardNo}",method=RequestMethod.PUT)
	public ResponseEntity<String> modify(@PathVariable("boardNo") int boardNo,
			@RequestBody Map<String,String> map) {
		log.info("boardNo : " + boardNo);
		log.info("map : " + map);
		
		ResponseEntity<String> entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		
		return entity;
	}
	
	//요청 URI /board/100 => 100은 boardNo(게시판 기본키) => 동적으로 바뀜
	//type : post
	//contentType:"application/xml;charset=utf-8",
	//data : {"boardNo":"1","title":"2","content":"3","writer":"4"}
	//consumes="application/json" => default. 생략 시 기본.
	@RequestMapping(value="/{boardNo}",method=RequestMethod.POST, consumes="application/xml")
	public ResponseEntity<String> modifyPost(@PathVariable("boardNo") int boardNo,
			@RequestBody Map<String,String> map) {
		log.info("boardNo : " + boardNo);
		log.info("map : " + map);
		
		ResponseEntity<String> entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		
		return entity;
	}
	
	////////////////// 컨트롤러 응답 시작 ////////////////////////////////////
	//요청 URI : /board/goHome0301
	//JSON데이터를 받을 땐.. 골뱅이RequestBody
	//JSON데이터로 보낼 땐.. 골뱅이ResponseBody
	//*****
	@ResponseBody
	@GetMapping("/goHome0301")
	public BookVO home0301() {
		log.info("home0301에 왔다");
		
		BookVO bookVO = new BookVO();
		bookVO.setBookId(100);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(10000);bookVO.setTitle("닥터개똥이");
		//자바빈 객체가 JSON으로 보내짐
		return bookVO;
	}
	
	//collection List 타입 응답
	@ResponseBody
	@GetMapping("/goHome04")
	public List<BookVO> home04(){
		log.info("home04에 왔다");
		
		List<BookVO> list = new ArrayList<BookVO>();
		
		//1)
		BookVO bookVO = new BookVO();
		bookVO.setBookId(100);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(10000);bookVO.setTitle("닥터개똥이");
		
		list.add(bookVO);
		
		//2) 
		bookVO = new BookVO();
		bookVO.setBookId(101);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(12000);bookVO.setTitle("이상한변호사 개똥개");
		
		list.add(bookVO);
		
		//3) 
		bookVO = new BookVO();
		bookVO.setBookId(102);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(15000);bookVO.setTitle("그것이 알고싶을까?");
		
		list.add(bookVO);
		
		return list;
	}
	
	//5. 컬렉션 Map 타입을 JSON으로 응답
	@ResponseBody
	@GetMapping("/goHome05")
	public Map<String,BookVO> home05(){
		log.info("home05에 왔다");
		
		Map<String, BookVO> map = new HashMap<String, BookVO>();
		
		//1)
		BookVO bookVO = new BookVO();
		bookVO.setBookId(100);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(10000);bookVO.setTitle("닥터개똥이");
		
		map.put("key1",bookVO);
		
		//2) 
		bookVO = new BookVO();
		bookVO.setBookId(101);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(12000);bookVO.setTitle("이상한변호사 개똥개");
		
		map.put("key2",bookVO);
		
		//3) 
		bookVO = new BookVO();
		bookVO.setBookId(102);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(15000);bookVO.setTitle("그것이 알고싶을까?");
		
		map.put("key3",bookVO);
		
		return map;
	}
	
	
	//Http 헤더 정보와 내용을 가공해보자
	@ResponseBody
	@GetMapping("/goHome06")
	public ResponseEntity<Void> home06(){
		log.info("home06에 왔다");
		
		//200 OK 상태코드 응답
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//Http 헤더 정보와 내용을 가공해보자
	@ResponseBody
	@GetMapping("/goHome07")
	public ResponseEntity<String> home07(){
		log.info("home07에 왔다");
		
		//200 OK 상태코드 응답
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
	
	//Http 헤더 정보와 내용을 가공해보자
	@ResponseBody
	@GetMapping("/goHome08")
	public ResponseEntity<BookVO> home08(){
		log.info("home08에 왔다");
		
		BookVO bookVO = new BookVO();
		bookVO.setBookId(100);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(10000);bookVO.setTitle("닥터개똥이");
		
		//200 OK 상태코드 응답
		return new ResponseEntity<BookVO>(bookVO,HttpStatus.OK);
	}
	
	//Http 헤더 정보와 내용을 가공해보자
	@ResponseBody
	@GetMapping("/goHome09")
	public ResponseEntity<List<BookVO>> home09(){
		log.info("home09에 왔다");
		
		List<BookVO> list = new ArrayList<BookVO>();
		
		//1)
		BookVO bookVO = new BookVO();
		bookVO.setBookId(100);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(10000);bookVO.setTitle("닥터개똥이");
		
		list.add(bookVO);
		
		//2) 
		bookVO = new BookVO();
		bookVO.setBookId(101);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(12000);bookVO.setTitle("이상한변호사 개똥개");
		
		list.add(bookVO);
		
		//3) 
		bookVO = new BookVO();
		bookVO.setBookId(102);bookVO.setCategory("소설");
		bookVO.setInsertDate(new Date());
		bookVO.setPrice(15000);bookVO.setTitle("그것이 알고싶을까?");
		
		list.add(bookVO);
		
		//200 OK 상태코드 응답
		return new ResponseEntity<List<BookVO>>(list,HttpStatus.OK);
	}
	
	//11. ResponseEntity<byte[]> 타입
	//톰켓 서버에 있는 이미지를 응답해보자.
	@ResponseBody
	@GetMapping("/goHome1101")
	public ResponseEntity<byte[]> home1101() throws IOException{
		log.info("home1101");
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			in = new FileInputStream("C:\\upload\\chopa.jpg");
			
			headers.setContentType(MediaType.IMAGE_JPEG);
			
			entity = new ResponseEntity<byte[]>(
					IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/goHome1102")
	public ResponseEntity<byte[]> home1102() throws Exception{
		log.info("home1102에 왔다");
		//001110100011101011101110
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		String fileName = "upload.zip";
		
		try {
			in = new FileInputStream("C:\\upload\\" + fileName);
			
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment;filename=\"" + 
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1") + "\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers, HttpStatus.CREATED);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		
		return entity;
	}
	////////////////// 컨트롤러 응답 끝 //////////////////////////////////// 
}














