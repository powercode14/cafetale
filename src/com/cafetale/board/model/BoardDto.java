package com.cafetale.board.model;

public class BoardDto {
	private String idx;
	private String parent_idx;
	private String title;
	private String content;
	private String writer_id;
	private String write_date;
	private String hit_count;
	private String cafe_title;
	private String cafe_id;
	private String reply_cnt;
	private String good;
	private String bad;
	private String boardPage;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getParent_idx() {
		return parent_idx;
	}
	public void setParent_idx(String parent_idx) {
		this.parent_idx = parent_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getHit_count() {
		return hit_count;
	}
	public void setHit_count(String hit_count) {
		this.hit_count = hit_count;
	}
	public String getCafe_title() {
		return cafe_title;
	}
	public void setCafe_title(String cafe_title) {
		this.cafe_title = cafe_title;
	}
	public String getCafe_id() {
		return cafe_id;
	}
	public void setCafe_id(String cafe_id) {
		this.cafe_id = cafe_id;
	}
	public String getReply_cnt() {
		return reply_cnt;
	}
	public void setReply_cnt(String reply_cnt) {
		this.reply_cnt = reply_cnt;
	}
	public String getGood() {
		return good;
	}
	public void setGood(String good) {
		this.good = good;
	}
	public String getBad() {
		return bad;
	}
	public void setBad(String bad) {
		this.bad = bad;
	}
	public String getBoardPage() {
		return boardPage;
	}
	public void setBoardPage(String boardPage) {
		this.boardPage = boardPage;
	}
	@Override
	public String toString() {
		return "BoardDto [idx=" + idx + ", parent_idx=" + parent_idx + ", title=" + title + ", content=" + content
				+ ", writer_id=" + writer_id + ", write_date=" + write_date + ", hit_count=" + hit_count
				+ ", cafe_title=" + cafe_title + ", cafe_id=" + cafe_id + ", reply_cnt=" + reply_cnt + ", good=" + good
				+ ", bad=" + bad + ", boardPage=" + boardPage + "]";
	}
}
