<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="${path }/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".uploadTest").click(function(){
			parent.location.href = "${path}/upload/uploadForm";
		});
	
		//수정
		$(".editBtn").click(function(){
			//console.log($(".list :first-child input[type=checkbox]:checked").length);
					//체크박스를 1명이상 체크했을 경우
			if( $(".list :first-child input[type=checkbox]:checked").length > 1 ){
				alert("한명의 직원만 선택해주세요.");
				return
			} else if( $(".list :first-child input[type=checkbox]:checked").length == 1 ) {
				//var memNo = $(".list :first-child input[type=hidden]");
				var memNo = $(".list :first-child input[type=checkbox]:checked").val();
				//console.log(memNo);
				if(confirm("선택한 직원을 수정하시겠습니까?")){
					parent.location.href = "${path}/view?memNo="+memNo+"&curPage=${map.memberPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}";
				}
			} else {
				alert("수정할 직원을 선택해주세요.");
				return
			}
			
		});
		
		//삭제
		$(".delBtn").click(function(){
			if( $(".list :first-child input[type=checkbox]:checked").length == 0 ){
				alert("삭제할 직원을 선택해주세요.");
				return
			} 
			/*else if ( $(".list :first-child input[type=checkbox]:checked").length == 1 ) {
				var memNo = $(".list :first-child input[type=checkbox]:checked").val();
				//console.log(memNo);
				if(confirm("삭제하시겠습니까?")){
					$.ajax({
						type: 'post',
						data : {"memNo" : memNo},
						//url : '${path}/delete?memNo='+memNo,
						url : '${path}/delete',
						success : function(result){
							console.log("삭제완료");
							location.href="${path}/main";
							alert("삭제했습니다.");
						}
					});
				}
			}*/ 
			else {
				//name, class =  chk
				var obj = {};
				
				$(".chk:checked").each(function(i, val) {
					obj[i] = $(val).val();
				});
				if(confirm("삭제하시겠습니까?")){
					$.ajax({
						type : 'post',
						data : JSON.stringify(obj),
						dataType : 'text',
						contentType: "application/json",
						url : '${path}/delete2',
						success : function(data) {
							console.log(data);
							location.href="${path}/main";
							alert("삭제했습니다.");
						}
						/*error : function(request, status, error) {
							console.log("code: " + request.status + "\n" + "message: " + request.respnseText + "\n" + "error : " + error);
							alert("code: " + request.status + "\n" + "message: " + request.respnseText + "\n" + "error : " + error);
							location.href="${path}/main";
							alert("삭제했습니다.");
						}*/
					});
				}
				
				
				//checklist();
				//alert("다중삭제 구현 예정");
				//return
			}
			
		});
		/*function checklist(){
			$(".chk").each(function(){
				var checkList = "";
				if($(this).prop(":checked")== true){
					checkList += $(this).val()+"번";
				}
			console.log(checkList);
			});
		}*/
		
		//검색
		$(".searchBtn").click(function(e){
			e.preventDefault();
			$(".search").click();
		});
		
		//전체선택 / 선택해제
		$(".allCheck").click(function(e){
			if( $(".allCheck").prop("checked") ){
				$("input[name=chk]").prop("checked",true);
				console.log("전체선택");
			} else {
				$("input[name=chk]").prop("checked", false);
			}
		});
		
	});
	// 페이징 / 페이지 이동시 검색조건, 키워드 값 유지 위해
	function main(page){
		//console.log(page);
		location.href="${path}/main?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
	};
	
	
	
</script>

<body topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="${path }/resources/image/icon.gif" width="9" height="9" align="middle"> 
      <strong>사원조회</strong><a class="uploadTest" href="javascript:test();" > 업로드 테스트 페이지</a></td>
  </tr>
  <tr> 
    <td>
    <table width="640" border="0" cellspacing="0" cellpadding="0">
    <tbody>
        <tr> 
          <td height="30" align="right">
          <form name="searchform" method="post" action="${path}/main">
          <select name="searchOption" class="INPUT">
              <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/>>::::: 전체 :::::</option>
              <option value="kor_Name" <c:out value="${map.searchOption == 'kor_Name'?'selected':''}"/>>::::: 이름 :::::</option>
              <option value="sex" <c:out value="${map.searchOption == 'sex'?'selected':''}"/>>::::: 성별 :::::</option>
              <option value="tech_lev" <c:out value="${map.searchOption == 'tech_lev'?'selected':''}"/>>::::: 기술등급 :::::</option>
              <option value="man_tech" <c:out value="${map.searchOption == 'man_tech'?'selected':''}"/>>::: 남자-기술등급 :::</option>
              <option value="girl_tech" <c:out value="${map.searchOption == 'girl_tech'?'selected':''}"/>>::: 여자-기술등급 :::</option>
              
           </select> 
           <input name="keyword" type="text" value="${map.keyword }">
           <input class="search" type="submit" style="display: none;" >
           <img class="searchBtn" style="cursor: pointer;" src="${path }/resources/image/search.gif" width="49" height="18" border="0" align="middle">
           </form>
           </td>
        </tr>
    </tbody>
        <tr> 
          <td><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="3" background="${path }/resources/image/bar_bg1.gif"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a class="editBtn" href="#">수정</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">인사기록카드</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">경력정보</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr class="memberBox"> 
                <td>
				<!-------------------------  리스트 ------------------------------>
				<table class="list memberList" width="640" border="0" cellspacing="0" cellpadding="0">
					<tr style="font-weight: bold;">
						<td width="35" height="20" align="center"><input class="allCheck" type="checkbox" name="chk" value=""></td>
						<td width="85" align="center">이름</td>
						<td width="153" align="center">주민번호</td>
						<td width="91" align="center">성별</td>
						<td width="91" align="center">기술등급</td>
						<td width="91" align="center">상태</td>
						<td width="94" align="center">근무</td>
					</tr>
					<c:forEach var="mem" items="${map.list }">
                    <tr class="memberNode">
						<td width="35" height="20" align="center"><input class="chk" type="checkbox" name="chk" value="${mem.memNo }"></td>
						<td width="85" align="center">${mem.kor_Name }</td>
						<td width="153" align="center">${mem.jumin_noF }-${mem.jumin_noB }</td>
						<td width="91" align="center">${mem.sex }</td>
						<td width="91" align="center">${mem.tech_lev }</td>
						<td width="91" align="center">${mem.job_type }</td>
						<td width="94" align="center">${mem.desire_dept }</td>
                    </tr>
                    </c:forEach>
                    <tr> 
                      <td colspan="7" background="${path }/resources/image/line_bg.gif"></td>
                    </tr>
                    <%-- <tr> 
                      <td height="35" colspan="7" align="center" style="padding-bottom:3"><a href="#"><img src="${path }/resources/image/prev.gif" width="22" height="15" border="0" align="middle"></a>&nbsp;<a href="#"><img src="${path }/resources/image/pre.gif" width="42" height="15" border="0" align="middle"></a>&nbsp; 
                        1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 &nbsp;<a href="#"><img src="${path }/resources/image/next.gif" width="42" height="15" border="0" align="middle"></a>&nbsp;<a href="#"><img src="${path }/resources/image/next_.gif" width="22" height="15" border="0" align="middle"></a></td>
                    </tr> --%>
                    <tr>
                    	<td colspan="7" height="35" align="center" style="padding-bottom: 3">
                    		<!-- **처음 페이지로 이동 : 현재페이지가 1보다 크면 [처음]하이퍼링크를 화면에 출력-->
                    		<c:if test="${map.memberPager.curBlock > 1 }">
                    			<a href="javascript:main('1')">[처음]</a>
                    		</c:if>
                    		<!-- **이전 페이지 블럭으로 이동 : 현재페이지 블럭 1보다 크면 [이전]하이퍼링크를 화면에 출력-->
                    		<c:if test="${map.memberPager.curBlock > 1 }">
                    			<a href="javascript:main('${map.memberPager.prevPage}')">[이전]</a>
                    		</c:if>
                    		
                    		<!-- ** 하나의 블럭에서 반복문 수행 시작page부터 끝page까지 -->
                    		<c:forEach var="num" begin="${map.memberPager.blockBegin}" end="${map.memberPager.blockEnd}">
                    			<c:choose>
	                    			<c:when test="${num == map.memberPager.curPage}">
										<span style="color:red">${num}</span>&nbsp;                    			
	                    			</c:when>
	                    			<c:otherwise>
	                    				<a href="javascript:main('${num}')">${num}</a>&nbsp;
	                    			</c:otherwise>
                    			</c:choose>
                    		</c:forEach>
                    		
                    		<!-- ** 다음페이지 블럭으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크-->
                    		<c:if test="${map.memberPager.curBlock <= map.memberPager.totBlock}">
                    			<a href="javascript:main('${map.memberPager.nextPage}')">[다음]</a>
                    		</c:if>
                    		<!-- ** 끝페이지 블럭으로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크-->
                    		<c:if test="${map.memberPager.curPage <= map.memberPager.totPage}">
                    			<a href="javascript:main('${map.memberPager.totPage}')">[끝]</a>
                    		</c:if>
                    	</td>
                    </tr>
                  </table>
 				<!-------------------------  리스트 ------------------------------>
				  </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a class="delBtn" href="#">삭제</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">인사기록카드</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">경력정보</a> <img src="${path }/resources/image/all_icon.gif" width="11" height="11" align="middle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" background="${path }/resources/image/bar_bg1.gif"></td>
        </tr>
      </table></td>
  </tr>
</table>
<script>
	/*window.addEventListener("load", function(){
		//
		var delBtn = document.querySelector(".delBtn");
		
		delBtn.onclick = function(e){
			//console.log("삭제버튼");
			var delMemberNo = 
		};
		
	});*/
	$(document).ready(function(){
		
		
		
	});
	
</script>
</body>
</html>
