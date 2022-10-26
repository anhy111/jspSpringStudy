package kr.or.ddit.vo;

public class ShippingVO {
	private String name;
	private String shippingDate;
	private String country;
	private String zipCode;
	private String addressName;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShippingDate() {
		return shippingDate;
	}
	public void setShippingDate(String shippingDate) {
		this.shippingDate = shippingDate;
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
	
	public boolean isNullOrEmpty() {
		if(this.name == null || this.name.equals("")) {
			return true;
		}else if(this.shippingDate == null || this.shippingDate.equals("")) {
			return true;
		}else if(this.country == null || this.country.equals("")) {
			return true;
		}else if(this.zipCode == null || this.zipCode.equals("")) {
			return true;
		}else if(this.addressName == null || this.addressName.equals("")) {
			return true;
		}
		
		return false;
	}
	
}
