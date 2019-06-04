package com.cafetale.board.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import com.cafetale.board.dao.BoardDao;
import com.cafetale.board.model.BoardDto;
import com.cafetale.board.model.ImageFileDto;
import com.cafetale.cafe.dao.CafeDao;
import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.util.CreateRandomString;

public class BoardServiceImpl implements BoardService {
	private SqlSession sqlSession;
	
	private String uploadDirectory;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	public void setUploadDirectory(String uploadDirectory) {
		this.uploadDirectory = uploadDirectory;
	}

	@Override
	public List<BoardDto> initBoard(Map<String, String> map) {
		return sqlSession.getMapper(BoardDao.class).initBoard(map);
	}
	
	@Override
	public String addBoard(Map<String, String> map) {
		return sqlSession.getMapper(BoardDao.class).addBoard(map);
	}

	@Override
	public List<CafeDetailDto> getMemberCafeInfo(Map<String, String> map) {
		return sqlSession.getMapper(BoardDao.class).getMemberCafeInfo(map);
	}

	@Override
	public JSONObject getFile(MultipartFile mf) {
		ImageFileDto dto = new ImageFileDto();
		dto.setOriginal_file_name(mf.getOriginalFilename());
		dto.setStored_file_name(CreateRandomString.createRandomString());
		dto.setFile_size(mf.getSize());
		sqlSession.getMapper(BoardDao.class).insertFile(dto);
		
		JSONObject jobj = new JSONObject();
		try {
			File imgFile = new File(uploadDirectory, dto.getStored_file_name());
			mf.transferTo(imgFile);
			jobj.put("url", "/image/board/" + imgFile.getName());
			jobj.put("name", dto.getStored_file_name());
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return jobj;
	}

	@Override
	public void deleteFile(List<String> deleteFileList) {
		for(String deleteFileName : deleteFileList){
			File deleteFile = new File(uploadDirectory + deleteFileName);
			deleteFile.delete();
			sqlSession.getMapper(BoardDao.class).deleteFile(deleteFileName);
		}
	}

	@Override
	public String registerArticle(BoardDto dto, List<String> registerFileList) {
		sqlSession.getMapper(BoardDao.class).registerArticle(dto);
		for(String sfd : registerFileList){
			ImageFileDto ifd = new ImageFileDto();
			ifd.setBoard_idx(dto.getIdx());
			ifd.setStored_file_name(sfd);
			ifd.setUpload_member_id(dto.getWriter_id());
			sqlSession.getMapper(BoardDao.class).saveFile(ifd);
		}
		return boardCount();
	}
	
	private String boardCount(){
		return sqlSession.getMapper(BoardDao.class).boardCount();
	}
	
	@Override
	public void modifyArticle(BoardDto dto, List<String> registerFileList) {
		sqlSession.getMapper(BoardDao.class).modifyArticle(dto);
		for(String sfd : registerFileList){
			if("0".equals(sqlSession.getMapper(BoardDao.class).fileCheck(sfd))){
				ImageFileDto ifd = new ImageFileDto();
				ifd.setBoard_idx(dto.getIdx());
				ifd.setStored_file_name(sfd);
				ifd.setUpload_member_id(dto.getWriter_id());
				sqlSession.getMapper(BoardDao.class).saveFile(ifd);
			}
		}
	}

	@Override
	public void removeArticle(Map<String, String> map) {
		sqlSession.getMapper(BoardDao.class).removeBoard(map);
		sqlSession.getMapper(BoardDao.class).removeBoardFile(map);
	}

	@Override
	public void insertReply(Map<String, String> map) {
		sqlSession.getMapper(BoardDao.class).insertReply(map);
	}

	@Override
	public List<BoardDto> initReply(Map<String, String> map) {
		return sqlSession.getMapper(BoardDao.class).initReply(map);
	}

	@Override
	public void modifyReply(Map<String, String> map) {
		sqlSession.getMapper(BoardDao.class).modifyReply(map);	
	}
	
	@Override
	public void deleteReply(Map<String, String> map) {
		sqlSession.getMapper(BoardDao.class).deleteReply(map);	
	}

	@Override
	public void toggleArticleGood(Map<String, String> map) {
		if("0".equals(sqlSession.getMapper(BoardDao.class).articleGoodCheck(map))){
			sqlSession.getMapper(BoardDao.class).insertArticleGood(map);
		} else {
			sqlSession.getMapper(BoardDao.class).deleteArticleGood(map);
		}
	}
	
	@Override
	public void toggleArticleBad(Map<String, String> map) {
		if("0".equals(sqlSession.getMapper(BoardDao.class).articleBadCheck(map))){
			sqlSession.getMapper(BoardDao.class).insertArticleBad(map);
		} else {
			sqlSession.getMapper(BoardDao.class).deleteArticleBad(map);
		}
	}

	@Override
	public List<BoardDto> popularArticle() {
		return sqlSession.getMapper(BoardDao.class).popularArticle();
	}

	@Override
	public CafeDetailDto getCafeDetailInfo(String cafeId) {
		return sqlSession.getMapper(CafeDao.class).cafeCheck(cafeId);
	}

	@Override
	public void hitBoard(String boardIdx) {
		sqlSession.getMapper(BoardDao.class).hitBoard(boardIdx);
	}
}
