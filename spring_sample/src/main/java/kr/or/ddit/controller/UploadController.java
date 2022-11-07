package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@RequestMapping("/upload")
@Controller
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		//리턴타입을 void로 하면 /upload/uploadForm.jsp 로 조립이 됨
		log.info("upload form");
	}
	//<input type="file" name="uploadFile" multiple />
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') and hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
//	골뱅이Secured({"ROLE_ADMIN","ROLE_MEMBER"})
//	골뱅이PreAuthorize("isAuthenticated()") : 로그인한 사용자만 접근 가능
	@PreAuthorize("isAnonymous()") 
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile) {
		//MultipartFile : 스프링에서 제공해주는 타입
		/*
		 --잘 씀
		 String getOriginalFileName() : 업로드 되는 파일의 이름(실제 파일명)
		 boolean isEmpty() : 파일이 없다면 true
		 long getSize() : 업로드되는 파일의 크기
		 transferTo(File file) : 파일을 저장
		 
		 --잘 안씀..
		 String getName() : <input type="file" name="uploadFile" 에서 uploadFile을 가져옴
		 byte[] getBytes() : byte[]로 파일 데이터 반환
		 inputStream getInputStream() : 파일데이터와 연결된 InputStream을 반환
		 */
		//파일이 저장되는 경로
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------");
			//이미지 명
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			//uploadFolder : C:\\upload
			//multipartFile.getOriginalFilename() : img01.jpg
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				//파일이 복사 됨
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}//end for
		
		
	}
	
	//요청 URI => localhost/upload/uploadAjax
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		//forwarding
		return "upload/uploadAjax";
	}
	
	//Ajax는 비동기
	//요청 URI => /upload/uploadAjaxAction
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') and hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
//	골뱅이PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
//	골뱅이Secured({"ROLE_ADMIN","ROLE_MEMBER"})
//	골뱅이PreAuthorize("isAuthenticated()") : 로그인한 사용자만 접근 가능
	@ResponseBody
	@PreAuthorize("isAnonymous()") 
	@PostMapping("/uploadAjaxAction")
	public String uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("uploadAjaxAction에 왔다");
		log.info("uploadFile : " + uploadFile);
		
		String uploadFolder 
			= "D:\\A_TeachingMaterial\\06_spring\\springProj\\src\\main\\webapp\\resources\\upload";
		
		//make folder 시작 ---------------------------
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		
		//만약 년/월/일 해당 폴더가 없다면 생성
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		//make folder 끝 ---------------------------
		
		//배열로부터 하나씩 파일을 꺼내오자
		for(MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			//IE 처리 => 경로를 제외한 파일명만 추출 
			//c:\\upload\\image01.jpg => image01.jpg
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			log.info("only file name : " + uploadFileName);
			
			//------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 시작 -------------
			//java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID(); //임의의 값을 생성
			//원래의 파일 이름과 구분하기 위해 _를 붙임
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			//------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 -------------			
			
			//File 객체 설계(복사할 대상 경로 , 파일명)
//			File saveFile = new File(uploadFolder, uploadFileName);
			//uploadPath : D:\\A_TeachingMaterial\\06_spring\\springProj\\src\\
			//					main\\webapp\\resources\\upload\\2022\\07\\22
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				//파일 복사가 일어남
				multipartFile.transferTo(saveFile);
				
				//이미지인지 체킹
				if(checkImageType(saveFile)) {	//이미지라면..
					FileOutputStream thumbnail = new FileOutputStream(
							new File(uploadPath, "s_" + uploadFileName)
							);
					//섬네일 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				
				return "1";
			} catch (IllegalStateException e) {
				log.error(e.getMessage());
				return "0";
			} catch (IOException e) {
				log.error(e.getMessage());
				return "0";
			}//tnd catch
		}//end for
		return "0";
	}//uploadAjaxAction
	
	//년/월/일 폴더 생성
	public static String getFolder() {
		//2022-07-22 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util패키지)
		Date date = new Date();
		//2022-07-22
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//용량이 큰 파일을 섬네일 처리를 하지 않으면
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	//이미지의 경우 특별한 경우가 아니면 섬네일을 제작해야 함.
	//섬네일은 이미지만 가능함.
	//이미지 파일의 판단
	public static boolean checkImageType(File file) {
		/*
		 .jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		 */
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	//파일 다운로드
	// localhost/upload/download?fileName=2022/07/25/cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
	@ResponseBody
	@GetMapping("/download")
	public ResponseEntity<Resource> download(@RequestParam String fileName){
		log.info("fileName : " + fileName);
		
		//resource : 다운로드 받을 파일(자원)
		Resource resource = new FileSystemResource(
				"C:\\eclipse-jee-2020-06-R-win32-x86_64\\workspace\\spring_sample\\src\\main\\webapp\\resources\\upload"
				+fileName
				);
		//cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
		String resourceName = resource.getFilename();
		//header : 인코딩 정보, 파일명 정보
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition", "attachment;filename="+
					new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			log.info(e.getMessage());
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
}












