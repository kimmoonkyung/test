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
		var address = '${dto.address}';
		var address1 = address.substring(0,3);
		var address2 = address.substring(4);
		$(".first-address").val(address1);
		$(".second-address").val(address2);

		//이미지 업로드 버튼
		$(".btn-upload").click(function(e){
			e.preventDefault();
			$(".file").click();
		});
		
		//사원 수정 버튼
		$(".btn-edit").click(function(e){
			e.preventDefault();
			$(".edit").click();
			document.edit.action="${path}/edit";
			document.edit.submit();
		});
		
		//취소
		$(".btn-cancel").click(function(e){
			e.preventDefault();
			$(".cancel").click();
			parent.location.href = "${path}/?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
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
				return extName;//
			}
			
		}
		
	}
	function getFileName(obj, stype){
		
		var fName = getFileInfo(obj, stype);
		
		var fNameView = document.querySelector(".file-name-view");		
		fNameView.value = fName;
		//console.log(fName);
		
	}
	
</script>
<body topmargin="0" leftmargin="0">
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="640">&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="${path }/resources/image/icon.gif" width="9" height="9" align="middle"> 
      <strong>사원 기본 정보 수정</strong></td>
  </tr>
  
  <tr> 
    <td>
    <form name="edit" method="post" enctype="multipart/form-data" >
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
                      <td height="3" align="right" background="${path }/resources/image/bar_bg1.gif"></td>
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
                                    <img id="image" style="width:98px; height: 110px;" src="${path }/resources/upload/${dto.image}">
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
                                <input type="text" name="kor_Name" value="${dto.kor_Name }">
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>영문이름 :&nbsp;</strong></td>
                              <td height="26"><input type="text" name="eng_Name" value="${dto.eng_Name }"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
                              <td height="26"><input type="text" name="chn_Name" value="${dto.chn_Name }"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              <td height="26"><input name="jumin_noF" value="${dto.jumin_noF }" type="text" size="15">
      -
        <input name="jumin_noB" value="${dto.jumin_noB }" type="text" size="15"></td>
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
                            <td width="268"><input class="file-name-view" readonly="readonly" value="${dto.image }" type="text"></td>
                            <td width="146">
                            	<input id="img-upload" type="file" class="file" name="file" onchange="getFileName(this,'all')" style="display: none;">
                            	<img class="btn-upload" style="cursor: pointer;" src="${path }/resources/image/bt_search.gif" width="49" height="18">
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>생년월일 :&nbsp;</strong></td>
                            <td width="391"><input name="birth1" value="${dto.birth1 }" type="text" size="10">
                              년 
                              <input name="birth2" value="${dto.birth2 }" type="text" size="7">
                              월 
                              <input name="birth3" value="${dto.birth3 }" type="text" size="7">
                              일 
                              <c:choose>
                              <c:when test="${dto.sol_flag eq '양력' }">
	                              (
	                              <input type="radio" name="sol_flag" value="양력" checked="checked"> 양력 
	                              <input type="radio" name="sol_flag" value="음력"> 음력 
	                              )
                              </c:when>
                              <c:otherwise>
	                               (
	                              <input type="radio" name="sol_flag" value="양력"> 양력 
	                              <input type="radio" name="sol_flag" value="음력" checked="checked"> 음력 
	                              )
                              </c:otherwise>
                              </c:choose>
                              </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>성별 :&nbsp; </strong></td>
                            <td width="391">
                            <c:choose>
                            <c:when test="${dto.sex eq '남자' }"> 
	                            <input type="radio" name="sex" value="남자" checked="checked"> 남자 
	                            <input type="radio" name="sex" value="여자"> 여자
                            </c:when>
                            <c:otherwise>
                            	<input type="radio" name="sex" value="남자"> 남자 
	                            <input type="radio" name="sex" value="여자" checked="checked"> 여자
                            </c:otherwise>
                            </c:choose>
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :&nbsp;</strong></td>
                            <td width="391">
                            	<c:choose>
                            	<c:when test="${dto.marry_flag eq '기혼' }">
                            		<input type="radio" name="marry_flag" value="기혼" checked="checked"> 기혼 
									<input type="radio" name="marry_flag" value="미혼"> 미혼
                            	</c:when>
                            	<c:otherwise>
                            		<input type="radio" name="marry_flag" value="기혼"> 기혼 
									<input type="radio" name="marry_flag" value="미혼" checked="checked"> 미혼
                            	</c:otherwise>
                            	</c:choose> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>년차 :&nbsp;</strong></td>
                            <td width="392"><input value="${dto.work_year }" name="work_year" type="text" size="10"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급유형 :&nbsp;</strong></td>
                            <td width="392"> 
                            	<select name="payment_type">
	                            	<c:choose>
	                            		<c:when test="${dto.payment_type eq '월급' }">
		                            		<option value="월급" selected="selected">월급</option>
		                                	<option value="주급">주급</option>
	                            		</c:when>
	                            		<c:otherwise>
	                            			<option value="월급">월급</option>
		                                	<option value="주급" selected="selected">주급</option>
	                            		</c:otherwise>
	                            	</c:choose>
								</select> 
							</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>희망직무 :&nbsp;</strong></td>
                            <td width="392"> 
                            	<select name="desire_dept">
                                <c:choose>
                                	<c:when test="${dto.desire_dept eq 'SI' }">
                                		<option value="SI" selected="selected">SI</option>
                                		<option value="SM">SM</option>
                                	</c:when>
                                	<c:otherwise>
                                		<option value="SI">SI</option>
                                		<option value="SM" selected="selected">SM</option>
                                	</c:otherwise>
                                </c:choose>
                                
                                </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>입사유형:&nbsp;</strong></td>
                            <td width="392"> 
                            	<select name="job_type">
								<c:choose>
									<c:when test="${dto.job_type eq '정규직' }">
										<option value="정규직" selected="selected">정규직</option>
	                                	<option value="계약직">계약직</option>
									</c:when>
									<c:otherwise>
										<option value="정규직">정규직</option>
	                                	<option value="계약직" selected="selected">계약직</option>
									</c:otherwise>
								</c:choose>
                                </select> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주소:&nbsp;</strong></td>
                            <td width="392">
                            	<input class="first-address" name="address1" type="text" size="10"> 
								<input class="second-address" name="address2" type="text" size="40"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
                            <td width="392"><input value="${dto.phone1 }" name="phone1" type="text" size="10">
                              - 
                              <input value="${dto.phone2 }" name="phone2" type="text" size="10">
                              - 
                              <input value="${dto.phone3 }" name="phone3" type="text" size="10"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
                            <td width="392"><input value="${dto.email }" name="email" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
                            <td width="392"><input value="${dto.tech_lev }" name="tech_lev" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주량:&nbsp;</strong></td>
                            <td width="392"><input value="${dto.liquor }" name="liquor" type="text" size="20"> 
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
              	<input type="hidden" name="memNo" value="${dto.memNo }">
              	<!-- <input type="submit" class="edit" value="수정" style="display: none;"> -->
              	<button class="edit" style="display: none;" type="button">수정</button>
              	<img style="cursor: pointer;" class="btn-edit" src="${path }/resources/image/bt_remove.gif" width="49" height="18">
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
