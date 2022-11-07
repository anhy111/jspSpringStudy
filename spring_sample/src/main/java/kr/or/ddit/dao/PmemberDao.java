package kr.or.ddit.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PmemberVO;

@Repository
public class PmemberDao {
	//DI(Dependency Injection : 의존성 주입)
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	//로그인
	//map : {"id":"a001","password":"java"}
	public PmemberVO login(Map<String,Object> map) {
		//로그인의 경우 아이디에 해당되는 행은 1행
		//.selectOne("namespace.id",파라미터)
		return this.sqlSessionTemplate.selectOne("pmember.login", map);
	}
	
	//PmemberVO(id=d001, password=java, name=개똥이, gender=남, 
	//mail=test@naver.com, phone=010-123-1234, address=대전, 
	//registDay=null, birth=2020-03-03)
	//회원가입
	public int insert(PmemberVO pmemberVO) {
		//.insert("namespace.id",파라미터)
		return this.sqlSessionTemplate.insert("pmember.insert", pmemberVO);
	}
	
	//회원상세
	//id=a001
	public PmemberVO detail(String id) {
		//.selectOne("namespace.id",파라미터)
		return this.sqlSessionTemplate.selectOne("pmember.detail", id);
	}
}












