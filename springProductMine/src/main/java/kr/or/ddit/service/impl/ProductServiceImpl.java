package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProductDao;
import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService{
	//의존성 주입(DI)
	//제어의 역전(IoC)
	@Autowired
	ProductDao productDao;
	
	//PRODUCT 테이블에 insert
	@Override
	public int insertProduct(ProductVO productVO) {	
		return this.productDao.insertProduct(productVO);
	}

	@Override
	public List<ProductVO> list(String keyword) {
		return this.productDao.list(keyword);
	}
	
	@Override
	public ProductVO selectDetail(ProductVO productVO) {
		return this.productDao.selectDetail(productVO);
	}
	@Override
	public int update(ProductVO productVO) {
		return this.productDao.update(productVO);
	}
	
	@Override
	public int delete(ProductVO productVO) {
		return this.productDao.delete(productVO);
	}
}
