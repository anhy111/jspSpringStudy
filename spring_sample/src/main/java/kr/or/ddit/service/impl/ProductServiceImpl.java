package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProductDao;
import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;

//프링이에게 이 클래스는 서비스 클래스이라는 것을 알려주면, 자바빈으로 등록하여 관리
@Service
public class ProductServiceImpl implements ProductService {
	//주입 주체? 개발자(x), 프링이(o) => IoC(Inversion of Control : 제어의 역전)
	//DI(Dependency Injection : 의존성 주입)
	//ProductServiceImpl 클래스에서 productDao객체를 주입하여
	//사용
	@Autowired
	ProductDao productDao;
	
	//Override : 슈퍼타입(부모)의 메소드를 재정의하여 상세화
	//Overloading : 동일 클래스에서 같은 이름의 메소드를 여러번 사용(파라미터의 개수, 파라미터의 타입) 
	//상품 등록
	@Override
	public int insert(ProductVO productVO) {
		return this.productDao.insert(productVO);
	}
	
	//상품 목록
	@Override
	public List<ProductVO> list(){
		return this.productDao.list();
	}
	
	//상품 상세
	@Override
	public ProductVO detail(String productId) {
		//select결과 1행 리턴
		return this.productDao.detail(productId);
	}
}









