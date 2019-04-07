package com.mkcompany.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mkcompany.dto.MemberVo;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Inject
	SqlSession sqlSession;
	
	private static final String Namespace = "com.mkcompany.dao.MemberDao";
	
	@Override
	public List<MemberVo> memberList(int start, int end, String searchOption, String keyword) {
		// 검색옵션, 키워드 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		// BETWEEN #{start}, #{end}에 입력될 값을 put
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList(Namespace + ".memberList", map);
	}

	//등록
	@Override
	public void insertMember(MemberVo vo) {
		// TODO Auto-generated method stub
		sqlSession.insert(Namespace + ".insertMember", vo);
	}
	
	//수정 (view.jsp)
	@Override
	public MemberVo viewMember(int memNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".viewMember", memNo);
	}
	//수정
	@Override
	public void updateMember(MemberVo vo) {
		sqlSession.update(Namespace + ".updateMember", vo);
	}

	@Override
	public void deleteMember(int memNo) {
		// TODO Auto-generated method stub
		sqlSession.delete(Namespace + ".deleteMember", memNo);
	}

	@Override
	public int countArticle(String searchOption, String keyword) {
		// TODO Auto-generated method stub
		//검색 옵션, 키워드 맵에 저장
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		
		return sqlSession.selectOne(Namespace + ".countArticle", map);
	}

	@Override
	public void deleteMember2(List<String> list) {
		// TODO Auto-generated method stub
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("aaa", list);
		
		sqlSession.delete(Namespace + ".deleteMember2", map);
	}
	
	

}
