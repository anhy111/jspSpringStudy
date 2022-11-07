package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import lombok.Data;

//자바빈 클래스 => 1) 멤버변수 2) 기본생성자 3) getter/setter메소드
/*
Bean Validation이 제공하는 제약 애너테이션
 	- NotNull : 빈 값 체크
 - NotBlank : null 체크, trim후 길이가 0인지 체크
 - Size : 글자 수 체크
 - Email : 이메일 주소 형식 체크
 - Past : 오늘보다 과거 날짜(ex. 생일)
 - Future : 미래 날짜 체크(ex. 예약일)
*/
@Data
public class PmemberVO {
	@NotBlank
	private String id;
	@NotBlank
	private String password;
	@NotBlank
	private String name;
	private String gender;
	@Email
	private String mail;
	private String phone;
	private String address;
	private String registDay;
	//2022-08-01
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	//주민번호(hidden처리)
	private String regno;
	
	//국적
	private String nationality;
	
	//취미(jsp의 체크박스는 문자형 배열로 들어옴)
//	private String[] hobbyMap;
	private List<String> hobbyMap;
	
	//카드(카드번호, 유효기간)
	private List<CardVO> cardVOList;
	
	//코인
	private int coin;
}


















