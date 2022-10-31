package kr.or.ddit.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.MemVO;

@Repository
public class MemberDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<MemVO> list() {
		return this.sqlSessionTemplate.selectList("member.list");
	}
}
