package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.service.BomService;
import kr.or.ddit.vo.BomVO;

@Controller
public class BomController {
	@Autowired
	BomService bomService;
	
	//요청URI : /bom/bomList
	@GetMapping("/bom/bomList")
	public String bomList(Model model) {
		List<BomVO> bomList = bomService.list();
		
		model.addAttribute("bomList", bomList);
		
		//forwarding
		return "bom/bomList";
	}
}







