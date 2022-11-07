package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ProductVO;

//프링이에게 데이터와 관련된 클래스라는 것을 알려줘야 함=>프링이가 자바빈으로 등록.
@Repository
public class ProductDao {
	//DI(Dependency Injection : 의존성 주입) : ProductDao 클래스에서
	//쿼리를 실행하기 위한 sqlSessionTemplate 객체를 사용할 수 있도록 해줌
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	//상품 등록
	public int insert(ProductVO productVO) {
		//.insert(매퍼xml의 namespace.id,파라미터)
		return this.sqlSessionTemplate.insert("product.insert", productVO);
	}
	
	//상품 목록
	public List<ProductVO> list(){
		//.selectList() => 3행 => productVO 객체가 3개있음 => List로 add.
		return this.sqlSessionTemplate.selectList("product.list");
	}
	
	//상품 상세
	public ProductVO detail(String productId) {
		//쿼리를 실행하는 sqlSessionTemplate 객체를 사용
		//.selectOne("namespace.id",파라미터)
		return this.sqlSessionTemplate.selectOne("product.detail", productId);
	}
}













