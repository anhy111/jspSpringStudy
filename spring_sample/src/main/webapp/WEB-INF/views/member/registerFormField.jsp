<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>(p.156) 7.폼 방식 요청 처리</title>
</head>
<body>
<form action="/member/registerFormFieldPost" method="post">
	<p>
		<!-- 문자열 타입 매개변수(파라미터를 받아주는 변수)로 처리 => String userId -->
		<!-- Map 타입 매개변수로 처리 => Map<String, Object> map -->
		<!-- 자바빈즈 매개변수로 처리 => MemberVO memberVO -->
		userId : <input type="text" name="userId" value="a001" />
	</p>
	<p>
		<!-- 문자열 타입 매개변수(파라미터를 받아주는 변수)로 처리 => String password -->
		<!-- Map 타입 매개변수로 처리 => Map<String, Object> map -->
		<!-- 자바빈즈 매개변수로 처리 => MemberVO memberVO -->
		password : <input type="password" name="password" value="java" />
	</p>
	<p>
		<!-- 문자열 타입 매개변수(파라미터를 받아주는 변수)로 처리 => String gender -->
		<!-- Map 타입 매개변수로 처리 => Map<String, Object> map -->
		<!-- 자바빈즈 매개변수로 처리 => MemberVO memberVO -->
		gender : 
		<input type="radio" name="gender" id="gender1" value="male" checked />
		<label for="gender1">Male</label><br />
		<input type="radio" name="gender" id="gender2" value="female" />
		<label for="gender2">Female</label><br />
		<input type="radio" name="gender" id="gender3" value="other" />
		<label for="gender3">Other</label><br />
	</p>
	<p>
		<!-- 문자열 타입 매개변수(파라미터를 받아주는 변수)로 처리 => String gender -->
		<!-- Map 타입 매개변수로 처리 => Map<String, Object> map -->
		<!-- 자바빈즈 매개변수로 처리 => MemberVO memberVO -->
		nationality :
		<select name="nationality">
			<option value="Korea" selected>대한민국</option>
			<option value="Germany" >독일</option>
			<option value="Australia" >호주</option>
			<option value="Canada" selected>캐나다</option>
		</select>
	</p>
	<p>
		<!-- 문자열 배열 타입 매개변수로 처리 -->
		car :
		<select name="carArray" multiple>
			<option value="volvo" selected>Volvo</option>
			<option value="saab">Saab</option>
			<option value="opel">Opel</option>
			<option value="audi">Audi</option>
		</select>
	</p>
	<p>
		<!-- 문자열 타입 매개변수로 처리 => String developer -->
		developer : 
		<input type="checkbox" name="developer" value="Y" />
	</p>
	<p>
		<!-- 불리언 타입 매개변수로 처리 => boolean foreigner -->
		<!-- value를 true로 초기화 해야 함 -->
		foreigner : 
		<input type="checkbox" name="foreigner" value="true" />
	</p>
	<p>
		<!-- 자바빈즈 매개변수로 처리 -->
		postCode : <input type="text" name="postCode" value="12345" /><br />
		location : <input type="text" name="location" value="대전 중구" /><br />
	</p>
	<p>
		address.postCode : <input type="text" name="address.postCode" value="67890" /><br />
		address.location : <input type="text" name="address.location" value="서울 강남구" /><br />
	</p>
	<p>
		카드1-번호 : <input type="text" name="cardList[0].no" value="11111" /><br />
		카드1-유효년월: <input type="text" name="cardList[0].validMonth" value="20251210" /><br />
		카드2-번호 : <input type="text" name="cardList[1].no" value="22222" /><br />
		카드2-유효년월: <input type="text" name="cardList[1].validMonth" value="20291213" /><br />
	</p>
	<p>
		<!-- 문자열 타입 매개변수(파라미터를 받아주는 변수)로 처리 => String gender -->
		<!-- Map 타입 매개변수로 처리 => Map<String, Object> map -->
		<!-- 자바빈즈 매개변수로 처리 => MemberVO memberVO -->
		introduction :<br />
		<textarea name="introduction" rows="6" cols="50">개똥이</textarea>
	</p>
	<p>
		<!-- Date 타입 매개변수로 처리 => yyyy/MM/dd 형식으로 지정해야 함 -->
		dateOfBirth : <input type="date" name="dateOfBirth" /><br />
	</p>
	<p>
		<input type="submit" value="전송" />
	</p>
</form>
</body>
</html>









