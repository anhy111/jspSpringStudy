<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="ch04.vo.ProductVO"%>
<%@page import="ch04.dao.ProductRepository"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	// 폼 페이지에서 입력된 데이터를 서버(톰캣)로 전송 시 한글이 깨지지 않도록 하자
	request.setCharacterEncoding("UTF-8");
	
	// 1) 어디에 저장할 것인가?
	String path = "C:\\Users\\PC-18\\git\\jspSpringStudy\\JSPBook\\WebContent\\resources\\images";
	// 2) 파일 업로드 객체 생성
	DiskFileUpload upload = new DiskFileUpload();
	// 3) 환경설정 (byte)
	upload.setFileSizeMax(1024*1024);
	upload.setSizeThreshold(4*1024); // 메모리 최대 크기(4M)
	upload.setRepositoryPath(path); // 임시 저장 경로
	// 4) 폼 페이지의 item 받아오기
	List items = upload.parseRequest(request);
	// 5) 열거형 타입으로 변환
	Iterator params = items.iterator();

	ProductRepository dao = ProductRepository.getInstance();
	
	String productId = "";
	String pname = "";
	String description = "";
	String manufacturer = "";
	String category = "";
	String condition = "";
	// 업로드 파일 명
	String fileName = "";
	int price = 0;
	int stock = 0;
	
	// 6) 요청 파라미터가 없을 때까지 반복
	while(params.hasNext()){
		FileItem item = (FileItem)params.next();
		
		// Spring 프레임워크에서는 MultipartFile로 쉽게 처리됨
		if(item.isFormField()){	// 6-1) 일반 데이터
			// 6-1-1) 파라미터의 이름 가져오기
			if(item.getFieldName().equals("productId")){
				// 6-1-2) 파라미터의 값 가져오기
				productId = item.getString("UTF-8");
			} else if(item.getFieldName().equals("pname")){
				pname = item.getString("UTF-8");
			} else if(item.getFieldName().equals("unitPrice")){
				String unitPrice = item.getString("UTF-8");
				if(unitPrice.isEmpty()){
					price = 0;
				} else {
					price = Integer.parseInt(unitPrice);
				}
			} else if(item.getFieldName().equals("description")){
				description = item.getString("UTF-8");
			} else if(item.getFieldName().equals("manufacturer")){
				manufacturer = item.getString("UTF-8");
			} else if(item.getFieldName().equals("category")){
				category = item.getString("UTF-8");
			} else if(item.getFieldName().equals("unitsInStock")){
				String unitsInStock = item.getString("UTF-8");
				if(unitsInStock.isEmpty()){
					stock = 0;
				} else{
					stock = Integer.parseInt(unitsInStock);
				}
			} else if(item.getFieldName().equals("condition")){
				condition = item.getString("UTF-8");
			}
			
		} else{ // 6-2) 파일 데이터
			// <input type="file" name="productImage" class="form-control" />
			String fileFieldName = item.getFieldName(); // 요청 파라미터명(productImage)
			fileName = item.getName(); 	// 저장파일명(mouse01.png)
			String contentType = item.getContentType(); // images/jpeg
			// 순수한 파일명만 추출
			fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
			long fileSize = item.getSize();
			// 파일 객체 생성(copy 설계)
			File file = new File(path + "/" + fileName);
			// copy 실행
			item.write(file);
			
			out.println("----------------------------<br>");
			out.print("요청 파라미터 명: " + fileFieldName + "<br>");
			out.print("저장 파일 명: " + fileName + "<br>");
			out.print("파일 콘텐츠 타입: " + contentType + "<br>");
			out.print("파일 크기: " + fileSize + "<br>");
		} // end else
	} // end while
	
	ProductVO productVO = new ProductVO();
	productVO.setProductId(productId);
	productVO.setPname(pname);
	productVO.setUnitPrice(price);
	productVO.setDescription(description);
	productVO.setManufacturer(manufacturer);
	productVO.setCategory(category);
	productVO.setUnitsInStock(stock);
	productVO.setCondition(condition);
	productVO.setFileName(fileName);
	

	// insert into product values(......)
	dao.addProduct(productVO);
	
	out.print("productVO"+productVO);
	response.sendRedirect("products.jsp");
%>

