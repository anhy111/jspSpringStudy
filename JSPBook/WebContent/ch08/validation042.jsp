<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	function checkKey() {
		console.log(event.keyCode);
		
		// event.keyCode>=48 && event.keyCode<=57 : 숫자키
		// !(event.keyCode>=48 && event.keyCode<=57) : 숫자키 이외의 키
		if(!(event.keyCode>=48 && event.keyCode<=57)){
			alert("숫자만 입력 가능합니다.");
			// event.returnValue : 입력받은 키 값의 반환 여부
			// false이면 입력란에 값이 입력이 안됨
			event.returnValue = false;
		}
	}
</script>
</head>
<body>
	<form name="frm">
		<p>나이 : <input type="text" name="age" onkeypress="checkKey()"/></p>
		<p><input type="button" value="전송" /></p>
	</form>
</body>
</html>