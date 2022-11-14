package kr.or.ddit.controller;

import java.io.FileOutputStream;
import java.text.DateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.CaptureService;
import kr.or.ddit.vo.CaptureVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.filters.Caption;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	CaptureService captureService;
	
	public static String CAPTURE_PATH = "C:\\Users\\PC-18\\git\\jspSpringStudy\\module\\src\\main\\webapp\\resources\\upload\\";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		CaptureVO captureVO = new CaptureVO();
		captureVO.setName("안하용");
		
		List<CaptureVO> captureVOList = captureService.select(captureVO);
		
		model.addAttribute("captureVOList",captureVOList);
		
		return "face";
	}
	
	
	@RequestMapping(value = "/capture",method = RequestMethod.GET)
	public String capture() {
		return "capture";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/capture",method = RequestMethod.POST)
	public String capture(@RequestParam HashMap<Object, Object> param, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		
		String binaryData = request.getParameter("img");
		FileOutputStream stream = null;
		int result = 0;
		
		try{
			log.info("binary file   "  + binaryData);
			if(binaryData == null || binaryData.trim().equals("")) {
			    throw new Exception();
			}
			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
			byte[] file = Base64.getDecoder().decode(binaryData);
			String fileName=  UUID.randomUUID().toString();
			
			stream = new FileOutputStream(CAPTURE_PATH+fileName+".png");
			stream.write(file);
			stream.close();
			log.info("캡처 저장");
			
			CaptureVO captureVO = new CaptureVO();
			captureVO.setName("안하용");
			captureVO.setFilename(fileName);
			result = captureService.insert(captureVO);
		    
		}catch(Exception e){
			e.printStackTrace();
			log.info("에러 발생");
		}finally{
			if(stream != null) {
				stream.close();
			}
		}
		
		if(result < 1) {
			return "failed";
		}
		return "success";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login"; 
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(String name, Model model) {
		CaptureVO captureVO = new CaptureVO();
		captureVO.setName(name);
		
		List<CaptureVO> list = captureService.select(captureVO);
		
		model.addAttribute("captureVOList", list);
		
		return "face";
	}
	
}
