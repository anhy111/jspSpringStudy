package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.MemberVO;

public class CustomUser extends User{
	private static final long serialVersionUID = 1L;
	
	private MemberVO memberVO;

	// constructor(생성자)
	// username : 사용자ID / password : 비밀번호
	// authorities : 권한리스트
	public CustomUser(String username, String password,
				Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	// 사용자가 정의한 MemberVO 타입을 스프링 시큐리티 UsersDetails 타입으로 변환
	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMemId(), memberVO.getMemPass(),
				memberVO.getMemberAuthVOList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList())
			);
		this.memberVO = memberVO;
	}

	//외부에서 memberVO 멤버변수를 사용하려면 getter메소드가 필요함
	public MemberVO getMemberVO() {
		return memberVO;
	}
	
}
