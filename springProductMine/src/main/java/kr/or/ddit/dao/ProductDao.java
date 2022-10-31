package kr.or.ddit.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.ProductVO;

@Repository
public class ProductDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insertProduct(ProductVO productVO) {
		return sqlSessionTemplate.insert("product.insert", productVO);
	}
	
	public List<ProductVO> list(String keyword){
		return sqlSessionTemplate.selectList("product.list", keyword);
	}
	
	public ProductVO selectDetail(ProductVO productVO) {
		return sqlSessionTemplate.selectOne("product.select_detail",productVO);
	}
	
	public int update(ProductVO productVO) {
		return sqlSessionTemplate.update("product.update",productVO);
	}
	
	public int delete(ProductVO productVO) {
		return sqlSessionTemplate.delete("product.delete",productVO);
	}
	
	public int insertCart(CartVO cartVO) {
		return sqlSessionTemplate.insert("product.insertCart",cartVO);
	}
	
	// ATTACH 테이블에 다중 insert
	public int insertAttach(List<AttachVO> attachVOList) {
		return sqlSessionTemplate.update("product.insertAttach", attachVOList);
	}
	
	public String getProductId() {
		return this.sqlSessionTemplate.selectOne("product.getProductId");
	}
	
}
