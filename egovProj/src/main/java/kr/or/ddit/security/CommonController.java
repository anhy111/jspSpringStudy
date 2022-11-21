package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	// 스프링 시큐리티 접근 권한 거부
	// 접근이 불가능한 페이지(관리자 전용 페이지를 다른 권한을 가진 사람이 접근하려 한다면)
	// 접근 거부 처리가 되어 accessError.jsp를 forwarding 함
	@RequestMapping("/security/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg","Access Denied");
		
		return "security/accessError";
	}
	
	//기본 로그인 페이지가 아닌 사용자가 직접 정의한 로그인 페이지를 사용함
	
	@RequestMapping("/security/login")
	public String loginForm(String error, String logout, Model model) {
		
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error","Login Error!!");
		}
		
		if(logout!= null) {
			model.addAttribute("logout","Logout!!");
		}
		
		return "security/loginForm";
	}
}
