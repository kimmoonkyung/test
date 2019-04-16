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
	// 주민 중복확인
	@Override
	public int juminChk(String jumin1, String jumin2) {

		Map<String, String> map = new HashMap<String, String>();
		map.put("jumin1", jumin1);
		map.put("jumin2", jumin2);
		
		int count = sqlSession.selectOne(Namespace + ".juminChk2", map);
		
		return count;
		
	}
	/*@Override
	public int juminChk(String useJumin) {
		return sqlSession.selectOne(Namespace + ".juminChk", useJumin);
	}*/
	
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
	public void deleteMember2(List<String> list) { //삭제할 회원의 memNo를 list로 받아와서, (ex: [200, 199, 198 ...]
		//System.out.println("다중삭제 dao의 매개변수 = " + list);
		Map<String, List<String>> map = new HashMap<String, List<String>>(); // 키값 String value값 List로 HashMap 생성
		map.put("deathnote", list); // deathnote라는 키값에 밸류로 list를 담음
		/*for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i) + "ㅂㅂㅂㅂㅂㅂ");
		}*/
		sqlSession.delete(Namespace + ".deleteMember2", map);
		//MemberMapper의 deleteMember2의 
		//foreach 구문에서 collection을 deathnote로 설정하고 item(꺼내쓸 이름)을 memNo로 설정 separator(구분자)는 or
		//결과 커리문 = DELETE FROM MEMBER WHERE memno = #{memNo} or memno = #{memNo};
	}

}