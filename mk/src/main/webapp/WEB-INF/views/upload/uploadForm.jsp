<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드 테스트 페이지</title>
<style>
	iframe{
		width: 600px;
		height: 100px;
		border: 1px;
		border-style: solid;
	}
</style>

</head>
<body>
	<form id="form1" target="iframePhoto" action="${path }/upload/uploadForm" method="post" enctype="multipart/form-data">
		<input type="file" name="file">
		<input type="submit" value="업로드">
	</form>
	<!-- form data가 이곳으로 이동 form의 target 속성-->
	<iframe name="iframePhoto"></iframe>
</body>
<script type="text/javascript">
	
	function addFilePath(msg){
		console.log(msg); //파일명
		document.getElementById("form1").reset(); // iframe에 업로드 결과 출력 후 form에 저장된 데이터 초기화
	}

</script>

</html>