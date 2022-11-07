package kr.or.ddit.service;

import java.util.Map;

import kr.or.ddit.vo.PmemberVO;

public interface PmemberService {
	//메소드 시그니처
	//로그인
	public PmemberVO login(Map<String, Object> map);
	//회원가입
	public int insert(PmemberVO pmemberVO);
	//회원상세
	public PmemberVO detail(String id);	
}
