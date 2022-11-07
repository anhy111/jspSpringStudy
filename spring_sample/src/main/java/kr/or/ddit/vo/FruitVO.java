package kr.or.ddit.vo;

//자바빈 클래스
public class FruitVO {
	private String fruitId;
	private String fruitName;
	private int fruitAmount;
	private String fruitGubun;
	
	public String getFruitId() {
		return fruitId;
	}
	public void setFruitId(String fruitId) {
		this.fruitId = fruitId;
	}
	public String getFruitName() {
		return fruitName;
	}
	public void setFruitName(String fruitName) {
		this.fruitName = fruitName;
	}
	public int getFruitAmount() {
		return fruitAmount;
	}
	public void setFruitAmount(int fruitAmount) {
		this.fruitAmount = fruitAmount;
	}
	public String getFruitGubun() {
		return fruitGubun;
	}
	public void setFruitGubun(String fruitGubun) {
		this.fruitGubun = fruitGubun;
	}
	@Override
	public String toString() {
		return "FruitVO [fruitId=" + fruitId + ", fruitName=" + fruitName + ", fruitAmount=" + fruitAmount
				+ ", fruitGubun=" + fruitGubun + "]";
	}
	
	
}
