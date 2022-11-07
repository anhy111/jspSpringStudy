<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Result</title>
</head>
<body>
<h3>Result</h3>
<p>
	유저ID : ${pmemberVO.id}
</p>
<p>
	이름 : ${pmemberVO.name}
</p>
<p>
	E-MAIL : ${pmemberVO.mail}
</p>
<p>
	비밀번호 : ${pmemberVO.password}
</p>
<p>
	소개 : ${pmemberVO.address}
</p>
<p>
	취미 : 
	<c:forEach var="row" items="${pmemberVO.hobbyMap}">
		${row}<br />
	</c:forEach> 
</p>
</body>
</html>







