package kr.or.ddit.vo;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

//회원권한 자바빈 클래스
@Data
public class MemAuthVO {
	@NotBlank
	private int userNo;
	@NotBlank
	private String auth;
}






