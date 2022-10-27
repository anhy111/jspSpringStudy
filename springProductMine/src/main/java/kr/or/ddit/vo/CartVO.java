package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;


public class CartVO {
	private String cartId;
	private String name;
	private String shippingDate;
	private String country;
	private String zipCode;
	private String addressName;
	private String addressDetail;
	private Date registDt;
	
	private List<CartDetVO> cartDetVOList;
	
	public String getCartId() {
		return cartId;
	}

	public void setCartId(String cartId) {
		this.cartId = cartId;
	}

	public String getName() {
		return name;
	}

	public String getShippingDate() {
		return shippingDate;
	}

	public void setShippingDate(String shippingDate) {
		this.shippingDate = shippingDate;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public Date getRegistDt() {
		return registDt;
	}
	public void setRegistDt(Date registDt) {
		this.registDt = registDt;
	}
	
	public List<CartDetVO> getCartDetVOList() {
		return cartDetVOList;
	}

	public void setCartDetVOList(List<CartDetVO> cartDetVOList) {
		this.cartDetVOList = cartDetVOList;
	}

	@Override
	public String toString() {
		return "CartVO [cartId=" + cartId + ", name=" + name + ", shippingDate=" + shippingDate + ", country=" + country
				+ ", zipCode=" + zipCode + ", addressName=" + addressName + ", addressDetail=" + addressDetail
				+ ", registDt=" + registDt + ", cartDetVOList=" + cartDetVOList + "]";
	}

	
	
	
	
}
