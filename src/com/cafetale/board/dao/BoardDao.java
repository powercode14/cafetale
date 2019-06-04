package com.cafetale.board.dao;

import java.util.List;
import java.util.Map;

import com.cafetale.board.model.BoardDto;
import com.cafetale.board.model.ImageFileDto;
import com.cafetale.cafe.model.CafeDetailDto;

public interface BoardDao {
	List<BoardDto> initBoard(Map<String, String> map);
	String addBoard(Map<String, String> map);
	List<CafeDetailDto> getMemberCafeInfo(Map<String, String> map);
	void insertFile(ImageFileDto dto);
	void deleteFile(String deleteFileName);
	void registerArticle(BoardDto dto);
	void modifyArticle(BoardDto dto);
	void removeBoard(Map<String, String> map);
	void removeBoardFile(Map<String, String> map);
	void saveFile(ImageFileDto dto);
	void insertReply(Map<String, String> map);
	List<BoardDto> initReply(Map<String, String> map);
	void modifyReply(Map<String, String> map);
	void deleteReply(Map<String, String> map);
	String articleGoodCheck(Map<String, String> map);
	void insertArticleGood(Map<String, String> map);
	void deleteArticleGood(Map<String, String> map);
	String articleBadCheck(Map<String, String> map);
	void insertArticleBad(Map<String, String> map);
	void deleteArticleBad(Map<String, String> map);
	String fileCheck(String sfd);
	List<BoardDto> popularArticle();
	void hitBoard(String boardIdx);
	String boardCount();
}
