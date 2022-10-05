<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="bookmarket.dao.BookRepository"%>
<%@page import="bookmarket.dto.Book"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String fileUploadPath = request.getServletContext().getRealPath("\\") + "\\resources\\images";
	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(1000000); // 최대 크기(1Mb)
	upload.setSizeThreshold(4096); // 메모리상에 저장할 최대 크기
	upload.setRepositoryPath(fileUploadPath); // 업로드된 파일을 임시로 저장할 경로
	
	List items = upload.parseRequest(request);
	Iterator params = items.iterator();
	Book book = new Book();
	while(params.hasNext()){
		FileItem fileItem = (FileItem)params.next();
		if(fileItem.isFormField()){	// 일반데이터라면..(name, subject)
			String name = fileItem.getFieldName();	
			switch(name){
			case "bookId":
				book.setBookId(fileItem.getString("UTF-8"));
				break;
			case "name":
				book.setName(fileItem.getString("UTF-8"));
				break;
			case "unitPrice":
				book.setUnitPrice(Integer.parseInt(fileItem.getString("UTF-8")));
				break;
			case "author":
				book.setAuthor(fileItem.getString("UTF-8"));	
				break;
			case "description":
				book.setDescription(fileItem.getString("UTF-8"));
				break;
			case "publisher":
				book.setPublisher(fileItem.getString("UTF-8"));
				break;
			case "category":
				book.setCategory(fileItem.getString("UTF-8"));
				break;
			case "unitsInStock":
				book.setUnitsInStock(Long.parseLong(fileItem.getString("UTF-8")));
				break;
			case "totalPages":
				book.setTotalPages(Long.parseLong(fileItem.getString("UTF-8")));
				break;
			case "releaseDate":
				book.setReleaseDate(fileItem.getString("UTF-8"));
				break;
			case "condition":
				book.setCondition(fileItem.getString("UTF-8"));
				break;
			}
			
			
		} else{	// 일반 데이터가 아니면 파일 일것임
			String fileFieldName = fileItem.getFieldName(); 
			String contentType = fileItem.getContentType(); 
			long fileSize = fileItem.getSize(); 
			
			String fileName = fileItem.getName();
			fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
			File file = new File(fileUploadPath + "/" + fileName);
			fileItem.write(file);		
			
			out.println("-----------------------------<br>");
			out.print("요청 파라미터 이름 : " + fileFieldName + "<br>");
			out.print("저장 파일 이름 : " + fileName + "<br>");
			out.print("파일 콘텐츠 타입 : " + contentType + "<br>");
			out.print("파일 크기 : " + fileSize);
			book.setFileName(fileName);
		}
	}
	
	BookRepository.getInstance().addBook(book);
	response.sendRedirect("books.jsp");
%>