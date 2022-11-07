package kr.or.ddit.util;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

//골뱅이ControllerAdvice 애너테이션 : 스프링 컨트롤러에서 발생하는 예외를 처리하는
// 핸들러 클래스임을 명시
//@ControllerAdvice
public class CommonExceptionHandler {
	//괄호안에 설정한 예외 타입을 해당 메서드가 처리한다는 의미
	@ExceptionHandler(Exception.class)
	public String errorDefault(Exception ex, Model model) {
		model.addAttribute("exception", ex);
		
		//forwarding
		return "error/errorDefault";
	}
}
