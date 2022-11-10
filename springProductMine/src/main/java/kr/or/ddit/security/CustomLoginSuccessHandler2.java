package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler2 extends
				SavedRequestAwareAuthenticationSuccessHandler{
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
					HttpServletResponse response, Authentication auth) 
								throws ServletException, IOException {
		log.warn("onAuthenticationSuccess2 호출됨");
		
		// Authentication(인증) -> 로그인
		User customUser = (User)auth.getPrincipal();
		
		log.info("username : " + customUser.getUsername());
		log.info("password : " + customUser.getPassword());
		
		clearAuthenticationAttribute(request);
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();
		
		log.warn("Login Success targetUrl : " + targetUrl);
		
		response.sendRedirect(targetUrl);
		
	}
	
	// 인증 오류가 세션에 담겨 있다면 인증이 성공했으므로 clear 해줘야 함
	private void clearAuthenticationAttribute(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			return;
		}
		
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
}
