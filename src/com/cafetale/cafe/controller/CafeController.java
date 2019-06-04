package com.cafetale.cafe.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.cafetale.cafe.model.CafeDetailDto;
import com.cafetale.cafe.service.CafeService;

@Controller
@SessionAttributes("loginUserInfo")
public class CafeController {
	private CafeService cafeService;
	
	public void setCafeService(CafeService cafeService){
		this.cafeService = cafeService;
	}
	
	@RequestMapping("/cafeSearch.cafetale")
	public ModelAndView cafeSearch(@RequestParam("keyword")String keyword){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/cafe/cafelist");
		return mav;
	}
	
	@RequestMapping(value="/inputCafeInfo.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String inputCafeInfo(@RequestBody List<Map<String, String>> list){
		List<CafeDetailDto> cafeDetailDtoList = new ArrayList<CafeDetailDto>();
		for(Map<String, String> m : list){
			CafeDetailDto dto = new CafeDetailDto();
			dto.setCafe_id(m.get("id"));
			dto.setCafe_title(m.get("title"));
			dto.setCafe_newAddress(m.get("newAddress"));
			dto.setCafe_zipcode(m.get("zipcode"));
			dto.setCafe_phone(m.get("phone"));
			dto.setCafe_image(m.get("imageUrl"));
			dto.setLatitude(m.get("latitude"));
			dto.setLongitude(m.get("longitude"));
			cafeDetailDtoList.add(dto);
		}
		cafeDetailDtoList = cafeService.insertCafe(cafeDetailDtoList);
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(CafeDetailDto cafeDetailDto : cafeDetailDtoList){
			JSONObject j = new JSONObject();
			j.put("id", cafeDetailDto.getCafe_id());
			j.put("title", cafeDetailDto.getCafe_title());
			j.put("phone", cafeDetailDto.getCafe_phone());
			j.put("newAddress", cafeDetailDto.getCafe_newAddress());
			j.put("zipcode", cafeDetailDto.getCafe_zipcode());
			j.put("grade", cafeDetailDto.getCafe_graderate());
			j.put("good", cafeDetailDto.getCafe_good());
			j.put("image", cafeDetailDto.getCafe_image());
			j.put("latitude", cafeDetailDto.getLatitude());
			j.put("longitude", cafeDetailDto.getLongitude());
			jarray.add(j);
		}
		jobj.put("cafeInfoList", jarray);
		return jobj.toJSONString();
	}
	
	@RequestMapping(value="/getCafeInfoList.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getCafeInfoList(@RequestParam("searchKeyword") String searchKeyword){
		//List<CafeDetailDto> cafeDetailDtoList = cafeService.insertCafe(searchKeyword);
		JSONObject jobj = new JSONObject();
		/*JSONArray jarray = new JSONArray();
		for(CafeDetailDto cafeDetailDto : cafeDetailDtoList){
			JSONObject j = new JSONObject();
			j.put("id", cafeDetailDto.getCafe_id());
			j.put("title", cafeDetailDto.getCafe_title());
			j.put("phone", cafeDetailDto.getCafe_phone());
			j.put("newAddress", cafeDetailDto.getCafe_newAddress());
			j.put("zipcode", cafeDetailDto.getCafe_zipcode());
			j.put("grade", cafeDetailDto.getCafe_graderate());
			j.put("good", cafeDetailDto.getCafe_good());
			j.put("image", cafeDetailDto.getCafe_image());
			jarray.add(j);
		}
		jobj.put("cafeInfoList", jarray);*/
		return jobj.toJSONString();
	}
	
	@RequestMapping("/toggleGood.cafetale")
	public @ResponseBody String toggleGood(@RequestParam Map<String, String> map){
		return cafeService.toggleGood(map);
	}
	
	@RequestMapping("/initGood.cafetale")
	public @ResponseBody String initGood(@RequestParam Map<String, String> map){
		return cafeService.goodCheck(map);
	}
	
	@RequestMapping("/initCafeGrade.cafetale")
	public @ResponseBody String initCafeGrade(@RequestParam Map<String, String> map){
		return cafeService.cafeGradeCheck(map);
	}
	
	@RequestMapping("/initGradeRating.cafetale")
	public @ResponseBody String initGradeRating(@RequestParam Map<String, String> map){
		return cafeService.myRatingCheck(map);
	}
	
	@RequestMapping("/deleteMyRating.cafetale")
	public @ResponseBody void deleteMyRating(@RequestParam Map<String, String> map) {
		cafeService.deleteMyRating(map);
	}
	
	@RequestMapping("/rating.cafetale")
	public @ResponseBody void rating(@RequestParam Map<String, String> map) {
		cafeService.rating(map);
	}
	
	@RequestMapping(value="/getCafeList.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getCafeList(@RequestParam Map<String, String> map) {
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(CafeDetailDto dto : cafeService.getCafeList(map)){
			JSONObject j = new JSONObject();
			j.put("id", dto.getCafe_id());
			j.put("title", dto.getCafe_title());
			j.put("newAddress", dto.getCafe_newAddress());
			j.put("zipcode", dto.getCafe_zipcode());
			j.put("phone", dto.getCafe_phone());
			j.put("image", dto.getCafe_image());
			j.put("graderate", dto.getCafe_graderate());
			j.put("good", dto.getCafe_good());
			jarray.add(j);
		}
		jobj.put("myCafeList", jarray);
		return jobj.toJSONString();
	}
	
	@RequestMapping(value="/getRcCafeList.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getRcCafeList(@RequestParam Map<String, String> map) {
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(CafeDetailDto dto : cafeService.getRcCafeList(map)){
			JSONObject j = new JSONObject();
			j.put("id", dto.getCafe_id());
			j.put("title", dto.getCafe_title());
			j.put("newAddress", dto.getCafe_newAddress());
			j.put("zipcode", dto.getCafe_zipcode());
			j.put("phone", dto.getCafe_phone());
			j.put("image", dto.getCafe_image());
			j.put("graderate", dto.getCafe_graderate());
			j.put("good", dto.getCafe_good());
			
			j.put("rcDate", dto.getRc_date());
			j.put("memberId", dto.getMember_id());
			j.put("friendId", dto.getFriend_id());
			j.put("message", dto.getMessage());
			jarray.add(j);
		}
		jobj.put("rcCafeList", jarray);
		return jobj.toJSONString();
	}

	@RequestMapping("/updateMemo.cafetale")
	public @ResponseBody void updateMemo(@RequestParam Map<String, String> map){
		cafeService.updateMemo(map);
	}
	
	@RequestMapping("/cafeRecoomend.cafetale")
	public @ResponseBody void cafeRecommend(@RequestParam Map<String, String> map){
		cafeService.cafeRecommend(map);
	}
	
	@RequestMapping("/getCafeImage.cafetale")
	public @ResponseBody byte[] getCafeImage(@RequestParam Map<String, String> map) {
		return cafeService.getCafeImage(map);
	}
	@RequestMapping("/removeRcCafe.cafetale")
	public @ResponseBody void removeRcCafe(@RequestParam Map<String, String> map){
		cafeService.removeRcCafe(map);
	}
}