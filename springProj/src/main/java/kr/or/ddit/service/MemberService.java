package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MemberVO;

// 서비스 interface : 비즈니스 로직
public interface MemberService {
	public List<MemVO> list(Map<String, String> map);
	public int getTotal(Map<String, String> map);
	public int existMem(MemVO memVO);
	public MemVO detail(String memId);
	
	public int insertMem(MemVO memVO);
	public int memberInsert(MemberVO memberVO);
}
