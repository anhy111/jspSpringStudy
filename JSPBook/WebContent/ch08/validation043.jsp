<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	function checkLogin() {
		let form = document.loginForm;
		// 아이디에 입력된 값의 길이
		let idLen = form.id.value.length;
		
		console.log("idLen : " + idLen);
		
		// 1) 아이디는 영문 소문자만 입력 가능
		// 1-1)아이디에 입력된 값의 글자수만큼 반복
		for(let i=0; i<idLen; i++){
			// charAt(i) : i번쨰 글자 한개 추출
			let ch = form.id.value.charAt(i);
			
			if((ch < 'a' || 'z' < ch) && (ch>'A' || ch<'Z') && ('0'<ch || '9' < ch)){
				alert("아이디는 영문 소문자만 입력 가능합니다.");
				form.id.focus();
				return;
			}
		}
		// 2) 비밀번호는 숫자만 입력 가능
		if(isNaN(form.passwd.value)){
			alert("비밀번호는 숫자만 입력 가능합니다.");
			form.passwd.focus();
			return;
		}
		
		form.submit();
	}
</script>
</head>
<body>
	<form name="loginForm" action="validation043_process.jsp"
		method="post">
		<p>아이디 : <input type="text" name="id" /></p>
		<p>비밀번호 : <input type="password" name="passwd"/></p>
		<p><input type="button" value="검사하기" onclick="checkLogin()" /></p>
	</form>
</body>
</html>