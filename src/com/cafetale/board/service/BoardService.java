package com.cafetale.board.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import com.cafetale.board.model.BoardDto;
import com.cafetale.cafe.model.CafeDetailDto;

public interface BoardService {
	List<CafeDetailDto> getMemberCafeInfo(Map<String, String> map);
	JSONObject getFile(MultipartFile mf);
	void deleteFile(List<String> deleteFileList);
	String registerArticle(BoardDto dto, List<String> registerFileList);
	void modifyArticle(BoardDto dto, List<String> registerFileList);
	void removeArticle(Map<String, String> map);
	List<BoardDto> initBoard(Map<String, String> map);
	//List<BoardDto> addBoard(Map<String, String> map);
	String addBoard(Map<String, String> map);
	void insertReply(Map<String, String> map);
	List<BoardDto> initReply(Map<String, String> map);
	void modifyReply(Map<String, String> map);
	void deleteReply(Map<String, String> map);
	void toggleArticleGood(Map<String, String> map);
	void toggleArticleBad(Map<String, String> map);
	List<BoardDto> popularArticle();
	CafeDetailDto getCafeDetailInfo(String cafeId);
	void hitBoard(String boardIdx);
	
}
