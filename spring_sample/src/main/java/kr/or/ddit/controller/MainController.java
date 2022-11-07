package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	// 요청URI : /
	
	@GetMapping("/")
	public String home() {
		//forwarding
		return "index";
	}
}
