<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<title>회원정보</title>
</head>
<body>
<p>${pmemberVO.id}</p>
<p>${pmemberVO.password}</p>
<p>${pmemberVO.mail}</p>
<p><fmt:formatDate value="${pmemberVO.birth}" 
		pattern="yyyy-MM-dd" /></p>
</body>
</html>