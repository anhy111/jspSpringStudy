<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>File Upload</title>
</head>
<body>
<!-- 
	파일 업로드 패키지인 Commons-fileUpload는 서버의 메모리상에서 파일 처리가 가능하도록 지원함
	이 패키지는 Commons-io 패키지를 바탕으로 작성되었으므로 
	웹 브라우저(크롬)에서 서버(톰켓설치된 서버)로 파일을 업로드하기 위해
	오픈 라이브러리 commons-fileupload.jar, commons-io.jar 파일을 사용
	웹 어플리케이션의 /WebContent/WEB-INF/lib 폴더에 포함되어야 함
-->
	<form name="fileForm" action="fileupload01_process.jsp"
		method="post" enctype="multipart/form-data">
		<p>이름:<input type="text" name="name"></p>
		<p>제목:<input type="text" name="subject"></p>
		<p>파일:<input type="file" name="filename"></p>
		<p><input type="submit" value="파일 올리기"></p>
	</form>
</body>
</html>