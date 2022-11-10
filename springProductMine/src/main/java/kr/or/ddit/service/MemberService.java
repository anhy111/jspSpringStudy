package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ProductVO;

public interface MemberService {

	public MemberVO read(String memId);
}
