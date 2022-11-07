package kr.or.ddit.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.PmemberDao;
import kr.or.ddit.service.PmemberService;
import kr.or.ddit.vo.PmemberVO;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

/*
 트랜잭션 : 데이터베이스를 변경하기 위해 수행되어야 할 논리적 단위. 여러개의 SQL(Insert, Update, Delete)로 구성.
 
 원일고지
 치킨 한마리를 먹기를 원하는가? 그러면 혼자 먹지 말고 친구에게 고지하여 함께 먹자. 그래야 더 맛있는 법이다.
 원자성 : All or Nothing. 모두 하나의 단위로 처리.
 일관성 : 트랜잭션 성공 시 모든 데이터는 일관되어야 함
 고립성 : 트랜잭션 진행 시 외부 간섭 없도록 함.(화장실)
 지속성 : 트랜잭션 성공 시 그 결과는 영속적으로 보관되어야 함
 */

@Service
public class PmemberServiceImpl implements PmemberService {
	//IoC(Inversion of Control : 제어의 역전)
	//DI(Dependency Injection : 의존성 주입)
	@Autowired
	PmemberDao pmemberDao;
	
	//로그인
	//map : {"id":"a001","password":"java"}
	@Override
	public PmemberVO login(Map<String,Object> map) {
		return this.pmemberDao.login(map);
	}
	
	//회원가입
	@Override
	public int insert(PmemberVO pmemberVO) {
		return this.pmemberDao.insert(pmemberVO);
	}
	
	//회원상세
	//id=a001
	@Override
	public PmemberVO detail(String id) {
		return this.pmemberDao.detail(id);
	}
}













