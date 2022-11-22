package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ProdMapper;
import kr.or.ddit.service.ProdService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProdServiceImpl implements ProdService {
	
	@Autowired
	ProdMapper prodMapper;
	
	@Override
	public JSONObject amtSale() {
		
		List<Map<String, Object>> list = this.prodMapper.amtSale();
		
		log.info("list : " + list);
		//JSONObject 만들기
		JSONObject data = new JSONObject();
		
		/*
		"cols":[
			{"id":"","label":"상품명","pattern":"","type":"string"},
			{"id":"","label":"금액","pattern":"","type":"number"}
		],
		 */
		// 1. cols 배열에 넣기
		// JSON 컬럼 객체
		JSONObject col1 = new JSONObject();	// 상품명
		JSONObject col2 = new JSONObject(); // 금액
		
		col1.put("label","상품명");
		col1.put("type","string");
		col2.put("label","금액");
		col2.put("type","number");
		
		JSONArray title = new JSONArray();
		title.add(col1);
		title.add(col2);
		
		data.put("cols",title);
		
		
		/*
		"rows":[
			{"c":[{"v":"귤"},{"v":35000}]},
			{"c":[{"v":"딸기"},{"v":88000}]},
			{"c":[{"v":"레몬"},{"v":16500}]},
			{"c":[{"v":"오렌지"},{"v":20000}]},
			{"c":[{"v":"키위"},{"v":30000}]},
			{"c":[{"v":"포도"},{"v":15000}]}
		]
		 */
		// 2. rows에 넣기
		JSONArray body = new JSONArray();
		for(Map<String, Object> map : list) {
			JSONObject prodName = new JSONObject();
			prodName.put("v",map.get("PRODNAME"));
			JSONObject money = new JSONObject();
			money.put("v",map.get("MONEY"));
			
			JSONArray row = new JSONArray();
			row.add(prodName);
			row.add(money);
			
			JSONObject cell = new JSONObject();
			cell.put("c",row);
			
			body.add(cell);
		}
		
		data.put("rows",body);
		
		return data;
	}

}
