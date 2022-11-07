<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>책 수정하기</title>
</head>
<body>
<!-- BookController에서 넘어온 데이터? mav.addObject("data", data); -->
<h1>책 수정</h1>
<form action="/update" method="post">
	<input type="hidden" name="bookId" value="${data.bookId}" /> 
	<p>제목 : <input type="text" name="title" value="${data.title}" /></p>
	<p>카테고리 : <input type="text" name="category" value="${data.category}" /></p>
	<p>가격 : <input type="text" name="price" value="${data.price}" /></p>
	<p><input type="submit" value="저장" /></p>
</form>
</body>
</html>












