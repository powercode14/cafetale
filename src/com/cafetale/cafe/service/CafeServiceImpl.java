package com.cafetale.cafe.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.cafetale.cafe.dao.CafeDao;
import com.cafetale.cafe.model.CafeDetailDto;

@Service
public class CafeServiceImpl implements CafeService{
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	@Override
	public List<CafeDetailDto> insertCafe(List<CafeDetailDto> list) {
		for(int i=0; i<list.size(); i++){
			String latitude = list.get(i).getLatitude(), longitude = list.get(i).getLongitude();
			if(cafeCheck(list.get(i).getCafe_id()) == null){
				sqlSession.getMapper(CafeDao.class).insertCafe(list.get(i));
			}
			list.set(i, cafeCheck(list.get(i).getCafe_id()));
			list.get(i).setLatitude(latitude);
			list.get(i).setLongitude(longitude);
		}
		return list;
	}
	
	public CafeDetailDto cafeCheck(String cafeId){
		return sqlSession.getMapper(CafeDao.class).cafeCheck(cafeId);
	}

	@Override
	public String toggleGood(Map<String, String> map) {
		CafeDao cafeDao = sqlSession.getMapper(CafeDao.class);
		String result = goodCheck(map);
		if("0".equals(result)){
			cafeDao.goodPlus(map);
			cafeDao.insertGood(map);
			result = "1";
		} else {
			cafeDao.goodMinus(map);
			cafeDao.deleteGood(map);
			result = "-1";
		}
		return result;
	}
	
	@Override
	public String goodCheck(Map<String, String> map) {
		return sqlSession.getMapper(CafeDao.class).goodCheck(map);
	}

	@Override
	public String cafeGradeCheck(Map<String, String> map) {
		return sqlSession.getMapper(CafeDao.class).cafeGradeCheck(map);
	}

	@Override
	public String myRatingCheck(Map<String, String> map) {
		return sqlSession.getMapper(CafeDao.class).myRatingCheck(map);
	}

	@Override
	public void deleteMyRating(Map<String, String> map) {
		sqlSession.getMapper(CafeDao.class).deleteMyRating(map);
		sqlSession.getMapper(CafeDao.class).updateCafeGrade(map);
	}

	@Override
	public void rating(Map<String, String> map) {
		sqlSession.getMapper(CafeDao.class).rating(map);
		sqlSession.getMapper(CafeDao.class).updateCafeGrade(map);
	}

	@Override
	public List<CafeDetailDto> getCafeList(Map<String, String> map) {
		return sqlSession.getMapper(CafeDao.class).getCafeList(map);
	}

	@Override
	public List<CafeDetailDto> getRcCafeList(Map<String, String> map) {
		return sqlSession.getMapper(CafeDao.class).getRcCafeList(map);
	}

	@Override
	public void updateMemo(Map<String, String> map) {
		sqlSession.getMapper(CafeDao.class).updateMemo(map);
	}

	@Override
	public void cafeRecommend(Map<String, String> map) {
		sqlSession.getMapper(CafeDao.class).cafeRecommend(map);
	}
	
	@Override
	public byte[] getCafeImage(Map<String, String> map) {
		byte[] bArray = null;
		try {
			bArray = FileUtils.readFileToByteArray(new File(sqlSession.getMapper(CafeDao.class).getCafeImage(map)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bArray;
	}

	@Override
	public void removeRcCafe(Map<String, String> map) {
		sqlSession.getMapper(CafeDao.class).removeRcCafe(map);
	}

}
