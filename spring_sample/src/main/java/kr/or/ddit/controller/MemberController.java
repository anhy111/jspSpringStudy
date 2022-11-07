package kr.or.ddit.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.PmemberService;
import kr.or.ddit.vo.AddressVO;
import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PmemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member")
@Controller
public class MemberController {
	//DI(Dependency Indection : 의존성 주입)
	@Autowired
	PmemberService pmemberService;
	
	//로그인 페이지로 포워딩
	//URI => http://localhost/member/loginMember
	@GetMapping("/loginMember")
	public String loginMember() {
		//forwarding
		return "member/loginMember";
	}
	
	//로그인 페이지로 포워딩
	//URI => http://localhost/member/loginPMember
	@GetMapping("/loginPMember")
	public String loginPMember() {
		//forwarding
		return "member/loginPMember";
	}
	
	//http://localhost/member/loginMember에서 입력한 id, password를 map으로 받음
	//요청 URI => /member/processLoginMember(post)
	@PostMapping("/processLoginMember")
	public String processLoginMember(@RequestParam Map<String,Object> map,
			HttpServletRequest request, Model model) {
		//map : {id=a001, password=java}
		log.info("map : " + map);
		//request객체에 들어있는 session객체를 가져옴
		HttpSession session = request.getSession();
		
		//로그인 처리
		PmemberVO pmemberVO = this.pmemberService.login(map);
		String id = "";
		//로그인 성공 -> session.setAttribute("sessionId", id)
		// -> redirect:/member/resultMember
		if(pmemberVO!=null) {
			id = (String)map.get("id");	//a001
			//pmemberVO => 
			log.info("pmemberVO : " + pmemberVO.toString());
			session.setAttribute("id", id);
			session.setAttribute("sessionId", pmemberVO);
			
			return "redirect:/member/resultMember";
		}else {	
			//로그인 실패 -> redirect:/member/loginMember?error=1
			//로그인 페이지로 재요청
			model.addAttribute("error", 1);
			//forwarding
			return "/member/loginMember";
		}
		
	}
	
	//로그인 성공
	//요청 URI => /member/resultMember
	@GetMapping("/resultMember")
	public String resultMember(Model model) {
		
		//msg : 0 => 회원정보 수정
		//msg : 1 => 회원가입
		//msg : 2 => 로그인성공
		model.addAttribute("msg", 2);
		
		//forwarding
		return "member/resultMember";
	}
	
	//JSP의 기본 내장객체인 request 객체를 소환해보자.(servlet이 필요.)
	//로그아웃
	//요청 URI => /member/logoutMember
	@GetMapping("/logoutMember")
	public String logoutMember(HttpServletRequest request) {
		//우리는 session을 사용해야함.
		HttpSession session = request.getSession();
		
		//세션을 종료 => 로그아웃 처리 됨
		session.invalidate();
		
		//URI를 재요청(30번째줄)
//		loginMember();
		return "redirect:/member/loginMember";
	}
	
	//회원가입
	//요청 URI => /member/addMember
	@GetMapping("/addMember")
	public String addMember(@ModelAttribute PmemberVO pmemberVO) {
		//forwarding
		return "member/addMember";
	}
	
	//회원가입 처리
	//요청 URI => http://localhost/member/processAddMember
	//vo받으려면 => 골뱅이ModelAttribute
	//String받으려면 => 골뱅이RequestParam
	//PmemberVO 도메인 클래스(자바빈 클래스)에 입력값 검증을 활성화함
	//BindindResult 사용 시 Model은 사용하지 않음
	@PostMapping("/processAddMember")
	public String processAddMember(@Validated PmemberVO pmemberVO,
			BindingResult brResult) {
		//PmemberVO(id=d001, password=java, name=개똥이, gender=남, 
		//mail=test@naver.com, phone=010-123-1234, address=대전, 
		//registDay=null, birth=2020-03-03)
//		log.info("pmemberVO : " + pmemberVO.toString());
		
		log.info("brResult.hasErrors() : " + brResult.hasErrors());
		
		//요청 파라미터와 도메인 클래스의 멤버변수가 바인딩(set)될 때 오류가 생겼다면
		if(brResult.hasErrors()) {
			//검사 결과 오류 확인
			List<ObjectError> allErrors = brResult.getAllErrors();
			//객체와 관련된 오류
			List<ObjectError> globalErrors = brResult.getGlobalErrors();
			//멤버변수와 관련된 오류
			List<FieldError> fieldErrors = brResult.getFieldErrors();
			
			for(ObjectError objectError : allErrors) {
				log.info("allError : " + objectError);
			}
			
			for(ObjectError objectError : globalErrors) {
				log.info("globalError : " + objectError);
			}
			
			for(FieldError fieldError: fieldErrors) {
				log.info("fieldError : " + fieldError.getDefaultMessage());
			}
			//forwarding
			return "member/addMember";
		}
		
		//회원가입 처리
		int result = this.pmemberService.insert(pmemberVO);
		
		if(result>0) {//가입성공
			//redirect처리
			//msg : 0 => 회원정보 수정
			//msg : 1 => 회원가입
			//msg : 2 => 로그인성공
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("msg", 1);	//jsp에서는 딸러{msg}
			return "redirect:/member/resultMember?msg=1";	//jsp에서는 딸러{param.msg}
		}else {//가입실패 -> 회원가입페이지를 재요청
			return "redirect:/member/addMember";
		}
	}
	
	//////////// 스프링 폼 연습 시작 ////////////////////////////
	//요청 URI : /member/registerForm01
	@GetMapping("/registerForm01")
	public String registerForm01(Model model){
		log.info("registerForm01");
		
		PmemberVO pmemberVO = new PmemberVO();
		
		pmemberVO.setId("a001");
		pmemberVO.setName("개똥이");
		
		//<form:form modelAttribute="pmemberVO" 
		//method="post" action="/member/registerForm01Post">
		//폼 객체를 모델에 추가
		model.addAttribute("pmemberVO", pmemberVO);
		
		//forwarding
		return "member/registerForm";
	}
	
	//<form:form modelAttribute="pmemberVO" method="post" 
	//action="/member/registerForm01Post">
	//요청 URI : /member/registerForm02
	//컨트롤러 메서드의 매개변수로 자바빈즈 객체를 사용하면
	//다시 화면으로 해당 객체를 전달해줌
	@GetMapping("/registerForm02")
	public String registerForm02(@ModelAttribute PmemberVO pmemberVO,
			Model model){
		log.info("registerForm02");
		
		log.info("pmemberVO : " + pmemberVO.toString());
		
		//jsp에 반영이 되지만
		pmemberVO.setId("a001");
		pmemberVO.setName("개똥이");
		//jsp에 반영이 되지 않음. input type="password"
		pmemberVO.setPassword("java");
		//파라미터 : {"id":"a001","password":"java","name":"개똥이","mail":"test@test.com"...}
		pmemberVO.setAddress("<p>안녕하세요?</p><p>반갑습니다</p>");
		
		//취미(다중선택) => form:checkboxes
		Map<String,String> hobbyMap = new HashMap<String, String>();
		hobbyMap.put("01", "Sports");
		hobbyMap.put("02", "Music");
		hobbyMap.put("03", "Movie");
		//jsp에서 체크가 되어버림
//		pmemberVO.setHobbyMap(hobbyMap);
		
		//성별(단일선택) => form:radiobuttons
		Map<String,String> genderColdeMap = new HashMap<String, String>();
		genderColdeMap.put("Male", "Male");
		genderColdeMap.put("Female", "Female");
		genderColdeMap.put("Other", "Other");
		
		//국적(단일선택)
		//<select><option value="korea">한국</option>...
		Map<String, String> nationalityMap = new HashMap<String, String>();
		nationalityMap.put("korea", "한국");
		nationalityMap.put("germany", "독일");
		nationalityMap.put("austrailia", "오스트레일리아");
		
		//주민번호
		pmemberVO.setRegno("1111111111118");
		
		//model에 넣는다는 것은 items 속성을 사용한다는 의미도 됨
		model.addAttribute("nationalityMap", nationalityMap);
		model.addAttribute("genderColdeMap", genderColdeMap);
		model.addAttribute("hobbyMap", hobbyMap);
		model.addAttribute("member", pmemberVO);	
		
		//forwarding
		return "member/registerForm";
	}
	
	//<form:form modelAttribute="member" method="post" 
	//action="/member/registerForm01Post">
	//요청 URI : /member/registerForm03
	//골뱅이ModelAttribute 애너테이션으로 폼 객체의 속성명을 직접 지정할 수 있음
	@GetMapping("/registerForm03")
	public String registerForm03(@ModelAttribute("member") PmemberVO pmemberVO){
		log.info("pmemberVO : " + pmemberVO.toString());
		
//		pmemberVO.setId("a001");
//		pmemberVO.setName("개똥이");
		
		
		
		//forwarding
		return "member/registerForm";
	}
	
	//파라미터 : {"id":"a001","name":"개똥이","mail":"test@test.com","password":"java"}
	//요청 URI : /member/registerForm01Post
	@PostMapping("/registerForm01Post")
	public String registerForm01Post(@ModelAttribute PmemberVO pmemberVO) {
		log.info("pmemberVO : " + pmemberVO.toString());

		//생략가능
//		model.addAttribute("pmemberVO",pmemberVO);
//		pmemberVO = this.pmemberService.select(pmemberVO);
		
		//forwarding
		return "member/result";
	}
	
	////////////스프링 폼 연습 끝 ////////////////////////////
	// 회원상세보기
	// 요청URI : /member/detailMember
	// 요청파라미터 : ?id=a001
	@GetMapping("/detailMember")
	public String detailMember(String id, @RequestParam Map<String,String> map,
			@ModelAttribute PmemberVO pmemberVO,
			Model model) {
		pmemberVO = this.pmemberService.detail(id);
		
		//스프링폼을 사용하지 않는다면
		model.addAttribute("pmemberVO", pmemberVO);
		
		//forwarding
		return "member/detailMember";
	}
	
	///// 컨트롤러 요청 처리 연습 시작/////////////////////////////
	
	//요청URI : /member/register
	//요청 파라미터 : ?id=a001&password=java
	@GetMapping("/register")
	public String registerByParameter(String id, String password) {
		log.info("registerByParameter");
		log.info("id : " + id);
		log.info("password : " + password);
		//forwarding
		return "member/loginMember";
	}
	
	//URL 경로 상의 경로 변수(path variable)로부터 요청 데이터를 취득할 수 있음
	//중괄호id중괄호 : 경로 변수
	//요청URI : /member/register/a001
	@GetMapping("/register/{id}")
	public String registerByPath(@PathVariable String id) {
		log.info("registerByPath");
		log.info("id : " + id);
		//forwarding
		return "member/loginMember";
	}
	//폼 필드가 여러개일 때 폼 필드의 순서와 컨트롤러의 매개변수의 위치는 상관없음
	//폼 필드값이 숫자일 때 매개변수는 문자로 전달되지만, 컨트롤러 매개변수 타입이 숫자이면
	// 숫자로 자동타입 변환이 됨
	//요청URI : /member/registerIntCast
	//요청파라미터 : ?id=a001&password=java&coin=10
	@GetMapping("/registerIntCast")
	public String registerIntCast(String password, String id, int coin) {
		log.info("registerIntCast");
		
		log.info("id : " + id);
		log.info("password : " + password);
		//컨트롤러 매개변수 타입이 숫자형이면 숫자로 타입변환을 하여 요청 데이터 취득
		log.info("coin : " + coin);
		//forwarding
		return "member/loginMember";
	}
	
	//폼필드명과 컨트롤러 매개변수명이 일치(대소문자 구분)해야 함
	//요청 URI : /member/registerParamCorrect
	//요청파라미터 : ?id=a001&password=java&coin=10&bir=2022-08-05
	@GetMapping("/registerParamCorrect")
	public String registerParamCorrect(String id, String password, int coin,
			@RequestParam("bir") String birth) {
		log.info("registerParamCorrect");
		
		log.info("id : " + id);
		log.info("password : " + password);
		log.info("coin : " + coin);
		log.info("birth : " + birth);
		
		//forwarding
		return "member/loginMember";
	}
	
	//폼 필드 요소값을 자바빈즈 매개변수로 처리(바인딩, setting)할 수 있음
	//요청 URI : /member/register01
	//method : post
	//요청 파라미터 : ?id=a001&password=java&name=개똥이&coin=10&birth=2022-08-05
	@PostMapping("/register01")
	public String register01(@ModelAttribute PmemberVO pmemberVO, int coin) {
		log.info("register01");
		
		log.info("pmemberVO : " + pmemberVO.toString());
		//폼 필드 요소값을 1) 자바빈즈 매개변수(pmemberVO)와 
		//            2) 기본 데이터 타입인 정수 타입 매개변수로 처리 가능
		//폼 필드 요소값 목록의 순서와 매개변수 순서와 상관이 없음
		log.info("coin : " + coin);
		
		//forwarding
		return "member/loginPMember";
	}
	
	//기본은 연/월/일
	//요청 URI : /member/registerByGet01?id=a001&birth=2022/08/05
	//요청 URL : /member/registerByGet01
	//method : get
	//1) 요청 파라미터 : ?id=a001&birth=0805
	//2) 요청 파라미터 : ?id=a001&birth=2022-08-05
	//3) 요청 파라미터 : ?id=a001&birth=20220805
	//4) 요청 파라미터 : ?id=a001&birth=2022/08/05
	@GetMapping("/registerByGet01")
	public String registerByGet01(String id, Date birth) {
		log.info("registerByGet01");
		
		log.info("id : " + id);
		log.info("birth : " + birth);
		
		//forwarding
		return "member/loginPMember";
	}
	
	//요청URI : "/member/registerFormField"
	@GetMapping("/registerFormField")
	public String registerFormField() {
		log.info("registerFormField");
		return "member/registerFormField";
	}
	
	//요청URI : "/member/registerFormFieldPost"
	//골뱅이RequestParam(value="userId", required=false, defaultValue="a001") 
	@PostMapping("/registerFormFieldPost")
	public String registerFormFieldPost(
			String userId, String password, String gender, 
			String nationality, String[] carArray,
			String developer, boolean foreigner,
			AddressVO addressVO, String introduction,
			@DateTimeFormat(pattern="yyyy-MM-dd") Date dateOfBirth,
			MemberVO memberVO) {
		log.info("registerFormFieldPost");
		
		log.info("userId : " + userId);
		log.info("password : " + password);
		log.info("gender : " + gender);
		log.info("nationality : " + nationality);
		for(String car:carArray) {
			log.info("car : " + car);
		}
		log.info("developer : " + developer);
		log.info("foreigner : " + foreigner);
		log.info("postCode : " + addressVO.getPostCode());
		log.info("location : " + addressVO.getLocation());
		
		AddressVO address = memberVO.getAddress();
		if(address!=null) {
			log.info("address.getPostCode() : " + address.getPostCode());
			log.info("address.getLocation() : " + address.getLocation());
		}
		
		List<CardVO> cardList = memberVO.getCardList();
		if(cardList!=null) {
			for(CardVO cardVO : cardList) {
				log.info("cardVO.getNo() : " + cardVO.getNo());
				log.info("cardVO.getValidMonth() : " + cardVO.getValidMonth());
			}
		}
		log.info("introduction : " + introduction);
		log.info("memberVO : " + memberVO.toString());
		log.info("dateOfBirth : " + dateOfBirth);
		
		//forwarding
		return "member/registerFormField";
	}
	///// 컨트롤러 요청 처리 연습 끝/////////////////////////////
	
	///// 파일업로드 폼 방식 요청 처리 연습 시작/////////////////////////////
	
	// 요청URI : /member/registerFile01
	@GetMapping("/registerFile01")
	public String registerFile01() {
		log.info("registerFile01");
		
		//forwarding
		return "member/registerFile";
	}
	
	//<input type="file" name="picture" />
	//MultipartFile : 스프링 MVC가 지원하는 인터페이스
	//MultipartFile 매개변수로 처리
	// enctype="multipart/form-data"로 submit되었어도
	// 폼필드를 String타입의 매개변수로 받을 수 있음
	// 1) MultipartFile타입의 List 컬렉션 타입 매개변수로 처리
	// 2) MultipartFile타입의 MemberVO 자바빈즈 매개변수로 처리
	//<input type="file" name="pictureMulti" multiple />
	@PostMapping("/registerFilePost")
	public String registerFilePost(
			String userId, String password,
			MemberVO memberVO,
			MultipartFile picture,
			MultipartFile picture2,
			MultipartFile[] pictureList,
			MultipartFile[] pictureMulti) {
		log.info("registerFile01");
		log.info("userId : " + userId);
		log.info("password : " + password);
		log.info("picture : " + picture);
		log.info("picture2 : " + picture2);
		
		log.info("originalName : " + picture.getOriginalFilename());
		log.info("size : " + picture.getSize());
		log.info("contentType : " + picture.getContentType());
		
		log.info("originalName : " + picture2.getOriginalFilename());
		log.info("size : " + picture2.getSize());
		log.info("contentType : " + picture2.getContentType());
		
		log.info("memberVO : " + memberVO.toString());
		
		/*
		 <input type="file" name="pictureList[0]" /><br />
		<input type="file" name="pictureList[1]" /><br />
		 */
		//MultipartFile 타입의 매개변수로 받을 경우  
		//pictureList => List<MultipartFile> pictureList => 안됨
		//pictureList => MultipartFile[] pictureList => 됨
		log.info("pictureList.length : " + pictureList.length);
		for(MultipartFile pic  : pictureList) {
			log.info("list(param) => originalName : " + pic.getOriginalFilename());
			log.info("list(param) => size : " + pic.getSize());
			log.info("list(param) =>contentType : " + pic.getContentType());
		}
		
		//MultipartFile 타입의 멤버변수로 받으면 
		//private List<MultipartFile> pictureList; => 됨
		List<MultipartFile> pictureLists  = memberVO.getPictureList();
		log.info("pictureLists.size() : " + pictureLists.size());
		for(MultipartFile pic  : pictureLists) {
			log.info("list(vo) => originalName : " + pic.getOriginalFilename());
			log.info("list(vo) => size : " + pic.getSize());
			log.info("list(vo) =>contentType : " + pic.getContentType());
		}
		
		//매개변수
		//<input type="file" name="pictureMulti" multiple />
		log.info("pictureMulti.length : " + pictureMulti.length);
		for(MultipartFile pic : pictureMulti) {
			log.info("array => originalName : " + pic.getOriginalFilename());
			log.info("array => size : " + pic.getSize());
			log.info("array =>contentType : " + pic.getContentType());
		}
		//자바빈객체의 멤버변수
		//private List<MultipartFile> pictureMulti;
		List<MultipartFile> pictureMultiList = memberVO.getPictureMulti();
		log.info("pictureMultiList.size() : " + pictureMultiList.size());
		for(MultipartFile pic : pictureMultiList) {
			log.info("List => originalName : " + pic.getOriginalFilename());
			log.info("List => size : " + pic.getSize());
			log.info("List =>contentType : " + pic.getContentType());
		}
		
		//forwarding
		return "member/registerFile";
	}
	///// 파일업로드 폼 방식 요청 처리 연습 끝/////////////////////////////
	
	///// Ajax 방식 요청 처리 연습 시작/////////////////////////////
	// 요청 URI : /member/ajaxForm
	@GetMapping("/ajaxForm")
	public String ajaxForm() {
		//forwarding
		return "member/ajaxForm";
	}
	
	//요청 URI : /member/ajaxRegister/hongkd
	@GetMapping("/ajaxRegister/{userId}")
	public ResponseEntity<String> ajaxRegister(@PathVariable("userId") String userId) {
		log.info("ajaxRegister");
		log.info("userId : " + userId);
		//return => 1) String 2) network http상태
		ResponseEntity<String> entity = 
				new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		return entity;
	}
	//brdId(동적 게시판 아이디) => board, notice, qanda..
	//brdNo(게시판 글번호) => 100, 127, 35..
	//요청 URI : /member/ajaxRegister/board/127
	//요청 파라미터 : json데이터=> {userId:userIdVal,password:passwordVal}
	//JSON 요청 데이터는 문자열 매개변수로 처리할 수 없음 ->
	// 요청 파라미터를 통해 문자열 매개변수로 처리할 수 있음
	@PostMapping("/ajaxRegister/{brdId}/{brdNo}")
	public ResponseEntity<String> ajaxRegister2(
			@PathVariable("brdId") String brdId, 
			@PathVariable("brdNo") String brdNo,
			@RequestBody MemberVO memberVO,
			String userId, String password) {
		log.info("brdId : " + brdId);
		log.info("brdNo : " + brdNo);
		log.info("userId : " + userId);	//null -> ?userId=a001
		log.info("password : " + password); //null -> &password=java
		log.info("memberVO : " + memberVO.toString());
		
		ResponseEntity<String> entity = 
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		return entity;
	}
	
	// 요청 URI : /member/ajaxArrayForm
	// 요청 파라미터 : 객체 배열 타입의 JSON 데이터
	@GetMapping("/ajaxArrayForm")
	public String ajaxArrayForm() {
		//forwarding
		return "member/ajaxArrayForm";
	}
	
	// 요청 URI : /member/ajaxArrayFormPost
	// 요청 파라미터 : let userObjectArray = [
	//	{userId:"a001",password:"java"},
	//	{userId:"b001",password:"java"}
	//]
	// JSON 데이터는 골뱅이RequestBody로 받음
	//골뱅이PostMapping("/ajaxArrayFormPost")
	//미디어 타입. produces는 요청의 Accept 헤더 값을 지정하기 위함
	@RequestMapping(value="/ajaxArrayFormPost",method=RequestMethod.POST,
			produces="application/json")
	public ResponseEntity<String> ajaxArrayFormPost(
			@RequestBody List<MemberVO> memberVOList) {
		log.info("ajaxArrayFormPost");
		for(MemberVO memberVO : memberVOList) {
			log.info("memberVO : " + memberVO.toString());
		}
		ResponseEntity<String> entity = 
				new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		return entity;
	}
	///// Ajax 방식 요청 처리 연습 끝/////////////////////////////
	
	///// 파일업로드 Ajax 방식 요청 처리 연습 시작/////////////////////////////
	//요청URI : /member/uploadAjax
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		//forwarding
		return "member/uploadAjax";
	}
	
	//요청URI : /member/uploadAjaxPost
	//요청파라미터 : formData(폼 객체)
	//요청파라미터는 요청 헤더를 통해서 넘어오는데,
	//헤더 값을 매핑 조건으로 지정하는 경우에는 produces 속성을 사용함
	@RequestMapping(value="/uploadAjaxPost",method=RequestMethod.POST,
			produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjaxPost(MultipartFile file) {
		String originalFilename = file.getOriginalFilename();
		log.info("originalFilename : " + originalFilename);
		
		ResponseEntity<String> entity =
				new ResponseEntity<String>("UPLOAD SUCCESS " +
						originalFilename, HttpStatus.OK);
		return entity;
	}
	///// 파일업로드 Ajax 방식 요청 처리 연습 끝/////////////////////////////
	
	///// 데이터 전달자(Controller -> Jsp) 모델 연습 시작 /////////////////////////////
	
	// 1) ModelAndView : 뷰경로 + 데이터
	// 2) Model : 데이터
	// 3) 골뱅이Responsebody : json데이터
	// 요청 URI : /member/mhome
	@GetMapping("/mhome")
	public String mhome(Locale locale, Model model) {
		log.info("Welcome home! The client licale is {}.",locale);
		
		Date date = new Date();
		DateFormat dateFormat = 
				DateFormat.getDateTimeInstance(DateFormat.LONG,
						DateFormat.LONG,locale);
		//2020년 8월 9일 (화) 오후 12시 16분 17초
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate);
		
		//forwarding
		return "member/mhome";
	}
	
	//요청 URI : /member/read01
	@GetMapping("/read01")
	public String read01(Model model) {
		log.info("read01");
		//model => 데이터 객체
		//addAttribute : 속성을 추가
		//(속성명, 속성값)
		model.addAttribute("userId", "a001");
		model.addAttribute("password", "java");
		model.addAttribute("email", "test@test.com");
		model.addAttribute("userName", "개똥이");
		model.addAttribute("birthDay", "1996-12-24");
		//forwarding
		return "member/read01";
	}
	
	//요청 URI : /member/read02
	//응답 데이터 : pmemberVO 객체
	@GetMapping("/read02")
	public String read02(Model model) {
		log.info("read02");
		
		PmemberVO pmemberVO = new PmemberVO();
		pmemberVO.setId("a001");
		pmemberVO.setPassword("java");
		pmemberVO.setMail("test@test.com");
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, 1991);//연
		cal.set(Calendar.MONTH, 5);//월(0부터 시작)
		cal.set(Calendar.DAY_OF_MONTH, 24);//일
		//private Date birth;
		pmemberVO.setBirth(cal.getTime());
		//모델에 속성을 추가함
		model.addAttribute("pmemberVO", pmemberVO);
		
		return "member/read02";
	}
	
	//요청URI : /member/read03
	@GetMapping("/read03")
	public String read03(Model model) {
		log.info("read03");
		
		String[] carArray = {"saab","audi"};
		
		List<String> carList = new ArrayList<String>();
		carList.add("제네시스");
		carList.add("티볼리");
		
		List<PmemberVO> pmemberVOList = new ArrayList<PmemberVO>();
		PmemberVO pmemberVO = new PmemberVO();
		pmemberVO.setId("a001");
		pmemberVO.setName("개똥이");
		
		pmemberVOList.add(pmemberVO);
		
		pmemberVO = new PmemberVO();
		pmemberVO.setId("b001");
		pmemberVO.setName("개진순");
		
		pmemberVOList.add(pmemberVO);
		
		model.addAttribute("carArray", carArray);
		model.addAttribute("carList", carList);
		model.addAttribute("pmemberVOList", pmemberVOList);
		
		//forwarding
		return "member/read03";
	}
	
	//요청URI : /member/read03Post
	//골뱅이ResponseBody : JSON타입으로 리턴
	@ResponseBody
	@PostMapping("/read03Post")
	public List<PmemberVO> read03Post() {
		log.info("read03Post");
		
		List<PmemberVO> pmemberVOList = new ArrayList<PmemberVO>();
		PmemberVO pmemberVO = new PmemberVO();
		pmemberVO.setId("a001");
		pmemberVO.setName("개똥이");
		
		pmemberVOList.add(pmemberVO);
		
		pmemberVO = new PmemberVO();
		pmemberVO.setId("b001");
		pmemberVO.setName("개진순");
		
		pmemberVOList.add(pmemberVO);
		
		return pmemberVOList;
	}
	
	///// 데이터 전달자(Controller -> Jsp) 모델 연습 끝 /////////////////////////////
	
}















