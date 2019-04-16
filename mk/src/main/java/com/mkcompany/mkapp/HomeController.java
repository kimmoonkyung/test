package com.mkcompany.mkapp;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mkcompany.dto.MemberVo;
import com.mkcompany.service.MemberPager;
import com.mkcompany.service.MemberService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	MemberService memberService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {return "index";}
	@RequestMapping("/left")
	public String left() {return "left";}
	
	@RequestMapping("/main")
	public ModelAndView list(@RequestParam(defaultValue = "all") String searchOption,
							@RequestParam(defaultValue = "") String keyword,
							@RequestParam(defaultValue = "1") int curPage) {
		
		// 레코드 갯수 계산
		int count = memberService.countArticle(searchOption, keyword);
		
		ModelAndView mav = new ModelAndView();
		
		//페이지 나누기 관련 처리
		MemberPager memberPager = new MemberPager(count, curPage);
		int start = memberPager.getPageBegin();
		int end = memberPager.getPageEnd();
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@ " + start);
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@ " + end);
		
		List<MemberVo> list = memberService.memberList(start, end, searchOption, keyword);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list); // 멤버 목록
		map.put("count", count); // 레코드 갯수
		map.put("searchOption", searchOption); //검색옵션
		map.put("keyword", keyword); //검색키워드
		map.put("memberPager", memberPager); //페이저
		
		mav.addObject("map", map); // 맵에 저장된 데이터 mav에 저장
		mav.setViewName("main"); // 뷰 설정
		
		return mav; 
	}
	
	@GetMapping("/reg")
	public String reg() {
		return "reg";
	}
	@Resource(name = "uploadPath")
	String uploadPath;
	@PostMapping("reg")
	public ModelAndView reg(MultipartFile file, ModelAndView mav,
							String address1, String address2,
							MemberVo member) throws Exception{
		
		String savedName = file.getOriginalFilename();
		File target = new File(uploadPath, savedName);
		
		FileCopyUtils.copy(file.getBytes(), target);
		mav.setViewName("index");
		//mav.addObject("savedName", savedName);
		member.setImage(savedName);
		
		String address = address1 + " " + address2;
		member.setAddress(address);
		memberService.insertMember(member);
		
		return mav;
		
	}
	//주민등록 중복체크
	@RequestMapping("/reg/juminChk")
	@ResponseBody
	public String juminChk(@RequestBody String jumin) {

		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(jumin);
		String jumin1 = jsonObject.get("jumin1").getAsString();
		String jumin2 = jsonObject.get("jumin2").getAsString();
		
		String str = "";
		
		int count = memberService.juminChk(jumin1, jumin2);
		//System.out.println(count + "###############");
		if(count >= 1) { // 1이상 이면 중복된다는것
			str = "NO";
		} else if(count == 0) { // 0이 나오면 중복x 사용가능
			str = "YES";
		}
		//System.out.println(str + "%%%%%%%");
		return str; //jsp로 리턴값 보냄
	}
	
	//멤버 보기(수정) view + edit
	@RequestMapping(value="view", method = RequestMethod.GET)
	public ModelAndView view(@RequestParam int memNo,
							@RequestParam int curPage, @RequestParam String searchOption,
							@RequestParam String keyword ) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("view");
		mav.addObject("dto", memberService.viewMember(memNo));
		mav.addObject("curPage", curPage);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);
		
		return mav;
	}
	//수정
	@RequestMapping("edit")
	public String edit(MultipartFile file, 
							String address1, String address2, String imageName,
							@RequestParam int memNo,
							@ModelAttribute MemberVo member) throws Exception{
		
		String savedName = file.getOriginalFilename();

		if(savedName == "") {//( 정보 수정때 사진을 수정하지 않았다면 / 파일이 업로드 되지 않았다면)
			member.setImage(imageName); // 기존의 멤버 이미지명을 불러와서 set함
			//System.out.println(member.getImage() + "&&&&&&&&&&");
		} else { // 파일명이 null이 아니라면 ( 사진 수정을 했다면 )
			//랜덤 생성 + 파일이름 저장
			//파일명 랜덤생성 메소드 호출
			savedName = uploadFile(savedName, file.getBytes());
			member.setImage(savedName);
		}
		
		String address = address1 + " " + address2;
		member.setAddress(address);
		memberService.updateMember(member);
		
		return "index";
		
	}
	//파일명 랜덤 생성 메소드
	public String uploadFile(String originalName, byte[] fileData) throws Exception{
		//uuid 생성
		UUID uuid = UUID.randomUUID();
		//랜덤생성 + 파일 이름 저장
		String savedName = uuid.toString()+"_"+originalName;
		File target = new File(uploadPath, savedName);
		//임시디렉토리에 저장된 업로드 파일을 지정된 디렉토리로 복사
		//FileCopyUtils.copy(바이트배열, 파일객체);
		FileCopyUtils.copy(fileData, target);

		return savedName;
	}
	
	@RequestMapping("delete2")
	@ResponseBody
	public void delete2(@RequestBody String a) throws JsonParseException, JsonMappingException, IOException {
		System.out.println(a);
		Map<String, Object> map = new HashMap<String, Object>();
		
		ObjectMapper om = new ObjectMapper();
		
		map = om.readValue(a, new TypeReference<Map<String, String>>() {
		});
		
		List<String> list = new ArrayList<String>();
		
		for (int i = 0; i < map.size(); i++) {
			list.add((String)map.get(""+i+""));
		}
		
		System.out.println(list);
		
		memberService.deleteMember2(list);
	}
	
}

