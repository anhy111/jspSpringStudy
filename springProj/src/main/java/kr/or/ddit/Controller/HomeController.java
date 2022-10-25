package kr.or.ddit.Controller;

import java.lang.ref.ReferenceQueue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/")
@Slf4j
@Controller
public class HomeController {
	/* 1. void 타입
		호출하는 URL과 동일한 뷰 이름을 나타냄
		요청한 url의 jsp로 forward
	 */
	@RequestMapping(value = "/goHome0101",method = RequestMethod.GET)
	public void home0101() {
		log.info("home0101");
		// == return "goHome0101" 
	}
	
	@RequestMapping(value = "/goHome0102",method = RequestMethod.GET)
	public void home0102() {
		log.info("home0102");
	}
	
	/*
		2. String 타입
		뷰 파일의 경로와 파일 이름을 나타내기 위해 사용
	 */
	@RequestMapping(value = "/goHome0201",method = RequestMethod.GET)
	public String home0201() {
		log.info("home0201");
		
		return "goHome0201";
	}
	
	@RequestMapping(value = "/goHome0202",method = RequestMethod.GET)
	public String home0202() {
		log.info("home0202");
		
		return "goHome0202";
	}
	
	
}
