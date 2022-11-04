<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<title>Spring Form</title>
<script type="text/javascript">
	$(function(){
		CKEDITOR.replace("introduction");
	});
</script>
</head>
<body>
	<!-- modelAttribute 속성에 폼 객체의 속성명을 지정함 -->
	<!-- 폼 객체의 속성 명(model.addAttribute("member",new MemVO()))
			과 스프링 폼 태그의 modelAttribute 속성값은 일치해야 한다 -->
	<form:form modelAttribute="memVO" method="post" action="/form/register">
		<table>
			<tr>
				<th><form:label path="memId">유저ID</form:label></th>
				<td>
					<!-- path:memId => name 과 id 자동생성 -->
					<form:input path="memId"/>
					<font color="red"><form:errors  path="memId"/></font>
				</td>
			</tr>
			<tr>
				<th><form:label path="memName">이름</form:label> </th>
				<td>
					<form:input path="memName"/>
					<font color="red"><form:errors path="memName" /></font>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<form:password path="memPass"/>
					<font color="red"><form:errors path="memPass" /></font>
				</td>
			</tr>
			<tr>
				<th>소개</th>
				<td>
					<form:textarea path="introduction" rows="6" cols="30"/>
					<font color="red"><form:errors path="introduction" /></font>
				</td>
			</tr>
			<tr>
				<th>취미(hobbyList)</th>
				<td>
					<form:checkboxes path="hobbyList" items="${hobbyMap}"/>
				</td>
			</tr>
			<tr>
				<th>개발자여부</th>
				<td>
					<form:checkbox path="developer" value="Y"/>
				</td>
			</tr>
			<tr>
				<th>외국인여부</th>
				<td>
					<form:checkbox path="foreigner" value="false"/>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<form:radiobuttons path="gender" items="${genderMap}"/>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<th>성별</th> -->
<!-- 				<td> -->
<%-- 					<form:radiobutton path="gender" value="Male" label="Male"/> --%>
<%-- 					<form:radiobutton path="gender" value="Female" label="Female"/> --%>
<%-- 					<form:radiobutton path="gender" value="Other" label="Other"/> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>국적</th> -->
<!-- 				<td> -->
<%-- 					<form:select path="nationality" items="${nationalityMap}"/> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<th>국적</th>
				<td>
					<select id="nationality" name="nationality">
						<option value="Korea">Korea</option>
						<option value="Germany">Germany</option>
						<option value="Australia">Australia</option>
					</select>
				</td>
			</tr>
		</table>
		<form:button name="register">등록</form:button>
	</form:form>
</body>
</html>