<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	function checkForm() {
		// 숫자 여부는 isNaN() 함수를 활용하여 검사
		// isNan : is Not a Number의 약자
		// 숫자면 false, 숫자가 아니면 true
		let val = "개똥이";
		let val2 = 23;
		let val3 = document.frm.name.value;
		
		console.log(isNaN(val));	// true
		console.log(isNaN(val2));	// false	
		console.log(isNaN(val3));	// true
		
		// 이름은 숫자로 시작할 수 없다 => 이름은 문자여야 함
		// !isNan(3) => true
		if(!isNaN(val3.substr(0,1))){
			alert("이름은 숫자로 시작할 수 없습니다.");
			document.frm.name.focus();
		}
	}
</script>
</head>
<body>
	<form name="frm">
		<p>이름 : <input type="text" name="name" /></p>
		<p><input type="button" value="전송" onclick="checkForm()" /></p>
	</form>
</body>
</html>