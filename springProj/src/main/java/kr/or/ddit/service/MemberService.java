package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MemberVO;

// 서비스 interface : 비즈니스 로직
public interface MemberService {
	public List<MemVO> list();
	public int insertMem(MemVO memVO);
	public int memberInsert(MemberVO memberVO);
}
