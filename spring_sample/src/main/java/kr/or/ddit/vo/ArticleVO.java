package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

// 요청 파라미터 : ?writerId=a001&writerName=&title=&artContent=asdf
//=> 바인딩 
// articleVO.setArticleNo(12), articleVO.setWriterId("a001")
//자바빈 클래스(=도메인 클래스)
//PoJo(Plain(단순한, 원래의) oriented(지향) Java Object)
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
public class ArticleVO {
	//일련번호
	private int rnum;
	private int articleNo;
	private String writerId;
	//작성자(필수-mandatory), null 체크, trim후 길이가 0인지 체크
	@NotBlank
	private String writerName; 
	//제목(필수)
	@NotBlank
	private String title;
	private String artContent;
	private Date regdate;
	private Date moddate;
	private int readCnt;
}






