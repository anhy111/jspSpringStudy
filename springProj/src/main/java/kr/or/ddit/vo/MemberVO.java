package kr.or.ddit.vo;

import java.util.Date;

// 자바빈 클래스
public class MemberVO {
	private String userId;
	private String password;
	private int coin;
	private Date birth;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getCoin() {
		return coin;
	}
	public void setCoin(int coin) {
		this.coin = coin;
	}
	
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", password=" + password + ", coin=" + coin + ", birth=" + birth + "]";
	}
	
	
	
}
