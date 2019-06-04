package com.cafetale.cafe.model;

import java.util.List;

public class CafeDetailDto extends CafeDto{
	private String cafe_image;
	private int cafe_graderate;
	private int cafe_good;
	private String good_date;
	private String rc_date;
	private String grade_rate;
	private String memo;
	private String message;
	private String member_id;
	private String friend_id;
	private String latitude;
	private String longitude;
	
	public String getCafe_image() {
		return cafe_image;
	}
	public void setCafe_image(String cafe_image) {
		this.cafe_image = cafe_image;
	}
	public int getCafe_graderate() {
		return cafe_graderate;
	}
	public void setCafe_graderate(int cafe_graderate) {
		this.cafe_graderate = cafe_graderate;
	}
	public int getCafe_good() {
		return cafe_good;
	}
	public void setCafe_good(int cafe_good) {
		this.cafe_good = cafe_good;
	}
	public String getGood_date() {
		return good_date;
	}
	public void setGood_date(String good_date) {
		this.good_date = good_date;
	}
	public String getRc_date() {
		return rc_date;
	}
	public void setRc_date(String rc_date) {
		this.rc_date = rc_date;
	}
	public String getGrade_rate() {
		return grade_rate;
	}
	public void setGrade_rate(String grade_rate) {
		this.grade_rate = grade_rate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getFriend_id() {
		return friend_id;
	}
	public void setFriend_id(String friend_id) {
		this.friend_id = friend_id;
	}	
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
}