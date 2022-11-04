package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MemberVO;

public interface MemMapper {
	//글 목록
	public List<MemVO> list(Map<String, String> map);
	public int getTotal(Map<String, String> map);
	public int insertMem(MemVO memVO);
	public int existMem(MemVO memVO);
	public MemVO detail(String memId);
	
	//member2
	public int memberInsert(MemberVO memberVO);
	public int addressInsert(MemberVO memberVO);
	public int insertCard(List<CardVO> cardVOList);
}
