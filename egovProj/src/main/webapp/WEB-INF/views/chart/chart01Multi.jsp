<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
$(function(){
	
	// 구글 차트 라이브러리 로딩(메모리에 올림)
	google.load("visualization","1",{
		"packages":["corechart"]
	});
	
	google.setOnLoadCallback(drawChart);
	google.setOnLoadCallback(drawChart2);
	
	function drawChart(){
		// responseText : json 데이터를 텍스트로 읽어들임.
		let jsonData = $.ajax({
			url:"/resources/json/sampleData.json",
			dataType:"json",
			async:false
		}).responseText;
	
		console.log("jsonData : " + jsonData);
		
		// 데이터 테이블 생성
		let data = new google.visualization.DataTable(jsonData);
		
		// 차트를 출력할 div 선택
		let chart = new google.visualization.ColumnChart(document.getElementById("chart_div"));
		//차트객체.draw(데이터테이블(data),옵션)
		chart.draw(data,{
			title:"이초딩 과일가게",
			width:600,
			height:450,
		});
	}
	
	function drawChart2(){
		// responseText : json 데이터를 텍스트로 읽어들임.
		let jsonData = $.ajax({
			url:"/resources/json/sampleData2.json",
			dataType:"json",
			async:false
		}).responseText;
	
		console.log("jsonData : " + jsonData);
		
		// 데이터 테이블 생성
		let data = new google.visualization.DataTable(jsonData);
		
		// 차트를 출력할 div 선택
		let chart = new google.visualization.LineChart(document.getElementById("chart_div2"));
		//차트객체.draw(데이터테이블(data),옵션)
		chart.draw(data,{
			title:"피자 토핑",
			curveType:"function",
			width:600,
			height:450,
		});
	}
});
</script>
<div id="chart_div"></div>
<div id="chart_div2"></div>
