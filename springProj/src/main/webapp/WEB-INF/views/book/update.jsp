<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>책 수정</title>
<script type="text/javascript">
	$(function() {
		$("#btnCancel").on("click",function(){
			let bookId = "${param.bookId}";
			// BookController의 /list URI에 매핑된 메서드 실행
			location.href="/detail?bookId=" + bookId;
		});
		$("#btnList").on("click",function(){
			location.href="/list";
		});
	});
	
	
</script>
</head>
<body>
<h1>책 수정</h1>
<form action="/update" method="post">
	<input type="hidden" name="bookId" value="${data.bookId}" />
	<p>제목 : <input type="text" name="title" value="${data.title}" required="required"/></p>
	<p>카테고리 : <input type="text" name="category" value="${data.category}" required="required"/></p>
	<p>가격 : <input type="text" name="price" value="${data.price}" required="required"/></p>
	<p>
		<input type="submit" value="저장" />
		<input type="button" id="btnCancel" value="취소" />
		<button type="button" id="btnList">목록</button>
	</p>
</form>
</body>
</html>