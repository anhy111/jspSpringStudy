<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>책 등록하기</title>
</head>
<body>
<h1>책 등록</h1>
<form action="/create" method="post">
	<p>제목 : <input type="text" name="title" /></p>
	<p>카테고리 : <input type="text" name="category" /></p>
	<p>가격 : <input type="text" name="price" /></p>
	<p>
		<input type="submit" value="저장" />
		<input type="button" value="목록" onclick="javascript:location.href='/list'" />
	</p>
</form>
</body>
</html>













