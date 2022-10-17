package ch12;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class AuthenFilter implements Filter {
	
	// 필터 초기화
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("Filter01 초기화..");
	}
	
	// 필터를 리소스(jsp)에 적용
	// FilterChain : 연속적으로 필터가 있으면 다음 필터로 제어를 넘겨줌
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("Filter01 수행");
		String name = request.getParameter("name");
		
		if(name==null || name.equals("")) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			String message = "입력된 name 값은 null입니다.";
			writer.println(message);
			return;
		}
		//연속 필터시 다음 필터로 제어를 넘김
		chain.doFilter(request, response);
	}
	
	// 필터를 종료 전 호출
	@Override
	public void destroy() {
		System.out.println("Filter01 해제..");
	}
	
}
