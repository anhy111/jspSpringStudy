<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>객체 배열 타입의 JSON 데이터</title>
<script type="text/javascript">
$(function(){
	$("#registerBtn07").on("click",function(){
		//배열 타입의 JSON 데이터
		//중첩된(nested) 객체 타입의 JSON 요청 데이터
		//List => []
		let data1 = new Date("2022-01-01");
		let data2 = new Date("2022-02-01");
		let data3 = new Date("2022-03-01");
		let data4 = new Date("2022-04-01");
		
		let userObjectArray = [
			{userId:"a001",password:"java",address:{postCode:"12345",location:"대전"},
				cardList:[{no:"1111",validMonth:"2022-01-01",validMonth2:"202209"},{no:"2222",validMonth:data2,validMonth2:"202210"}]},
			{userId:"b001",password:"java",address:{postCode:"67890",location:"서울"},
				cardList:[{no:"3333",validMonth:data3,validMonth2:"202211"},{no:"5555",validMonth:data4,validMonth2:"202212"}]}
		];
		
		//아작났어.유.피씨다탔어.에..
		//contentType : 보내는타입
		//dataType : 응답데이터타입
		$.ajax({
			url:"/member/ajaxArrayFormPost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(userObjectArray),
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
<!-- button, submit, reset -->
<button type="button" id="registerBtn07">객체 배열 타입의 JSON 데이터 요청</button>
</body>
</html>







