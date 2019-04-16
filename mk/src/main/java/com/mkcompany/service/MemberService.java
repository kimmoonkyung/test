package com.mkcompany.service;

import java.util.List;

import com.mkcompany.dto.MemberVo;

public interface MemberService {

	//main.jsp에서 사용 할 멤버목록
	public List<MemberVo> memberList(int start, int end, String searchOption, String keyword); 
	//레코드 갯수
	public int countArticle(String searchOption, String keyword); 
	
	//reg.jsp에서 사용 할 멤버 등록
	public void insertMember(MemberVo vo);
	//public int juminChk(String useJumin); //주민번호 중복 확인
	public int juminChk(String jumin1, String jumin2);
	
	//멤버 정보 보기(수정)
	public MemberVo viewMember(int memNo);
	//멤버 수정
	public void updateMember(MemberVo vo);
	
	//main.jsp에서 사용 할 멤버 삭제
	public void deleteMember(int memNo);
	public void deleteMember2(List<String> list);
	
}

