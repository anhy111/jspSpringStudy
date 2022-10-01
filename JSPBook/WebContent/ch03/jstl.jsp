<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>JSTL연습</title>
</head>
<body>
<%--
	JSTL? Jsp Standard Tag Library
	- jsp 페이지에서 스크립트 요소로 인해 생기는 코드의 복잡함을
	해결하기 위한 일종의 사용자 정의 태그 표준
	- jsp 페이지의 로직을 담당하는 부분인 if, for, while, DB처리 등과 관련된
	코드를 JSTL로 대체하여 코드를 깔끔하고 가독성 좋게 할 수 있음
	
	1) Core태그(*****)
		- 변수 선언, 삭제 등 변수와 관련된 작업
		- if문, for 문과 같은 제어 기능
		- URL 처리로 페이지 이동
	2) Formatting 태그(***)
		- 숫자/날짜/시간 등을 형식화하는 기능
	3) Sql
		- 안씀
	4) Function 태그(**)
		- 문자열을 처리하는 함수 제공. 문자열 추출. 문자열 길이 구하기
--%>
	<!-- 
		action 속성 생략 시 현재 페이지로 요청
		method 속성 생략 시 기본은 get방식
	 -->
	<form>
		<p>숫자: <input type="text" name="num">
		<button type="submit">짝홀판단</button>
	</form>
	
	<%	//스크립틀릿
		String num = request.getParameter("num");
	%>
	<!-- JSP의 num이 JSTL의 num으로 넘어옴 -->
	<c:set var="num" value="${param.num}"/>
	<p>${num}</p>
	<c:set var="num2" value="<%=num %>"></c:set>
	<p>${num2}</p>
	<!-- 
		c:choose문을 사용하여 짝수와 홀수를 판단해보자
			1) 짝수일 경우 : 5는 짝수입니다.
			2) 홀수일 경우 : 5는 홀수입니다.
			3) 그 이외의 경우 : 잘못된 입력입니다.
	-->
	
	<c:choose>
		<c:when test="${num % 2 == 0}">${num}은 짝수입니다.</c:when>
		<c:when test="${num % 2 == 1}">${num}은 홀수입니다.</c:when>
		<c:otherwise>잘못된 입력입니다.</c:otherwise>
	</c:choose>
	<hr>
	
	<!-- 
		넘어온 파라미터를 통해 구구단을 출력
		단, c:forEach문을 사용해보기
		2 x 1 = 2
		2 x 2 = 4
		...
		2 x 9 = 19
	 -->
	<h2>구구단</h2>

	
	<c:forEach var="i" begin="1" end="9" step="1">
		<p>${num} x ${i} = ${num * i}</p>
	</c:forEach>
	
	
<script>
	let num3 = "${param.num}";
	console.log("num3 : " + num3);
</script>
</body>
</html>