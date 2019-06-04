package com.cafetale.cafe.service;

import java.util.List;
import java.util.Map;

import com.cafetale.cafe.model.CafeDetailDto;

public interface CafeService {
	List<CafeDetailDto> insertCafe(List<CafeDetailDto> dto);
	String toggleGood(Map<String, String> map);
	String goodCheck(Map<String, String> map);
	String cafeGradeCheck(Map<String, String> map);
	String myRatingCheck(Map<String, String> map);
	void deleteMyRating(Map<String, String> map);
	void rating(Map<String, String> map);
	/* 카페관리  */
	List<CafeDetailDto> getCafeList(Map<String, String> map);
	List<CafeDetailDto> getRcCafeList(Map<String, String> map);
	void updateMemo(Map<String, String> map);
	void cafeRecommend(Map<String, String> map);
	
	byte[] getCafeImage(Map<String, String> map);
	void removeRcCafe(Map<String, String> map);
}
