<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" 
src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
//구글 차트 라이브러리를 로딩
google.load("visualization","1",{"packages":["corechart"]});

//불러오는 작업이 완료되어 로딩이 되었다면 drawChart() 함수를 호출하는 콜백이 일어남
google.setOnLoadCallback(drawChart);
google.setOnLoadCallback(drawChart2);
google.setOnLoadCallback(drawChart3);

//콜백함수
function drawChart(){
	//아작났어유
	//dataType : 응답데이터의 형식
	//contentType : 보내는데이터의 형식
	//sync : 동기 / async : 비동기
	let jsonData = $.ajax({
		url:"/resources/json/simpleData.json",
		dataType:"json",
		async:false
	}).responseText;
	
	console.log("jsonData : " + jsonData);
	//구글 차트용 데이터 테이블 생성
	let data = new google.visualization.DataTable(jsonData);
	
	//어떤 차트 모양으로 출력할지를 정해주자 => LineChart
	//LineChart , ColumnChart, PieChart, AreaChart, ScatterChart
	let chart = new google.visualization.ScatterChart(
		document.getElementById("chart_div")		
	);
	
	//data 데이터를 chart 모양으로 출력해보자
	chart.draw(data,
		{
			title:"차트 예제",
			width:500,
			height:400
		}		
	);
}

//콜백함수2
function drawChart2(){
	//아작났어유
	//dataType : 응답데이터의 형식
	//contentType : 보내는데이터의 형식
	//sync : 동기 / async : 비동기
	let jsonData = $.ajax({
		url:"/resources/json/simpleData2.json",
		dataType:"json",
		async:false
	}).responseText;
	
	console.log("jsonData : " + jsonData);
	//구글 차트용 데이터 테이블 생성
	let data = new google.visualization.DataTable(jsonData);
	
	//어떤 차트 모양으로 출력할지를 정해주자 => LineChart
	//LineChart , ColumnChart, PieChart
	let chart = new google.visualization.LineChart(
		document.getElementById("chart_div2")		
	);
	
	//data 데이터를 chart 모양으로 출력해보자
	chart.draw(data,
		{
			title:"차트 예제",
			width:500,
			height:400
		}		
	);
}

//콜백함수3
function drawChart3(){
	//아작났어유
	//dataType : 응답데이터의 형식
	//contentType : 보내는데이터의 형식
	//sync : 동기 / async : 비동기
	let jsonData = $.ajax({
		url:"/resources/json/simpleData2.json",
		dataType:"json",
		async:false
	}).responseText;
	
	console.log("jsonData : " + jsonData);
	//구글 차트용 데이터 테이블 생성
	let data = new google.visualization.DataTable(jsonData);
	
	//어떤 차트 모양으로 출력할지를 정해주자 => LineChart
	//LineChart , ColumnChart, PieChart
	let chart = new google.visualization.LineChart(
		document.getElementById("chart_div3")		
	);
	
	//data 데이터를 chart 모양으로 출력해보자
	chart.draw(data,
		{
			title:"차트 예제",
			width:500,
			height:400
		}		
	);
}
</script>

<div class="row">
   <div class="col-xl-8 col-lg-7">
       <!-- Area Chart -->
       <div class="card shadow mb-4">
           <div class="card-header py-3">
               <h6 class="m-0 font-weight-bold text-primary">과일 가격</h6>
           </div>
			<!-- 구글 차트가 보여질 영역 -->
           <div id="chart_div"></div>
       </div>
       <div class="card shadow mb-4">
           <div class="card-header py-3">
               <h6 class="m-0 font-weight-bold text-primary">채소 가격</h6>
           </div>
			<!-- 구글 차트가 보여질 영역 -->
           <div id="chart_div2"></div>
       </div>
       <div class="card shadow mb-4">
           <div class="card-header py-3">
               <h6 class="m-0 font-weight-bold text-primary">채소 가격</h6>
           </div>
			<!-- 구글 차트가 보여질 영역 -->
           <div id="chart_div3"></div>
       </div>
	</div>
</div>


