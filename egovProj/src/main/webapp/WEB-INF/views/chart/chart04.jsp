<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<html>
<head>
<title>javascript sessionStorage</title>
<script type="text/javascript">
/*
 sessionStorage : 쿠키 대신 사용하는.. 임시적으로 데이터를 공유할 수 있음
          브라우저의 탭 별로 데이터를 관리할 수 있고 탭이 닫혔을 때 모든 데이터는 삭제 됨
 */
   sessionStorage.setItem("key1", 10);
   sessionStorage.setItem("key2", new Date());
   console.log("저장된 데이터의 개수 : " + sessionStorage.length);
   
//    sessionStorage.removeItem("key1");//key1에 해당하는 값 삭제
//    console.log("저장된 데이터의 개수 : " + sessionStorage.length);

//    sessionStorage.clear();//모든 데이터 삭제
//    console.log("저장된 데이터의 개수 : " + sessionStorage.length);
</script>

</head>
<body>
<%
for(int i=0;i<50;i++){
   out.print("<p>월드컵" + i + "</p>");
}
%>
<script type="text/javascript">
   let key1 = sessionStorage.getItem("key1");
   
   console.log("key1 : " + key1);
</script>
<%
for(int i=0;i<50;i++){
   out.print("<p>월드컵" + i + "</p>");
}
%>
<script type="text/javascript">
   let key2 = sessionStorage.getItem("key2");
   
   console.log("key2 : " + key2);
</script>
</body>
</html>
