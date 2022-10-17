package ch12.com.filter;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginCheckFilter implements Filter {
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if(id == null || pw == null || id.equals("") || pw.equals("")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Exercise/ch12/loginForm.jsp");
			dispatcher.forward(request, response);
		}
		
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		
	}
}
