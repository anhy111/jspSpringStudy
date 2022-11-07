<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title></title>
<script type="text/javascript">
$(function(){
	// json 데이터를 읽어와보자
	// 달러.each(collection, function(index In Array, value Of Element){...});
	// collection => array, List, Map, Object, ArrayList
	// index In Array => 키(인덱스)
	// value Of Element => 값
	$("#btnJson").on("click",function(e){
		$.ajax({
			url:"/member/read03Post",
			type:"post",
			success:function(result){
				//List<PmemberVO> pmemberVOList = new ArrayList<PmemberVO>();
				/*
				 [{"id":"a001","password":null,"name":"개똥이"},
				  {"id":"b001","password":null,"name":"개진순"}]
				*/
				console.log("result : " + JSON.stringify(result));
				$.each(result, function(i, v){
					console.log(v.id);
					console.log(v.name);
				});
			}
		});
	});
});
</script>
</head>
<body>
<button type="button" id="btnJson">
/member/read03Post
</button>
<!-- 
List : ArrayList, vector, LinkedList
Set : HashSet, TreeSet 
Map : HashMap, HashTable, TreeMap
-->
<!-- String[] carArray = {"saab","audi"} -->
<c:forEach var="row" items="${carArray}">
  <p>${row}</p>
</c:forEach>
<!-- 
List<String> carList = new ArrayList<String>();
carList.add("제네시스");
carList.add("티볼리");
 -->
<c:forEach var="row" items="${carList}">
  <p>${row}</p>
</c:forEach> 
<!-- 
List<PmemberVO> pmemberVOList = new ArrayList<PmemberVO>();
PmemberVO pmemberVO = new PmemberVO();
-->
<c:forEach var="row" items="${pmemberVOList}">
  <p>${row.id}</p>
  <p>${row.name}</p>
</c:forEach> 
</body>
</html>






