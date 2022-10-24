<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>책 목록</title>
</head>
<body>
	<h1>책 목록</h1>
	<p>
		<!-- action 속성 및 값 생략 시, 현재URL(/list)를 재요청
			method는 GET(form 태그의 기본 HTTP 메소드는 GET임) -->
		<form>
			<input type="text" placeholder="검색어를 입력하세요" name="keyword"
				value="${param.keyword}" />
			<input type="submit" value="검색" />
		</form>
	</p>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>
		<!-- data : mav.addObject("data",list); -->
		<c:forEach var="row" items="${data}" varStatus="stat" >
			<tr>
				<td>${stat.count}</td>
				<td><a href="/detail?bookId=${row.bookId}">${row.title}</a></td>
				<td>${row.category}</td>
				<td align="right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${row.price}" />원</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<p>
		<a href="/create">책 등록</a>
	</p>
	
</body>
</html>