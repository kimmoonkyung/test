package com.mkcompany.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mkcompany.dao.MemberDaoImpl;
import com.mkcompany.dto.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDaoImpl memberDao;
	
	@Override
	public List<MemberVo> memberList(int start, int end, String searchOption, String keyword) {
		// TODO Auto-generated method stub
		return memberDao.memberList(start, end, searchOption, keyword);
	}

	@Override
	public void insertMember(MemberVo vo) {
		memberDao.insertMember(vo);
	}
	@Override
	public int juminChk(String jumin1, String jumin2) {
		// TODO Auto-generated method stub
		return memberDao.juminChk(jumin1, jumin2);
	}
	/*@Override
	public int juminChk(String useJumin) {
		return memberDao.juminChk(useJumin);
	}*/
	

	@Override
	public MemberVo viewMember(int memNo) {
		return memberDao.viewMember(memNo);
	}
	@Override
	public void updateMember(MemberVo vo) {
		memberDao.updateMember(vo);
	}

	@Override
	public void deleteMember(int memNo) {
		memberDao.deleteMember(memNo);
	}

	@Override
	public int countArticle(String searchOption, String keyword) {
		// TODO Auto-generated method stub
		return memberDao.countArticle(searchOption, keyword);
	}

	@Override
	public void deleteMember2(List<String> list) {
		// TODO Auto-generated method stub
		memberDao.deleteMember2(list);
	}


}
