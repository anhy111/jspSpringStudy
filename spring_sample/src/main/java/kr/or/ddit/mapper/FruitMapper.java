package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FruitVO;

public interface FruitMapper {
	public List<FruitVO> fruitList(String fruitGubun);
}
