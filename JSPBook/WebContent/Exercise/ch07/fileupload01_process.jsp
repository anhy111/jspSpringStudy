<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multipartRequest =
	 						new MultipartRequest(request,"C:\\upload",10*1024*1024,"utf-8",policy);
	
//	String file = (String)multipartRequest.getFileNames().nextElement();
	Enumeration params = multipartRequest.getFileNames();
	// 폼 필드 내에 객체가 있을때까지 반복
	// params : <input type="file" name="file1">
	while(params.hasMoreElements()){
		String file = (String)params.nextElement();
		
		String originName = multipartRequest.getOriginalFileName(file);
		String saveName = multipartRequest.getFilesystemName(file);
		String type = multipartRequest.getContentType(file);
		File files = multipartRequest.getFile(file);
%>
		<p> 요청 파라미터 이름: <%=file %></p>
		<p> 실제 파일 이름: <%=originName %></p>
		<p> 저장 파일 이름: <%=saveName %></p>
		<p> 파일 컨턴츠 유형: <%=type %></p>
<%
		if(files != null){
			out.print("<p>파일크기 : " + files.length() + "</p>");
		}
	}
	
	
%>