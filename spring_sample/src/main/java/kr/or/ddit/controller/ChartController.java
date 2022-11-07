package kr.or.ddit.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.FruitService;

@RequestMapping("/chart")
@Controller
public class ChartController {
	@Autowired
	FruitService fruitService;
	
	//요청 URI : /chart/chartMain
	@GetMapping("/chartMain")
	public String chartMain() {
		//forwarding
		return "chart/chartMain";
	}
	
	//요청 URI : /chart/chart01
	@GetMapping("/chart01")
	public String chart01() {
		//forwarding
		return "chart/chart01";
	} 
	
	//요청 URI : /chart/chart01Multi
	@GetMapping("/chart01Multi")
	public String chart01Multi() {
		//forwarding
		return "chart/chart01Multi";
	}
	
	//요청 URI : /chart/chart02
	//골뱅이ResponseBody => JSON 데이터로 리턴
	@ResponseBody
	@GetMapping("/chart02")
	public JSONObject chart02(String fruitGubun) {
		//JSON 테이터를 리턴
		return this.fruitService.fruitList(fruitGubun);
	}
}









