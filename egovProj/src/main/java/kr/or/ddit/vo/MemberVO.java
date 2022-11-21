package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String memId;	//************** username
	private String memPass; //************** password
	private String memName;
	private String memRegno1;
	private String memRegno2;
	private Date memBir;
	private String memZip;
	private String memAdd1;
	private String memAdd2;
	private String memHometel;
	private String memComtel;
	private String memHp;
	private String memMail;
	private String memJob;
	private String memLike;
	private String memMemorial;
	private Date memMemorialday;
	private int memMileage;
	private String memDelete;
	private String enabled; //************** enabled
	
	private List<MemberAuthVO> memberAuthVOList;

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPass=" + memPass + ", memName=" + memName + ", memRegno1=" + memRegno1
				+ ", memRegno2=" + memRegno2 + ", memBir=" + memBir + ", memZip=" + memZip + ", memAdd1=" + memAdd1
				+ ", memAdd2=" + memAdd2 + ", memHometel=" + memHometel + ", memComtel=" + memComtel + ", memHp="
				+ memHp + ", memMail=" + memMail + ", memJob=" + memJob + ", memLike=" + memLike + ", memMemorial="
				+ memMemorial + ", memMemorialday=" + memMemorialday + ", memMileage=" + memMileage + ", memDelete="
				+ memDelete + ", enabled=" + enabled + ", memberAuthVOList=" + memberAuthVOList + "]";
	}
	
	
}
