package com.mkcompany.controller;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UploadController {

	@Resource(name = "uploadPath")
	String uploadPath;
	
	//업로드 흐름 : 업로드 클릭 -> 임시디렉토리 업로드 -> 지정된 디렉토리 저장 -> 파일정보가 file에 저장
	@RequestMapping(value="/upload/uploadForm", method = RequestMethod.GET)
	public void uploadForm() {
//		return "/upload/uploadForm";
	}
	
	@RequestMapping(value="/upload/uploadForm", method = RequestMethod.POST)
	public ModelAndView uploadForm(MultipartFile file, ModelAndView mav) throws Exception{
		//파일 원본 이름 저장
		String savedName = file.getOriginalFilename();
		savedName = uploadFile(savedName, file.getBytes());
		System.out.println("#######################");
		mav.setViewName("upload/uploadResult"); //uploadResult.jsp로
		mav.addObject("savedName", savedName); 
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@");
		return mav; 
		
	}
	//파일명 랜덤 생성 메소드
	public String uploadFile(String originalName, byte[] fileData) throws Exception{
		//uuid 생성
		System.out.println("$$$$$$$$$$$$$$$$$$$$$");
		UUID uuid = UUID.randomUUID();
		//랜덤생성 + 파일 이름 저장
		String savedName = uuid.toString()+"_"+originalName;
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&");
		File target = new File(uploadPath, savedName);
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%");
		//임시디렉토리에 저장된 업로드 파일을 지정된 디렉토리로 복사
		//FileCopyUtils.copy(바이트배열, 파일객체);
		FileCopyUtils.copy(fileData, target);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!");
		return savedName;
	}
	
	
}