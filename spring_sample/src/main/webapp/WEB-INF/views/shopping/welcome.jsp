<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Welcome</title>
</head>
<body>
	<!-- ----------------- menu.jsp 시작 ------------------ -->
	<%@ include file="menu.jsp" %>
	<!-- ----------------- menu.jsp 끝 ------------------ -->
	<%! //선언문(전역변수)
		String greeting = "웹 쇼핑몰에 오신 것을 환영합니다.";
		String tagline = "Welcome to 오세영 Market!";
	%>
	<div class="jumbotron">
		<!-- container : 내용이 들어갈 때 -->
		<div class="container">
			<h1 class="display-3"><%=greeting%></h1>
		</div>
	</div>
	<!-- container : 내용이 들어갈 때 -->
	<div class="container">
		<!-- 내용을 중간 정렬 -->
		<div class="text-center">
			<h3><%=tagline%></h3>
			<%
				//5초마다 페이지를 갱신(새로고침).
				response.setIntHeader("Refresh", 5);
				Date day = new Date();
				//지역변수 선언
				String am_pm;
				int hour = day.getHours();
				int minute = day.getMinutes();
				int second = day.getSeconds();
				
				if(hour/12==0){	//0~11 => 0. 정수/정수 => 정수	
					am_pm = "AM";
				}else{	//12 ~ 24 => 1 또는 2가 되서 
					am_pm = "PM";
					//13~23시이면 1~11시로 표현
					hour = hour - 12;
				}
				String CT = hour + ":" + minute + ":" + second + " " + am_pm;
				out.print("현재 접속 시각 : " + CT + "<br />");
			%>
		</div>
	</div>
	<!-- footer : 맨 하단에 들어가는 영역 -->
	<!-- ------------- footer.jsp 시작 ------------ -->
	<%@ include file="footer.jsp" %>
	<!-- ------------- footer.jsp 끝 ------------ -->
</body>
</html>



