<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>마이클잭슨을 기리며..</title>
<script type="text/javascript">
$(function(){
	$("#btnSubmit").on("click",function(){
		alert("왔다");
		let boardNoVal = $("#boardNo").val();
		let titleVal = $("#title").val();
		let contentVal = $("#content").val();
		let writerVal = $("#writer").val();
		
		//XML 데이터
		let xmlData = "<Board>";
				xmlData += "<boardNo>"+boardNoVal+"</boardNo>"; 
				xmlData += "<title>"+titleVal+"</title>";
				xmlData += "<content>"+contentVal+"</content>";
				xmlData += "<writer>"+writerVal+"</writer>";
				xmlData += "<regDate>2022-07-26</regDate>";
		xmlData    += "</Board>";
		
		//boardObject : {"boardNo":"100","title":"2","content":"3","writer":"4"}
		console.log("xmlData : " + xmlData);
		
		//아작났어유..피씨다타써
		//url : 요청경로, 
		//contentType(헤더안에 있는 속성) : 보내는 데이터의 타입
		//dataType : 응답 데이터 타입
		//data : 요청 시 전송할 데이터
		//type : get, post, put
		// /board/100
		$.ajax({
			url:"/board/"+boardNoVal,
			contentType:"application/xml;charset=utf-8",
			data:xmlData,
			type:"post",
			success:function(result){
				console.log("result : " + result);	
			}		
		});
	});
});
</script>
</head>
<body>
	<form>
		<p><input type="text" name="boardNo" id="boardNo" /></p>
		<p><input type="text" name="title" id="title" /></p>
		<p>
			<textarea rows="3" cols="5" name="content" id="content"></textarea>
		</p>
		<p><input type="text" name="writer" id="writer" /></p>
		<p><input type="button" id="btnSubmit" value="전송" /></p>
	</form>
</body>
</html>









