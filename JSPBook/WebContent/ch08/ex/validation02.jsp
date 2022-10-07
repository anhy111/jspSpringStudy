<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	// 3연속 동일 및 3연속 연속성 체킹 결과
	let pw_passed = true;	// 통과
	
	function f_loginCheck() {
		let id = document.loginForm.id.value;
		let pw = document.loginForm.pw.value;
		let pwCheck = document.loginForm.pwCheck.value;
		pw_passed = true; // 통과
		
		if(id.length == 0){
			alert("아이디를 입력해주세요");
			return;
		}
		if(pw.length == 0){	
			alert("비밀번호를 입력해주세요");
			return;
		} else{
			if(pw != pwCheck){ 
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
		}
		
		let sameChar = 0;	// 동일문자 카운트
		let sequenceCount1 = 0; //연속성(+) 카운트
		let sequenceCount2 = 0; // 연속성(-) 카운트
		
		console.log("passwd : " + pw);
		
		for(let i=0; i<pw.length; i++){
			let char0;
			let char1;
			let char2;
			if(i >= 2){
				char0 = pw.charCodeAt(i-2);
				char1 = pw.charCodeAt(i-1);
				char2 = pw.charCodeAt(i);
				if(char0 == char2 && char1 == char2){
					sameChar++;
				} else {
					sameChar = 0;
				}
			}
			console.log(char0 +":"+ char1+ ":"+ char2+ "=>"+sameChar);
			console.log("=========================");
			
			// 연속성(+) 카운트
			if(char0 - char1 == 1 && char1-char2==1){
				sequenceCount1++;
			} else {
				sequenceCount1 = 0;
			}
			
			// 연속성(-) 카운트
			if(char0 - char1 == -1 && char1-char2 == -1){
				sequenceCount2++;
			} else {
				sequenceCount2 = 0;
			}
			console.log(sequenceCount1 + ":" + sequenceCount2);
			console.log("========================================");
			
			if(sameChar > 0){
				alert("동일문자 3자 이상 연속 입력할 수 없습니다.");
				pw_passed = false;
			}
			
			if(sequenceCount1 > 0 || sequenceCount2 > 0){
				alert("영문, 숫자는 3자 이상 연속 입력할 수 없습니다.");
				pw_passed = false;
			}
			
			if(!pw_passed){
				return false;
				break;
			}
		} //end for
		
	}
</script>
</head>
<body>
	<form name="loginForm" >
		<p>아이디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="text" name="pw"></p>
		<p>비밀번호 확인 : <input type="text" name="pwCheck"></p>
		<input type="button" value="전송" onclick="f_loginCheck()">
	</form>
</body>
</html>