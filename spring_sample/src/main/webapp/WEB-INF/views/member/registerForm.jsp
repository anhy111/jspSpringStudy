<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<title>Spring Form</title>
</head>
<body>
<h2>Spring Form</h2>
<!-- 
<form id="pmemberVO" action="/member/registerForm01Post" method="post">
-->
<form:form modelAttribute="pmemberVO" method="post" action="/member/registerForm01Post">

	<p>
		<!-- path="id" => pmemberVO 객체의 멤버변수 -->
		<!-- 
		<input id="id" name="id" type="text" value="a001">		
		 -->
		유저 Id : <form:input path="id" /> 
		<form:hidden path="regno" /><!-- 1111111111118 -->
		<font color="red">
			<!-- form:errors => validation 시 오류발생 시 처리 -->
			<form:errors path="id" />
		</font>
	</p>
	<p>
		<!-- path="name" => pmemberVO 객체의 멤버변수 -->
		<!-- 
		<input id="name" name="name" type="text" value="개똥이">
		-->
		이름 : <form:input path="name" /> 
		<font color="red">
			<!-- form:errors => validation 시 오류발생 시 처리 -->
			<form:errors path="name" />
		</font>
	</p>
	<p>
		<!-- path="mail" => pmemberVO 객체의 멤버변수 -->
		<!-- 
		<input id="mail" name="mail" type="text" value="개똥이">
		-->
		E-MAIL : <form:input path="mail" /> 
		<font color="red">
			<!-- form:errors => validation 시 오류발생 시 처리 -->
			<form:errors path="mail" />
		</font>
	</p>
	<p>
		<!-- path="password" => pmemberVO 객체의 멤버변수 -->
		<!-- 
		<input id="password" name="password" type="password" value="java">
		-->
		비밀번호 : <form:password path="password" /> 
		<font color="red">
			<!-- form:errors => validation 시 오류발생 시 처리 -->
			<form:errors path="password" />
		</font>
	</p>
	<p>
		<!-- <textarea id="address" name="address"></textarea> -->
		소개 : 
		<form:textarea path="address"/>
	</p>
	<p>
		취미 :
		<!-- items : Model에 있는 속성의 값 -->
		<form:checkboxes items="${hobbyMap}" path="hobbyMap"/>
	</p>
	<p>
		성별 :
		<!-- path="gender"는 pmemberVO객체의 gender 멤버변수임 -->
		<form:radiobuttons items="${genderColdeMap}" path="gender"/>
	</p>
	<p>
		국적 : 
		<!-- path="nationality"는 pmemberVO객체의 nationality 멤버변수임 -->
		<form:select path="nationality" items="${nationalityMap}" />
	</p>
	<p>
		<h5>카드목록</h5>
		<div>
			<input type="text" name="cardVOList[0].no" placeholder="카드번호" />
			<input type="text" class="clsCard" name="cardVOList[0].validMonth" 
				placeholder="유효기간" />
		</div>
		<div>
			<input type="text" name="cardVOList[1].no" placeholder="카드번호" />
			<input type="text" class="clsCard" name="cardVOList[1].validMonth" 
				placeholder="유효기간" />
		</div>
	</p>
	<p>
		<form:button name="register">등록</form:button>
	</p>

</form:form>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<script type="text/javascript">
CKEDITOR.replace("address");  
</script>
</body>
</html>














