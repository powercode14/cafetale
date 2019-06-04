package com.cafetale.board.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cafetale.board.model.BoardDto;
import com.cafetale.board.service.BoardService;
import com.cafetale.cafe.model.CafeDetailDto;

@Controller
@SessionAttributes("loginUserInfo")
public class BoardController {
	private BoardService boardService;
	
	public void setBoardService(BoardService boardService){
		this.boardService = boardService;
	}
	
	@RequestMapping(value="/moveBoard.cafetale", produces="application/json; charset=UTF-8")
	public ModelAndView moveboard(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/board/board");
		return mav;
	}
	
	@RequestMapping("/writeBoard.cafetale")
	public ModelAndView writeBoard(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/board/board");
		return mav;
	}
	
	@RequestMapping(value="/getMemberCafeInfo.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getMemberCafeInfo(@RequestParam Map<String, String> map){
		List<CafeDetailDto> cafeDetailDtoList = boardService.getMemberCafeInfo(map);
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(CafeDetailDto cafeDetailDto : cafeDetailDtoList){
			JSONObject j = new JSONObject();
			j.put("cafeId", cafeDetailDto.getCafe_id());
			j.put("cafeTitle", cafeDetailDto.getCafe_title());
			jarray.add(j);
		}
		jobj.put("cafeInfoList", jarray);
		return jobj.toJSONString();
	}
	
	@RequestMapping(value="/imageUpload.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String imageUpload(@RequestParam("imageFile") MultipartFile mf){
		return boardService.getFile(mf).toJSONString();
	}
	
	@RequestMapping(value="/registerArticle.cafetale", method=RequestMethod.GET)
	public @ResponseBody String registerArticle(BoardDto dto, @RequestParam("allFileList[]") List<String> allFileList, @RequestParam("registerFileList[]")List<String> registerFileList){
		if(!registerFileList.contains("")){
			List<String> deleteFileList = allFileList;
			for(int i=0; i<deleteFileList.size(); i++){
				for(int j=0; j<registerFileList.size(); j++){
					if(deleteFileList.get(i).equals(registerFileList.get(j))){
						deleteFileList.remove(i);
					}
				}
			}
			boardService.deleteFile(deleteFileList);
		}
		return boardService.registerArticle(dto, registerFileList);
	}
	
	@RequestMapping(value="/modifyArticle.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody void modifyArticle(BoardDto dto, @RequestParam("allFileList[]") List<String> allFileList, @RequestParam("registerFileList[]")List<String> registerFileList){
		if(!registerFileList.contains("")){
			List<String> deleteFileList = allFileList;
			for(int i=0; i<deleteFileList.size(); i++){
				for(int j=0; j<registerFileList.size(); j++){
					if(deleteFileList.get(i).equals(registerFileList.get(j))){
						deleteFileList.remove(i);
					}
				}
			}
			boardService.deleteFile(deleteFileList);
		}
		boardService.modifyArticle(dto, registerFileList);
	}
	
	@RequestMapping("/removeArticle.cafetale")
	public @ResponseBody void removeArticle(@RequestParam Map<String, String> map){
		boardService.removeArticle(map);
	}
	
	@RequestMapping(value="/initBoard.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String initBoard(@RequestParam Map<String, String> map){
		List<BoardDto> dtoList = boardService.initBoard(map);
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto dto : dtoList){
			JSONObject j = new JSONObject();
			j.put("idx", dto.getIdx());
			j.put("title", dto.getTitle());
			j.put("content", dto.getContent());
			j.put("writer_id", dto.getWriter_id());
			j.put("write_date", dto.getWrite_date());
			j.put("good", dto.getGood());
			j.put("bad", dto.getBad());
			j.put("hit_count", dto.getHit_count());
			j.put("cafe_title", dto.getCafe_title());
			j.put("cafe_id", dto.getCafe_id());
			j.put("reply_cnt", dto.getReply_cnt());
			jarray.add(j);
		}
		jobj.put("boardList", jarray);
		return jobj.toJSONString();
	}
	
	/*@RequestMapping(value="/addBoard.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String addBoard(@RequestParam Map<String, String> map){
		String boardCount = boardService.addBoard(map);
		List<BoardDto> dtoList = boardService.addBoard(map);
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto dto : dtoList){
			JSONObject j = new JSONObject();
			j.put("idx", dto.getIdx());
			j.put("title", dto.getTitle());
			j.put("content", dto.getContent());
			j.put("writer_id", dto.getWriter_id());
			j.put("write_date", dto.getWrite_date());
			j.put("good", dto.getGood());
			j.put("bad", dto.getBad());
			j.put("hit_count", dto.getHit_count());
			j.put("cafe_title", dto.getCafe_title());
			j.put("cafe_id", dto.getCafe_id());
			j.put("reply_cnt", dto.getReply_cnt());
			jarray.add(j);
		}
		jobj.put("boardList", jarray);
		return jobj.toJSONString();
	}*/
	
	@RequestMapping(value="/insertReply.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody void insertReply(@RequestParam Map<String, String> map){
		boardService.insertReply(map);
	}
	
	@RequestMapping(value="/initReply.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String initReply(@RequestParam Map<String, String> map){
		List<BoardDto> replyList = boardService.initReply(map);		
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto dto : replyList){
			JSONObject j = new JSONObject();
			j.put("idx", dto.getIdx());
			j.put("parent_idx", dto.getParent_idx());
			j.put("writer_id", dto.getWriter_id());
			j.put("content", dto.getContent());
			j.put("write_date", dto.getWrite_date());
			j.put("good", dto.getGood());
			j.put("bad", dto.getBad());
			jarray.add(j);
		}
		jobj.put("replyList", jarray);
		return jobj.toJSONString();
	}
	
	@RequestMapping("/modifyReply.cafetale")
	public @ResponseBody void modifyReply(@RequestParam Map<String, String> map){
		boardService.modifyReply(map);
	}
	
	@RequestMapping("/deleteReply.cafetale")
	public @ResponseBody void deleteReply(@RequestParam Map<String, String> map){
		boardService.deleteReply(map);
	}
	
	@RequestMapping("/toggleArticleGood.cafetale")
	public @ResponseBody void toggleArticleGood(@RequestParam Map<String, String> map){
		boardService.toggleArticleGood(map);
	}
	
	@RequestMapping("/toggleArticleBad.cafetale")
	public @ResponseBody void toggleArticleBad(@RequestParam Map<String, String> map){
		boardService.toggleArticleBad(map);
	}
	
	@RequestMapping(value="/popularArticle.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String popularArticle(){
		List<BoardDto> popularList = boardService.popularArticle();
		JSONObject jobj = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(BoardDto dto : popularList){
			JSONObject j = new JSONObject();
			j.put("idx", dto.getIdx());
			j.put("cafe_title", dto.getCafe_title());
			j.put("title", dto.getTitle());
			jarray.add(j);
		}
		jobj.put("popularList", jarray);
		return jobj.toJSONString();
	}
	
	@RequestMapping(value="/getCafeDetailInfo.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody String getCafeDetailInfo(@RequestParam("cafeId") String cafeId){
		CafeDetailDto cafeDetailDto = boardService.getCafeDetailInfo(cafeId);
		JSONObject jobj = new JSONObject();
		JSONObject j = new JSONObject();
		j.put("id", cafeDetailDto.getCafe_id());
		j.put("title", cafeDetailDto.getCafe_title());
		j.put("phone", cafeDetailDto.getCafe_phone());
		j.put("newAddress", cafeDetailDto.getCafe_newAddress());
		j.put("zipcode", cafeDetailDto.getCafe_zipcode());
		j.put("grade", cafeDetailDto.getCafe_graderate());
		j.put("good", cafeDetailDto.getCafe_good());
		j.put("image", cafeDetailDto.getCafe_image());
		jobj.put("cafeDetailInfo", j);
		return jobj.toJSONString();
	}
	@RequestMapping("/hitBoard.cafetale")
	public @ResponseBody void hitBoard(@RequestParam("boardIdx") String boardIdx){
		boardService.hitBoard(boardIdx);
	}
	
	@RequestMapping(value="/boardSearch.cafetale", produces="application/json; charset=UTF-8")
	public @ResponseBody void boardSearch(@RequestParam Map<String, String> map){
		//initBoard(map);
		System.out.println(map.get("searchOption"));
		System.out.println(map.get("boardSearchKeyword"));
	}
}