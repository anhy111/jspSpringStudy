package kr.or.ddit.Controller;

import java.util.Date;

import javax.jws.soap.SOAPBinding.Use;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@GetMapping("/register")
	public String registerByParameter(String userId, String passwd) {
		log.info("registerByParameter");
		
		log.info("userId : " + userId);
		log.info("passwd : " + passwd);
		
		return "success";
	}
	
	// 경로(path) 변수(variable)
	@RequestMapping(value = "/register/{userId}", method = RequestMethod.GET)
	public String registerByPath(@PathVariable String userId) {
		log.info("registerByPath");
		
		log.info("userId : " + userId);
		
		return "success";
	}
	
	@GetMapping("/register01")
	public String register01() {
		return "register";
	}
	
	@PostMapping("/register01")
	public String register01Post(String userId, String password, String coin) {
		log.info("userId : " + userId);
		log.info("password : " + password);
		log.info("coin : " + coin);
		
		return "success";
	}
	
	@GetMapping("/register/register03")
	public String register03() {
		return "register/register";
	}
	/*
		폼 필드 값이 숫자일 경우 컨트롤러 타입을 숫자형으로 작성하여 숫자로 타입 변환 후
		요청 데이터를 취득할 수 있음
	 */
	@PostMapping("/register/register03")
	public String register03Post(String userId, String password, int coin) {
		
		log.info("userId : " + userId);
		log.info("password : " + password);
		log.info("coin : " + coin);
		return "register/success";
	}
	
	// 골뱅이PathVariable 애너테이션을 사용하여 특정한 경로 변수명을 지정
	@RequestMapping(value = "/register/register03/{userId}/{coin}")
	public String register03ByPath(@PathVariable("userId") String userId,
				@PathVariable("coin") int coin) {
		log.info("register03ByPath");
		log.info("userId : " + userId);
		log.info("coin : " + coin);
		
		return"register/success";
	}
	
	@GetMapping("/register/register04")
	public String register04ByParam() {
		return "register/register04";
	}
	
	@PostMapping("/register/register04")
	public String register04Post( 	@RequestParam("userId") String id,
									@RequestParam("password") String pw,
									@RequestParam("coin") int coin) {
		log.info("id : " + id);
		log.info("pw : " + pw);
		log.info("coin : " + coin);
		
		return "register/success";
	}
	
	@GetMapping("/register/register05")
	public String register05ByBeans() {
		return "register/register05";
	}
	
	// 폼 텍스트 필드 요소의 값을 자바빈즈 매개변수의 정수 타입 매개변수로 처리 됨
	@PostMapping("/register/register05")
	public String register05ByBeansPost(@ModelAttribute MemberVO memberVO,
				int coin) {
		log.info("memberVO : " + memberVO.toString());
		log.info("coin : " + coin);
		
		return "register/success";
	}
	
	// birth=1234 (x)
	// birth=2022-10-31 (x)
	// birth=20221031 (x)
	// birth=2022/10/31 (o) 이런 형식으로 날짜형식을 넘겨야 함
	//	날짜 형식은 '/'를 구분자로 데이터를 넘겨줌
	@GetMapping("/register/registerByGet01")
	public String registerByGet01(String userId, Date birth) {
		log.info("registerByGet01");
		
		log.info("userId : " + userId);
		log.info("birth : " + birth);
		
		return "register/success";
	}
	
	
	@GetMapping("/register/registerByGet02")
	public String registerByGet02(MemberVO memberVO) {
		log.info("registerByGet02");
		
		log.info("userId : " + memberVO.getUserId());
		log.info("birth : " + memberVO.getBirth());
		
		return "register/success";
	}
	
	
}
