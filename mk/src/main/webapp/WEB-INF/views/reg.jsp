<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%@ page session="false" %>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="${path }/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
	$(document).ready(function(){
		//이미지 업로드 버튼
		$(".btn-upload").click(function(e){
			e.preventDefault();
			$(".file").click();
		});
		//사원 등록 버튼
		$(".btn-reg").click(function(e){
			e.preventDefault();
			
			var korName = $(".kor"); // 이름 input
			var engName = $(".eng"); // 영어이름 input
			//주민번호 입력 정규식, 유효성 관련
			var jumin1 = $(".juminF");
			var jumin2 = $(".juminB");
			var yy = jumin1.val().substr(0,2); // 년
			var mm = jumin1.val().substr(2,2); // 월
			var dd = jumin1.val().substr(4,2); // 일
			var sex = jumin2.val().substr(0,1) // 성별
			var ss, cc;
			
			var korNamePttn = /^[가-힣]{2,4}$/; //한글 유효성 패턴
			var engNamePttn = /^[A-za-z]/g; //영문 유효성 패턴
			var juminPttn = /^[0-9]*$/; // 주민 숫자 패턴
			
			//한국 이름 입력 체크
			if(korName.val().length == 0){
				alert("이름을 입력하세요.");
				korName.focus();
				return false;
			} else if(!korNamePttn.test(korName.val())){
				alert("2-4자의 정상적인 이름을 입력해주세요.");
				korName.focus();
				return false;
			};
			//영문 이름 입력 체크
			if(engName.val().length == 0){
				alert("영문 이름을 입력하세요.");
				engName.focus();
				return false;
			} else if(!engNamePttn.test(engName.val())){
				alert("영문 이름만 입력하실 수 있습니다.");
				engName.focus();
				return false;
			}
			
			//주민번호 숫자입력 체크
			if(jumin1.val().length == 0){
				alert("주민번호 앞자리를 입력하세요.");
				jumin1.focus();
				return false;
			} else if(!juminPttn.test(jumin1.val())){
				alert("숫자로 입력해주세요.");
				jumin1.focus();
				return false;
			}
			if(jumin2.val().length == 0){
				alert("주민번호 뒷자리를 입력하세요.");
				jumin2.focus();
				return false;
			} else if(!juminPttn.test(jumin2.val())){
				alert("숫자로 입력해주세요.");
				jumin2.focus();
				return false;
			}
			if( yy < 0 || yy > 99 || 
				mm < 1 || mm > 12 || 
				dd < 1 || dd > 31 ){
				alert("주민번호 앞자리를 다시 입력하세요.");
				jumin1.focus();
				return false;
			} 
			
			if(confirm("등록하시겠습니까?")){
				$.ajax({
					type : 'post',
					url : '${path}/reg/juminChk',
					dataType : 'text',
					data : JSON.stringify({
						"useJumin" : jumin1.val(),
						"useJumin2" : jumin2.val()
						/* "useJumin" : jumin1.val(),
						"useJumin2" : jumin2.val() */
					}),
					contentType: "application/json; charset=utf-8",
					success : function(data){
						if($.trim(data)=="YES"){
							console.log(data);
							$(".reg").click();	
						} else {
							alert("등록되어있는 주민번호 입니다.");
							jumin1.focus();
							return false;
						}
					}
				})
				
				//$(".reg").click();
			}
				
		});
		
		$(".btn-cancel").click(function(e){
			e.preventDefault();
			$(".cancel").click();
			parent.location.href = "${path}/";
		});
		
	});
	//이미지 업로드하고 파일명 띄우기
	function getFileInfo(obj, stype){
		var fileObj, pathHeader, pathMiddle, pathEnd, allFilename, fileName, extName;
		
		if(obj == "[object HTMLInputElement]"){
			fileObj = obj.value;
			console.log(fileObj);
		} 
		if(fileObj != ""){
			pathHeader = fileObj.lastIndexOf("\\");
			pathMiddle = fileObj.lastIndexOf(".");
			pathEnd = fileObj.length;
			fileName = fileObj.substring(pathHeader+1, pathMiddle);
			extName = fileObj.substring(pathHeader+1, pathEnd);
			allFileName = fileName+"."+extName;
			
			if(stype == "all"){
				return extName;
			}
			
		}
		
	}
	function getFileName(obj, stype){
		
		var fName = getFileInfo(obj, stype);
		
		var fNameView = document.querySelector(".file-name-view");		
		fNameView.value = fName;
		
	}
	
</script>
<body topmargin="0" leftmargin="0">
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="640">&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="${path }/resources/image/icon.gif" width="9" height="9" align="middle"> 
      <strong>사원 등록</strong></td>
  </tr>
  
  <tr> 
    <td>
    <form method="post" enctype="multipart/form-data" >
    <table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="15" align="left"><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><table width="640" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="2" background="${path }/resources/image/bar_bg1.gif"></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="26" align="center" bgcolor="#E4EBF1" style="padding-right:10"><table width="600" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="center"><strong>교육정보 | 자격증. 보유기술정보 | 프로젝트 
                              정보 |경력정보 | 근무정보</strong></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="3" align="right" background="${path }/resources/image/bar_bg1.gif" ></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="6" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="7" align="center" valign="top"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="135" align="center" bgcolor="#E4EBF1"><table width="600" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="144" height="119" align="center"><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td height="112" bgcolor="#CCCCCC"><table width="100" border="0" cellspacing="1" cellpadding="0">
                                  <tr>
                                    <td height="110">
                                    <img id="image" style="width:98px; height: 110px;" src="#">
                                    </td>
                                  </tr>
                              </table></td>
                            </tr>
                          </table></td>
                          <td width="456"><table width="423" border="0" cellspacing="2" cellpadding="0">
                            <tr>
                              <td height="2" colspan="2"></td>
                              </tr>
                            <tr>
                              <td width="107" height="26" align="right"><strong>한글이름 :</strong>&nbsp;</td>
                              <td width="310" height="26">
                                <input type="text" class="kor" name="kor_Name">
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>영문이름 :&nbsp;</strong></td>
                              <td height="26"><input type="text" class="eng" name="eng_Name"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
                              <td height="26"><input type="text" class="chn" name="chn_Name"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              <td height="26"><input class="juminF" name="jumin_noF" type="text" size="15" maxlength="6">
      -
        <input class="juminB" name="jumin_noB" type="text" size="15" maxlength="7"></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="7" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td height="13" align="center"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="526" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>사진파일명 :&nbsp;</strong></td>
                            <td width="268"><input class="file-name-view" readonly="readonly" type="text" size="40"></td>
                            <td width="146">
                            	<input id="img-upload" type="file" class="file" name="file" style="display: none;" onchange="getFileName(this,'all')">
                            	<img class="btn-upload" style="cursor: pointer;" src="${path }/resources/image/bt_search.gif" width="49" height="18">
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>생년월일 :&nbsp;</strong></td>
                            <td width="391"><input name="birth1" type="text" size="10">
                              년 
                              <input name="birth2" type="text" size="7">
                              월 
                              <input name="birth3" type="text" size="7">
                              일 ( 
                              <input type="radio" name="sol_flag" value="양력">
                              양력 
                              <input type="radio" name="sol_flag" value="음력">
                              음력 )</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>성별 :&nbsp; </strong></td>
                            <td width="391"> <input type="radio" name="sex" value="남자">
                              남자 
                              <input type="radio" name="sex" value="여자">
                              여자</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :&nbsp;</strong></td>
                            <td width="391"> <input type="radio" name="marry_flag" value="기혼">
                              기혼 
                              <input type="radio" name="marry_flag" value="미혼">
                              미혼</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>년차 :&nbsp;</strong></td>
                            <td width="392"><input name="work_year" type="text" size="10"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급유형 :&nbsp;</strong></td>
                            <td width="392"> <select name="payment_type">
                                <option value="월급">월급</option>
                                <option value="주급">주급</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>희망직무 :&nbsp;</strong></td>
                            <td width="392"> <select name="desire_dept">
                                <option value="SI">SI</option>
                                <option value="SM">SM</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>입사유형:&nbsp;</strong></td>
                            <td width="392"> <select name="job_type">
                                <option value="정규직">정규직</option>
                                <option value="계약직">계약직</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주소:&nbsp;</strong></td>
                            <td width="392"><input class="address" name="address1" type="text" size="10"> 
                              <input class="address" name="address2" type="text" size="40"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
                            <td width="392"><input name="phone1" type="text" size="10">
                              - 
                              <input name="phone2" type="text" size="10">
                              - 
                              <input name="phone3" type="text" size="10"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
                            <td width="392"><input name="email" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
                            <td width="392"><input name="tech_lev" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주량:&nbsp;</strong></td>
                            <td width="392"><input name="liquor" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" align="center">&nbsp;</td>
        </tr>
        <tr>
          <td height="3" align="center"><table width="107" border="0" cellpadding="1" cellspacing="1">
            <tr>
              <td width="49">
              	<input type="submit" class="reg" value="등록" style="display: none;">
              	<img style="cursor: pointer;" class="btn-reg" src="${path }/resources/image/bt_remove.gif" width="49" height="18">
              </td>
              <td width="51">
				<button type="button" class="cancel" style="display: none;">취소</button>
              	<img style="cursor: pointer;" class="btn-cancel" src="${path }/resources/image/bt_cancel.gif" width="49" height="18">
              </td>
            </tr>
          </table>            </td>
        </tr>
        <tr> 
          <td height="7" align="right">&nbsp;</td>
        </tr>
      </table>
      </form>
      </td>
  </tr>
</table>
</body>
<script type="text/javascript">
	//업로드 전 이미지 미리보기
	function readURL(input){
		console.log(input);
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#image").attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$("#img-upload").change(function(){
		readURL(this);
	});
</script>
</html>
