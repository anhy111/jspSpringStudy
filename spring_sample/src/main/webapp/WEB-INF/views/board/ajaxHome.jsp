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
		
		//JSON 데이터
		let boardObject = {
				boardNo:boardNoVal,
				title:titleVal,
				content:contentVal,
				writer:writerVal
		};
		//boardObject : {"boardNo":"1","title":"2","content":"3","writer":"4"}
		console.log("boardObject : " + JSON.stringify(boardObject));
		
		//아작났어유..피씨다타써
		//url : 요청경로, 
		//contentType : 보내는 데이터의 타입
		//dataType : 응답 데이터 타입
		//data : 요청 시 전송할 데이터
		//type : get, post, put
		// /board/100
		$.ajax({
			url:"/board/"+boardNoVal,
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(boardObject),
			type:"put",
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









