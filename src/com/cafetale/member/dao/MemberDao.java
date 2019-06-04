package com.cafetale.member.dao;

import java.util.List;
import java.util.Map;

import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.member.model.FollowDto;
import com.cafetale.member.model.MemberDetailDto;

public interface MemberDao {
	void register(MemberDetailDto dto);
	void updateImage(Map<String, Object> map);
	String idCheck(String id);
	MemberDetailDto login(Map<String, String> map);
	String modifyCheck(Map<String, String> map);
	void modify(MemberDetailDto memberDetailDto);
	void modifyDetail(MemberDetailDto memberDetailDto);
	void addFollow(Map<String, String> map);
	void followCancel(Map<String, String> map);
	//List<FollowDto> newFollower(Map<String, String> map);
	List<FollowDto> following(Map<String, String> map);
	List<FollowDto> follower(Map<String, String> map);
	List<FollowDto> memberSearch(Map<String, String> map);
	String getUserImage(Map<String, String> map);
	List<FollowDto> friend(Map<String, String> map);
	
	List<CafeDetailDto> memberGoodCafe(Map<String, String> map);
	MemberDetailDto getMemberInfo(Map<String, String> map);
	void registerRpCafe(Map<String, String> map);
}