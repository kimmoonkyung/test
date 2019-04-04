<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드 결과</title>
</head>
<body>
	파일이 업로드 되었습니다.
	파일명 : ${savedName }
<script type="text/javascript">
	var result = "${savedName}";
	parent.addFilePath(result); // 파일명 부모페이지로 전달
</script>
</body>
</html>