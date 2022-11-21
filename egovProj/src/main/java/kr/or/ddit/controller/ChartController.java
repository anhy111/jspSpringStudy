package kr.or.ddit.controller;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.ProdService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/chart")
@Controller
public class ChartController {
	
	@Autowired
	ProdService prodService;
	
	//json 구글차트
	@GetMapping("/chart01")
	public String chart01() {
		
		return"chart/chart01";
	}
	
	//json 구글 멀티 차트
	@GetMapping("/chart01Multi")
	public String chart01Multi() {
		
		return"chart/chart01Multi";
	}
	
	//oracle 구글차트
	@GetMapping("/chart02")
	public String chart02() {
		List<Map<String, Object>> list = this.prodService.amtSale();
		
		log.info("list : " + list);
		for(Map<String, Object> map : list) {
			log.info("map : " + map);
		}
		return"chart/chart02";
	}
}