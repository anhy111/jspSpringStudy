<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>Ajax 방식 요청 처리 연습</title>
<script type="text/javascript">
$(function(){
	$("#registerBtn01").on("click",function(){
		alert("개똥이");
		//result => "SUCCESS"
		$.get("/member/ajaxRegister/hongkd",function(result){
			console.log("result : " + result);
			if(result=="SUCCESS"){
				alert("개똥이 성공!")
			}
		});
	});
	
	$("#registerBtn02").on("click",function(){
		alert("개똥이");
		let userId = $("#userId");
		let password = $("#password");
		let userIdVal = userId.val();
		let passwordVal = password.val();
		//json형식
		let userObject = {userId:userIdVal,password:passwordVal};
		//result => "SUCCESS"
		//contentType : 보내는 타입
		//dataType : 응답 타입
		//아작났어.유~ 피씨다타써.어..ㅠㅠ
		//board게시판의 127번째글
		$.ajax({
			url:"/member/ajaxRegister/board/127?userId="+userIdVal+"&password="+passwordVal,
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(userObject),
			type:"post",
			success:function(result){
				console.log("result : " + result);
				if(result=="SUCCESS"){
					alert("SUCCESS");
				}
			}
		});
	});
});
</script>
</head>
<body>
<input type="text" name="userId" id="userId" /><br />
<input type="password" name="password" id="password" /><br />
<button type="button" id="registerBtn01">
	PathVariable 애너테이션을 지정하여 문자열 매개변수로 처리
</button>
<button type="button" id="registerBtn02">
	PathVariable 애너테이션을 지정하여 여러 개의 문자열 매개변수로 처리
</button>
</body>
</html>




