package com.ssafy.dto;

public class HouseDetailDto {
	
	// 아파트 이름
	private String apartmentName;
	// 아파트 코드
	private long aptCode;
	// 거래금액
	
	private String dealAmount;
	
	// 거래일자
	private String dealDate;
	
	// 아파트 층
	private String floor;
	
	// 아파트 평수
	private String area;

	public String getApartmentName() {
		return apartmentName;
	}

	public void setApartmentName(String apartmentName) {
		this.apartmentName = apartmentName;
	}

	public long getAptCode() {
		return aptCode;
	}

	public void setAptCode(long aptCode) {
		this.aptCode = aptCode;
	}

	public String getDealAmount() {
		return dealAmount;
	}

	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}

	public String getDealDate() {
		return dealDate;
	}

	public void setDealDate(String dealDate) {
		this.dealDate = dealDate;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Override
	public String toString() {
		return "HouseDetailDto [apartmentName=" + apartmentName + ", aptCode=" + aptCode + ", dealAmount=" + dealAmount
				+ ", dealDate=" + dealDate + ", floor=" + floor + ", area=" + area + "]";
	}
	
	
	

}
