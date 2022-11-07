package kr.or.ddit.service.impl;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.FruitMapper;
import kr.or.ddit.service.FruitService;
import kr.or.ddit.vo.FruitVO;

@Service
public class FruitServiceImpl implements FruitService{
	@Autowired
	FruitMapper fruitMapper;
	
	@Override
	public JSONObject fruitList(String fruitGubun){
		
		/*
		FRU001	귤	35000	fruit
		FRU002	딸기	88000	fruit
		FRU003	레몬	16500	fruit
		 */
		List<FruitVO> fruitVOList = this.fruitMapper.fruitList(fruitGubun);
		
		JSONObject data = new JSONObject();
		//fruitVOList를 json 데이터로 변환
		//1. cols 배열에 넣기(상품명, 금액)
		JSONObject col1 = new JSONObject();	//상품명
		JSONObject col2 = new JSONObject();	//금액
		
			JSONArray title = new JSONArray();
			col1.put("lable", "상품명");
			col1.put("type", "string");
			col2.put("lable", "금액");
			col2.put("type", "number");
			title.add(col1);
			title.add(col2);
			
		data.put("cols",title);
		
		//2.rows 배열에 넣기
		/*
		 {"c":[{"v":"귤"},{"v":35000}]},
		 {"c":[{"v":"딸기"},{"v":88000}]},
	 	 {"c":[{"v":"레몬"},{"v":16500}]},
		 */
		JSONArray body = new JSONArray();	//rows
		//fruitVOList => List<FruitVO> 
		for(FruitVO fruitVO : fruitVOList) {
			JSONObject prodName = new JSONObject();
			prodName.put("v", fruitVO.getFruitName());	//상품명
			
			JSONObject money = new JSONObject();
			money.put("v", fruitVO.getFruitAmount());	//금액
			
			JSONArray row = new JSONArray();
			row.add(prodName);
			row.add(money);
			
			JSONObject cell = new JSONObject();
			//row => [{"v":"귤"},{"v":35000}]
			cell.put("c", row);
			//body => {"c":[{"v":"귤"},{"v":35000}]}
			body.add(cell);	//레코드 1개 추가
		}
		
		data.put("rows", body);
		
		return data;
	}
}








