package com.cafetale.board.model;

public class ImageFileDto {
	String board_idx;
	String original_file_name;
	String stored_file_name;
	double file_size;
	String upload_date;
	String upload_member_id;
	String del_flag;
	
	public String getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(String board_idx) {
		this.board_idx = board_idx;
	}
	public String getOriginal_file_name() {
		return original_file_name;
	}
	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}
	public String getStored_file_name() {
		return stored_file_name;
	}
	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}
	public double getFile_size() {
		return file_size;
	}
	public void setFile_size(double l) {
		this.file_size = l;
	}
	public String getUpload_date() {
		return upload_date;
	}
	public void setUpload_date(String upload_date) {
		this.upload_date = upload_date;
	}
	public String getUpload_member_id() {
		return upload_member_id;
	}
	public void setUpload_member_id(String upload_member_id) {
		this.upload_member_id = upload_member_id;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	
	@Override
	public String toString() {
		return "ImageFileDto [board_idx=" + board_idx + ", original_file_name=" + original_file_name
				+ ", stored_file_name=" + stored_file_name + ", file_size=" + file_size + ", upload_date=" + upload_date
				+ ", upload_member_id=" + upload_member_id + ", del_flag=" + del_flag + "]";
	}
}
