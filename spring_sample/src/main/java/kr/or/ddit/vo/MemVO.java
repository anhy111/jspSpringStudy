package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.experimental.PackagePrivate;

//회원정보 자바빈 클래스
/*
 	입력값 검증(서버_비즈니스 로직)
 	스프링 MVC는 Bean Validation 기능을 이용해 요청 파라미터 값이
 	바인딩 된 도메인 클래스의 입력값 검증을 함
 	크롬 -> jsp(post)요청 -> 자바빈으로 파라미터 매핑 -> 자바빈에서 validation체킹
 	-> 오류 발생 시 요청된 jsp로 forwarding -> jsp에서 오류 표시
 */

/*
	입력값 검증 규칙 : 입력값 검증 규칙은 Bean Validation이 제공하는 제약 애너테이션으로 설정
	1. NotNull : 빈 값이 아닌지를 검사
	2. BotBlank : 문자열이 null이 아니고 trim한 길이가 0보다 크다는 것을 검사
	3. Size : 글자 수잔 컬렉션의 요소 개수 검사
	4. Email : 이메일 주소 형식인지 검사
	5. Past : 과거 날짜인지 검사
	6. Future : 미래 날짜인지 검사
 */
@Data
public class MemVO {
	private int userNo;
	
	@NotBlank 	// 필수 입력 검증
	private String userId;
	
	@NotBlank
	private String userPw;
	
	@NotBlank
	@Size(max = 3)
	private String userName;
	
	@Email
	private String userEmail;
	
	private int coin;
	
	@DateTimeFormat(pattern = "yyyyMMdd")
	private Date regDate;
	
	@Past	// 과거 날짜인지 검사
	@DateTimeFormat(pattern = "yyyyMMdd")
	private Date updDate;
	
	private String enabled;
	private String filename;	//첨부파일명
	//중첩된 자바빈 클래스의 유효성 검사
	private List<MemAuthVO> memAuthVOList;
	//첨부파일
	private MultipartFile[] memImage;
	
	//중첩된 자바빈즈(vo에 포함된 vo) 입력값 검증 -> 골뱅이Valid
	//첨부파일리스트
	@Valid
	private List<AttachVO> attachVOList;
	//행번호
	private int rnum;
	//페이지번호
	private int pnum;
	
}








