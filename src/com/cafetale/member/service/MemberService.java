package com.cafetale.member.service;

import java.util.List;
import java.util.Map;

import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.member.model.FollowDto;
import com.cafetale.member.model.MemberDetailDto;

public interface MemberService {
	void register(MemberDetailDto dto);
	String idCheck(String id);
	MemberDetailDto login(Map<String, String> map);
	String modifyCheck(Map<String, String> map);
	void modify(MemberDetailDto memberDetailDto);
	void addFollow(Map<String, String> map);
	void followCancel(Map<String, String> map);
	//List<FollowDto> newFollower(Map<String, String> map);
	List<FollowDto> following(Map<String, String> map);
	List<FollowDto> memberSearch(Map<String, String> map);
	byte[] getUserImage(Map<String, String> map);
	List<FollowDto> friend(Map<String, String> map);
	
	List<CafeDetailDto> memberGoodCafe(Map<String, String> map);
	MemberDetailDto getMemberInfo(Map<String, String> map);
	void registerRpCafe(Map<String, String> map);
}
