<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>책 목록</title>
</head>
<body>
<!-- p.98 -->
	<h1>책 목록</h1>
	<p>
		<!-- action속성 및 값이 생략 시, 현재 URI(/list)를 재요청. 
		method는 GET(form 태그의 기본 HTTP 메소드는 GET임) -->
		<form>
			<input type="text" placeholder="검색어를 입력하세요" name="keyword"
				value="${keyword}" />
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
		<!-- 
		forEach 태그? 배열(String[], int[][]), Collection(List, Set) 또는 
		Map(HashTable, HashMap, SortedMap)에 저장되어 있는 값들을 
		순차적으로 처리할 때 사용함. 자바의 for, do~while을 대신해서 사용함
		var : 변수
		items : 아이템(배열, Collection, Map)
		varStatus : 루프 정보를 담은 객체 활용
			- index : 루프 실행 시 현재 인덱스(0부터 시작)
			- count : 실행 회수(1부터 시작. 보통 행번호 출력)
		 -->
		 <!-- data : mav.addObject("data", list); -->
		 <!-- row : bookVO 1행 -->
		<c:forEach var="row" items="${data}" varStatus="stat">
			<tr>
				<td>${stat.count}</td>
				<td><a href="/detail?bookId=${row.bookId}">${row.title}</a></td>
				<td>${row.category}</td>
				<td><fmt:formatNumber type="number" maxFractionDigits="3"
					value="${row.price}" />
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<p>
		<a href="/create">책 생성</a>
	</p>
</body>
</html>







