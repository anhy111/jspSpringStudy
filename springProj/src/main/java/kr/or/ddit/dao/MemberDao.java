package kr.or.ddit.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MemberVO;

@Repository
public class MemberDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<MemVO> list(Map<String, String> map) {
		return this.sqlSessionTemplate.selectList("member.list", map);
	}
	
	public int getTotal(Map<String, String> map) {
		return this.sqlSessionTemplate.selectOne("member.getTotal", map);
	}
	
	public int insertMem(MemVO memVO) {
		return this.sqlSessionTemplate.insert("member.insertMem",memVO);
	}
	
	public int existMem(MemVO memVO) {
		return this.sqlSessionTemplate.selectOne("member.existMem",memVO);
	}
	
	
	//member2
	public int memberInsert(MemberVO memberVO) {
		return this.sqlSessionTemplate.insert("member.memberInsert", memberVO);
	}
	
	public int addressInsert(MemberVO memberVO) {
		return this.sqlSessionTemplate.insert("member.addressInsert",memberVO);
	}
	
	public int insertCard(List<CardVO> cardVOList) {
		return this.sqlSessionTemplate.update("member.insertCard",cardVOList);
	}
}
