package com.cafetale.member.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.member.dao.MemberDao;
import com.cafetale.member.model.FollowDto;
import com.cafetale.member.model.MemberDetailDto;

@Service
public class MemberServiceImpl implements MemberService{
	private SqlSession sqlSession;
	private String uploadDirectory;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	public void setUploadDirectory(String uploadDirectory){
		this.uploadDirectory = uploadDirectory;
	}

	@Override
	public void register(MemberDetailDto dto) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		if(dto.getMember_gender() == null || dto.getMember_gender().equals("")){
			dto.setMember_gender("");
		}
		imageConvert(dto);
		memberDao.register(dto);
	}
	
	private void imageConvert(MemberDetailDto dto){
		MultipartFile imageMf = dto.getRegister_img();
		String fileName = "";
		try {
			if(imageMf != null){
				fileName = imageMf.getOriginalFilename();
				File imgFile = new File(uploadDirectory, fileName);
				if(!imgFile.exists()){ //파일이 존재하지않으면
					imageMf.transferTo(imgFile);
					System.out.println(imageMf.getOriginalFilename());
					dto.setMember_image(uploadDirectory + fileName);
				} else { //파일이 존재하면
					dto.setMember_image(uploadDirectory + fileName);
				}
			}
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String idCheck(String id) {
		return sqlSession.getMapper(MemberDao.class).idCheck(id);
	}

	@Override
	public MemberDetailDto login(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).login(map);
	}
	
	@Override
	public String modifyCheck(Map<String, String> map){
		return sqlSession.getMapper(MemberDao.class).modifyCheck(map);
	}
	
	@Override
	public void modify(MemberDetailDto dto) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		memberDao.modify(dto);
		if(dto.getMember_gender() == null || dto.getMember_gender().equals("")){
			dto.setMember_gender("");
		}
		imageConvert(dto);
		memberDao.modifyDetail(dto);
	}

	@Override
	public void addFollow(Map<String, String> map) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		memberDao.addFollow(map);
	}
	
	@Override
	public void followCancel(Map<String, String> map) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		memberDao.followCancel(map);		
	}

	@Override
	public List<FollowDto> following(Map<String, String> map) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		List<FollowDto> followingList = memberDao.following(map);
		List<FollowDto> followerList = memberDao.follower(map);
		List<FollowDto> resultList = new ArrayList<FollowDto>();
		
		if(followingList.size() == 0){
			for(int i=0; i<followerList.size(); i++) {
				followerList.get(i).setState("follower");
				resultList.add(followerList.get(i));
			}
		} else if(followerList.size() == 0){
			for(int i=0; i<followingList.size(); i++) {
				followingList.get(i).setState("following");
				resultList.add(followingList.get(i));
			}
		} else {
			for(int i=0; i<followingList.size(); i++){
				for(int j=0; j<followerList.size(); j++){
					if(followingList.get(i).getMember_id().equals(followerList.get(j).getMember_id())){
						followingList.get(i).setState("friend");
						resultList.add(followingList.get(i));
						break;
					} else if(j == followerList.size()-1) {
						followingList.get(i).setState("following");
						resultList.add(followingList.get(i));
					}
				}
			}
			for(int i=0; i<followerList.size(); i++){
				for(int j=0; j<resultList.size(); j++){
					if(followerList.get(i).getMember_id().equals(resultList.get(j).getMember_id())){
						break;
					} else if(j == resultList.size()-1) {
						followerList.get(i).setState("follower");
						resultList.add(followerList.get(i));
					}
				}
			}
		}
		if(resultList.size() > 1){
			Collections.sort(resultList, new FDateDescCompare());
		}
		
		return resultList;
	}
	
	@Override
	public List<FollowDto> memberSearch(Map<String, String> map) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		List<FollowDto> searchList = memberDao.memberSearch(map);
		List<FollowDto> followingList = memberDao.following(map);
		List<FollowDto> followerList = memberDao.follower(map);
		List<FollowDto> resultList = new ArrayList<FollowDto>();
		
		if(followingList.size() == 0){
			for(int i=0; i<followerList.size(); i++) {
				followerList.get(i).setState("follower");
				resultList.add(followerList.get(i));
			}
		} else if(followerList.size() == 0){
			for(int i=0; i<followingList.size(); i++) {
				followingList.get(i).setState("following");
				resultList.add(followingList.get(i));
			}
		} else {
			for(int i=0; i<followingList.size(); i++){
				for(int j=0; j<followerList.size(); j++){
					if(followingList.get(i).getMember_id().equals(followerList.get(j).getMember_id())){
						followingList.get(i).setState("friend");
						resultList.add(followingList.get(i));
						break;
					} else if(j == followerList.size()-1) {
						followingList.get(i).setState("following");
						resultList.add(followingList.get(i));
					}
				}
			}
			for(int i=0; i<followerList.size(); i++){
				for(int j=0; j<resultList.size(); j++){
					if(followerList.get(i).getMember_id().equals(resultList.get(j).getMember_id())){
						break;
					} else if(j == resultList.size()-1) {
						followerList.get(i).setState("follower");
						resultList.add(followerList.get(i));
					}
				}
			}
		}
		for(int i=0; i<searchList.size(); i++){
			for(int j=0; j<resultList.size(); j++){
				if(searchList.get(i).getMember_id().equals(resultList.get(j).getMember_id())){
					searchList.get(i).setState(resultList.get(j).getState());
				}
			}
		}
		
		return searchList;
	}

	@Override
	public byte[] getUserImage(Map<String, String> map) {
		byte[] bArray = null;
		try {
			bArray = FileUtils.readFileToByteArray(new File(sqlSession.getMapper(MemberDao.class).getUserImage(map)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bArray;
	}
	
	class FDateDescCompare implements Comparator<FollowDto> {
		@Override
		public int compare(FollowDto o1, FollowDto o2) {
			return o2.getF_date().compareTo(o1.getF_date());
		}
	}

	@Override
	public List<FollowDto> friend(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).friend(map);
	}

	@Override
	public List<CafeDetailDto> memberGoodCafe(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).memberGoodCafe(map);
	}

	@Override
	public MemberDetailDto getMemberInfo(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).getMemberInfo(map);
	}

	@Override
	public void registerRpCafe(Map<String, String> map) {
		sqlSession.getMapper(MemberDao.class).registerRpCafe(map);	
	}
}
