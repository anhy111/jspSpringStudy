package kr.or.ddit.service;

import java.util.List;

import org.json.simple.JSONObject;

import kr.or.ddit.vo.FruitVO;

public interface FruitService {

	public JSONObject fruitList(String fruitGubun);
	
}
