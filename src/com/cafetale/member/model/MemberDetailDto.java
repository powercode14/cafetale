package com.cafetale.member.model;

import org.springframework.web.multipart.MultipartFile;

public class MemberDetailDto extends MemberDto{
	private String member_phone;
	private String member_birth;
	private String member_gender;
	private String member_address1;
	private String member_address2;
	private String member_image;
	private String page;
	private MultipartFile register_img;
	private String f_date;
	private String member_cafe_id;
	private String member_cafe_title;
	
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_address1() {
		return member_address1;
	}
	public void setMember_address1(String member_address1) {
		this.member_address1 = member_address1;
	}
	public String getMember_address2() {
		return member_address2;
	}
	public void setMember_address2(String member_address2) {
		this.member_address2 = member_address2;
	}
	public String getMember_image() {
		return member_image;
	}
	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public MultipartFile getRegister_img() {
		return register_img;
	}
	public void setRegister_img(MultipartFile register_img) {
		this.register_img = register_img;
	}
	public String getF_date() {
		return f_date;
	}
	public void setF_date(String f_date) {
		this.f_date = f_date;
	}
	public String getMember_cafe_id() {
		return member_cafe_id;
	}
	public void setMember_cafe_id(String member_cafe_id) {
		this.member_cafe_id = member_cafe_id;
	}
	public String getMember_cafe_title() {
		return member_cafe_title;
	}
	public void setMember_cafe_title(String member_cafe_title) {
		this.member_cafe_title = member_cafe_title;
	}
	@Override
	public String toString() {
		return "MemberDetailDto [member_phone=" + member_phone + ", member_birth=" + member_birth + ", member_gender="
				+ member_gender + ", member_address1=" + member_address1 + ", member_address2=" + member_address2
				+ ", member_image=" + member_image + ", page=" + page + ", f_date="
				+ f_date + ", member_cafe_id=" + member_cafe_id + ", member_id=" + member_id + ", member_pw="
				+ member_pw + ", member_name=" + member_name + ", member_email=" + member_email + ", member_joindate="
				+ member_joindate + "]";
	}
	
}
