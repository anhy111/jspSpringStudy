package kr.or.ddit.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	//board 목록 - 모두 접근 가능[인가]
	//요청 URI : /board/blist
	@GetMapping("/board/blist")
	public String blist() {
		//forwarding
		return "board/blist";
	}
	
	//board 작성 - 회원만 접근 가능[인가]
	//요청 URI : /board/bregister
	//<security:intercept-url pattern="/board/bregister" access="hasRole('ROLE_MEMBER')" />
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/board/bregister")
	public String bregister() {
		//forwarding
		return "board/bregister";
	}
	
	//notice 목록 - 모두 접근 가능[인가]
	//요청 URI : /notice/nlist
	@GetMapping("/notice/nlist")
	public String nlist() {
		//forwarding
		return "notice/nlist";
	}
	
	//notice 작성 - 관리자만 접근 가능[인가]
	//요청 URI : /notice/nregister
	//<security:intercept-url pattern="/notice/nregister" access="hasRole('ROLE_ADMIN')" />
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/notice/nregister")
	public String nregister() {
		//forwarding
		return "notice/nregister";
	}
}






