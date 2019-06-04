package com.cafetale.member.controller;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.member.model.FollowDto;
import com.cafetale.member.model.MemberDetailDto;
import com.cafetale.member.service.MemberService;
import com.cafetale.util.Page;

@Controller
@SessionAttributes("loginUserInfo")
public class MemberController {
	private MemberService memberService;
	
	public void setMemberService(MemberService memberService){
		this.memberService = memberService;
	}
	
	@RequestMapping(value="/register.cafetale", method=RequestMethod.POST)
	public ModelAndView register(MemberDetailDto dto){
		memberService.register(dto);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/common/redirect");
		mav.addObject("page", dto.getPage());
		mav.addObject("msg", dto.getMember_name() + "(" + dto.getMember_id() + ")님의 회원가입을 환영합니다!");
		return mav;
	}
	
	@RequestMapping(value="/register.cafetale", method=RequestMethod.GET)
	public String register(@RequestParam("page") String page){
		return "redirect:" + Page.getCurrentPage(page);
	}	

	@RequestMapping("/idcheck.cafetale")
	public @ResponseBody String idCheck(@RequestParam("id") String id){
		return memberService.idCheck(id);
	}
	
	@RequestMapping(value="/login.cafetale", method=RequestMethod.GET)
	public String login(@RequestParam("page") String page){
		return "redirect:" + Page.getCurrentPage(page);
	}

	@RequestMapping(value="/login.cafetale", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> map){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/common/redirect");
		mav.addObject("page", map.get("page"));
		MemberDetailDto loginUserInfo = memberService.login(map);
		if(loginUserInfo != null){
			mav.addObject("loginUserInfo", loginUserInfo);
		} else {
			mav.addObject("msg", "아이디 또는 비밀번호가 틀렸습니다.");
		}
		return mav;
	}
	
	@RequestMapping("/logout.cafetale")
	public String logout(@RequestParam("page") String page, SessionStatus session){
		session.setComplete();
		return "redirect:" + Page.getCurrentPage(page);
	}
	
	@RequestMapping("/modifyCheck.cafetale")
	public @ResponseBody String modifyCheck(@RequestParam Map<String, String> map){
		return memberService.modifyCheck(map);
	}
	
	@RequestMapping(value="/modify.cafetale", method=RequestMethod.GET)
	public String modify(@RequestParam("page") String page){
		return "redirect:" + Page.getCurrentPage(page);
	}
	
	@RequestMapping(value="/modify.cafetale", method=RequestMethod.POST)
	public ModelAndView modify(MemberDetailDto memberDetailDto){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/common/redirect");
		mav.addObject("page", memberDetailDto.getPage());
		memberService.modify(memberDetailDto);
		mav.addObject("msg", memberDetailDto.getMember_id() + "님의 회원정보가 정상적으로 수정되었습니다.");
		mav.addObject("loginUserInfo", memberDetailDto);
		return mav;
	}
	
	@RequestMapping("/addfollow.cafetale")
	public @ResponseBody void addFollow(@RequestParam Map<String, String> map){
		memberService.addFollow(map);
	}
	
	@RequestMapping("/followcancel.cafetale")
	public @ResponseBody void followCancel(@RequestParam Map<String, String> map){
		memberService.followCancel(map);
	}
	
	@RequestMapping("/friend.cafetale")
	public @ResponseBody String friend(@RequestParam Map<String, String> map) {
		List<FollowDto> followingList = memberService.friend(map);
		JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		for(FollowDto dto : followingList){
			JSONObject job = new JSONObject();
			job.put("member_id", dto.getMember_id());
			job.put("member_name", dto.getMember_name());
			jarr.add(job);
		}
		json.put("friendList", jarr);
		return json.toJSONString();
	}
	
	@RequestMapping(value="/following.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String following(@RequestParam Map<String, String> map){
		List<FollowDto> followingList = memberService.following(map);
		JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		for(FollowDto dto : followingList){
			JSONObject job = new JSONObject();
			job.put("member_id", dto.getMember_id());
			job.put("member_name", dto.getMember_name());
			job.put("f_date", dto.getF_date());
			job.put("state", dto.getState());
			jarr.add(job);
		}
		json.put("followingList", jarr);
		return json.toJSONString();
	}

	@RequestMapping(value="/memberSearch.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String memberSearch(@RequestParam Map<String, String> map){
		List<FollowDto> memberSearchList = memberService.memberSearch(map);
		JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		for(FollowDto dto : memberSearchList){
			JSONObject job = new JSONObject();
			job.put("member_id", dto.getMember_id());
			job.put("member_name", dto.getMember_name());
			job.put("state", dto.getState());
			jarr.add(job);
		}
		json.put("memberSearchList", jarr);
		return json.toJSONString();
	}
	
	@RequestMapping("/getUserImage.cafetale")
	public @ResponseBody byte[] getUserImage(@RequestParam Map<String, String> map) {		
		return memberService.getUserImage(map);
	}
	
	@RequestMapping(value="/getMemberDetailInfo.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getMemberDetailInfo(@RequestParam Map<String, String> map){
		List<FollowDto> followingList = memberService.following(map);
		JSONObject json = new JSONObject();
		json.put("member_name", memberService.getMemberInfo(map).getMember_name());
		json.put("member_cafe_id", memberService.getMemberInfo(map).getMember_cafe_id());
		json.put("member_rpCafe", memberService.getMemberInfo(map).getMember_cafe_title());
		JSONArray jarr = new JSONArray();
		for(FollowDto dto : followingList){
			JSONObject job = new JSONObject();
			job.put("member_id", dto.getMember_id());
			job.put("member_name", dto.getMember_name());
			job.put("f_date", dto.getF_date());
			job.put("state", dto.getState());
			jarr.add(job);
		}
		json.put("followingList", jarr);
		List<CafeDetailDto> goodCafeList = memberService.memberGoodCafe(map);
		jarr = new JSONArray();
		for(CafeDetailDto dto : goodCafeList){
			//g.cafe_id, cafe_title, cafe_newAddress, cafe_zipcode, cafe_phone, cafe_image, cafe_graderate, cafe_good
			JSONObject job = new JSONObject();
			job.put("id", dto.getCafe_id());
			job.put("title", dto.getCafe_title());
			job.put("newAddress", dto.getCafe_newAddress());
			job.put("zipcode", dto.getCafe_zipcode());
			job.put("phone", dto.getCafe_phone());
			job.put("image", dto.getCafe_image());
			job.put("graderate", dto.getCafe_graderate());
			job.put("good", dto.getCafe_good());
			jarr.add(job);
		}
		json.put("goodCafeList", jarr);
		return json.toJSONString();
	}
	
	@RequestMapping("/registerRpCafe.cafetale")
	public @ResponseBody void registerRpCafe(@RequestParam Map<String, String> map){
		memberService.registerRpCafe(map);
	}
}