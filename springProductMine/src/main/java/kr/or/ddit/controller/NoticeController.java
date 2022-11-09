package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/notice")
@Slf4j
@Controller
public class NoticeController {
	
	@GetMapping("/list")
	public String list() {
		log.info("list : access to all");
		
		return "notice/list";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		log.info("registerForm : access to register");
		return "notice/register";
	}
	
	
}
