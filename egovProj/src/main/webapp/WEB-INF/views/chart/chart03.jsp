<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>제이쿼리로 동적으로 생성된 버튼에 이벤트를 달아보자</title>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$("#firstButton").on("click",function(e){
			let bodyHtml = "<button id='secondButton'>두 번째 버튼(동적생성)</button>";
			
			//mainDiv 마지막 요소로 추가
			$("#mainDiv").append(bodyHtml);
		});
		
		// 두 번째 버튼 이벤트
		// 두 번째 버튼을 클릭하면 alert("개똥이");를 처리해보자
		$(document).on("click","#secondButton",function(){
			alert("개똥이");
		});

	});
</script>
<script type="text/javascript">
	//쉼표 문자열에서 최대값 구해보자
	let c_values = "500,200,600,700,100,300";
	
	let arr = c_values.split(",");
	let max = arr[0];
	for(let i=0; i<arr.length; i++){
		if(max < arr[i]){
			max = arr[i];
		}
	}
	
	alert("max : " + max);
	
	// 선생님
	c_values = "500,200,600,700,100,300";
	
	// map : 반복문을 돌며 배열 안의 요소들을 1대1로 짝지어 줌
	let values = c_values.split(",").map(str => Number(str));
	
	console.log("values : " + values);
	console.log("values.length : " + values.length);
	
	// reduce : 배열.reduce((누적값, 현재값, 인덱스,요소))
	// -Infinity : 초기값을 제공하지 않을 경우 배열의 첫 번째 요소를 사용함
	max = values.reduce(function(a,b){
		return Math.max(a,b);
	},-Infinity);
	
	alert("max : " + max);
</script>
</head>
<body>
	<div id="mainDiv">
		<button id="firstButton">첫 번째 버튼</button>
	</div>
</body>
</html>