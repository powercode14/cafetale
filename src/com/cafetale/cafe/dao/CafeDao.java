package com.cafetale.cafe.dao;

import java.util.List;
import java.util.Map;

import com.cafetale.cafe.model.CafeDetailDto;

public interface CafeDao {
	CafeDetailDto cafeCheck(String cafeId);
	void insertCafe(CafeDetailDto dto);
	String goodCheck(Map<String, String> map);
	void goodPlus(Map<String, String> map);
	void goodMinus(Map<String, String> map);
	void insertGood(Map<String, String> map);
	void deleteGood(Map<String, String> map);
	String cafeGradeCheck(Map<String, String> map);
	String myRatingCheck(Map<String, String> map);
	void deleteMyRating(Map<String, String> map);
	void updateCafeGrade(Map<String, String> map);
	void deleteGrade(Map<String, String> map);
	void rating(Map<String, String> map);
	
	List<CafeDetailDto> getCafeList(Map<String, String> map);
	List<CafeDetailDto> getRcCafeList(Map<String, String> map);
	void updateMemo(Map<String, String> map);
	void cafeRecommend(Map<String, String> map);
	String getCafeImage(Map<String, String> map);
	void removeRcCafe(Map<String, String> map);
}
