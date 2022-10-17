package ch12;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class InitParamFilter implements Filter {
	
	private FilterConfig filterconfig = null;
	
	//filterConfig <- {"param1":"admin","param2":"1234"}
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("Filter02초기화");
		this.filterconfig = filterConfig;
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		String param1 = filterconfig.getInitParameter("param1");
		String param2 = filterconfig.getInitParameter("param2");
		
		String message;
		
		// 한글이 깨지지 않도록 응답객체에 한글을 인코딩 처리
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		if(id.equals(param1) && passwd.equals(param2)) {
			message = "로그인 성공";
		} else {
			message = "로그인 실패";
		}
		
		PrintWriter writer = response.getWriter();
		writer.println(message);
		
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		System.out.println("Filter02 해제..");
	}
}
