<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Headers 매핑</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button").on("click",function(){
			let boardNoVal = 7;
			let boardObject = {
					"boardNo":"7",
					"title":"개똥이 수리남가다",
					"content":"식사는 잡쉇니?",
					"writer":"개똥이"
			};
			
			$.ajax({
				url:"/board/"+boardNoVal,
				contentType: "application/json;charset=utf-8",
				data: JSON.stringify(boardObject),
				type:"put",
				success:function(result){
					console.log("result:",result);
				}
			});
		}); // end button click
		
		$("input[name='btnAccept']").on("click",function(){
			let boardNo = $("#boardNo").val();
			
			console.log("boardNo : " + boardNo);
			
			// get방식으로 /board/7로 요청
			// json데이터로 비동기 응답
			$.get("/board/"+boardNo,function(data){
				console.log("data : ",JSON.stringify(data));
			});
		}); // end btnAccept click
		
		$("input[name='btnJson']").on("click",function(){
			let boardNo = $("#boardNo").val();
			
			console.log("boardNo : " + boardNo);
			
			let data = {
					"boardNo" : boardNo
			};
			
			$.ajax({
				url: "/board/getBook",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				type:"post",
				success:function(result){
					// result는 bookVO => JSON으로 변환됨
					console.log(JSON.stringify(result));
				}
			});
		}); // end btnJson click
	});// end document upload
</script>
</head>
<body>
	<h2>Headers 매핑</h2>
	<button type="button">식사는 잡쉈니?</button>
	<h2>7.Accept 매핑</h2>
	<p><input type="text" name="boardNo" id="boardNo" value="7" /></p>
	<p><input type="button" name="btnAccept" value="실행" /></p>
	<p><input type="button" name="btnJson" value="ajax로실행" /></p>
</body>
</html>