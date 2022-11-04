package kr.or.ddit.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.imageio.stream.MemoryCacheImageInputStream;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.MemVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/form")
@Slf4j
@Controller
public class FormController {
	// spring form객체의 modelAttribute
	@GetMapping("/registerForm01")
	public String registerForm01(Model model) {
		log.info("registerForm01");
		
		model.addAttribute("member", new MemVO());
		
		return "form/registerForm";
	}
	
	@GetMapping("/registerForm02")
	public String registerForm02(@ModelAttribute MemVO memVO) {
		log.info("registerForm02");
		
		return "form/registerForm02";
	}
	
	@GetMapping("/registerForm03")
	public String registerForm03(@ModelAttribute("memVO") MemVO memVO,
						Model model) {
		log.info("registerForm03");
		
		// 폼 객체의 프로퍼티에 값을 미리지정해놓음
		memVO.setMemId("gaeddongi");
		memVO.setMemName("개똥이");
		// password데이터를 전달해도 password 필드에 반영 안 됨
		memVO.setMemPass("java");
		Map<String, String> hobbyMap = new HashMap<>();
		hobbyMap.put("Sports","Sports");
		hobbyMap.put("Music","Music");
		hobbyMap.put("Movie","Movie");
		
		// 라디오 버튼
		Map<String, String> genderMap = new HashMap<String, String>();
		genderMap.put("Male", "Male");
		genderMap.put("Female", "Female");
		genderMap.put("Other", "Other");
		
		// 셀렉트박스
		Map<String, String> nationalityMap = new HashMap<String, String>();
		nationalityMap.put("Korea","Korea");
		nationalityMap.put("Germany","Germany");
		nationalityMap.put("Australia","Australia");
		
		model.addAttribute("hobbyMap",hobbyMap);
		model.addAttribute("genderMap",genderMap);
		model.addAttribute("nationalityMap",nationalityMap);
		
		return "form/registerForm03";
	}
	
	@PostMapping("/register")
	public String registerPost(@Validated MemVO memVO, Model model,
							BindingResult result) {
		log.info("memVO : " + memVO.toString());
		
		// registerForm03.jsp에서 post 요청 시 @Validated 확인 후
		// 문제 발생 시 폼 화면으로 돌아감
		if(result.hasErrors()) {
			return "form/registerForm03";
		}
		
		String[] hobbyList = memVO.getHobbyList();
		
		if(hobbyList != null) {
			for(String hobby : hobbyList) {
				log.info("hobby : " + hobby);
			}
		}
		
		
		model.addAttribute("hobbyList", hobbyList);
		
		return "form/success";
	}
	
}
