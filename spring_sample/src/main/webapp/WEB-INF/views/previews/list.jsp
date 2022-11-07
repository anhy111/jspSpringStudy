<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
<div class="bd-example">
  <table class="table table-striped">
      <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">회원번호</th>
	      <th scope="col">회원ID</th>
	      <th scope="col">회원명</th>
	      <th scope="col">첨부파일</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="mem" items="${memVOList}" varStatus="stat">
		    <tr>
		      <th scope="row">${stat.count}</th>
		      <td>${mem.userNo}</td>
		      <td>${mem.userId}</td>
		      <td>${mem.userName}</td>
			  <td>
			  <c:forEach var="attachVO" items="${mem.attachVOList}">
			  	<c:if test="${attachVO.filename!=null}">
			  		<img src="/resources/images/file.png" width="30px" 
			  			onclick="fn_download('${attachVO.filename}')" style="cursor: pointer;"/>
			  	</c:if>
			  </c:forEach>
			  </td>      
		    </tr>
	    </c:forEach>
	  </tbody>
  </table>
</div>
<iframe id="ifrm" name="ifrm" style="display: none;" ></iframe>
<script type="text/javascript">
	function fn_download(param){
		let vIfrm = document.getElementById("ifrm");
		
		vIfrm.src = "/upload/download?fileName="+param;
	}
</script>
</body>
</html>