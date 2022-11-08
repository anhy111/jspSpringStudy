package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MemVO;

public interface MemService {

	//메소드 시그니처
	//회원번호 생성
	public int makeUserNo();
	//중복 아이디 체크
	public int dupChk(MemVO memVO);
	//회원 및 회원권한 insert
	public int insert(MemVO memVO);
	//회원 목록
	public List<MemVO> memList(Map<String,String> map);
	//회원 전체 수(검색 포함)
	public int memTotal(Map<String, String> map);
	// 새로운 MEM테이블 insert
	public int memInsert(MemVO memVO);
	// 새로운 MEM테이블 list
	public List<MemVO> memList2();
	
	public MemVO memDetail(String userNo);
	
	public int detailPwCheck(MemVO memVO);
	
	public int memUpdate(MemVO memVO);
	
	public int memDelete(MemVO memVO);
}
