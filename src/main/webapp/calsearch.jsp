<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null) {
	choice = "";
}
if(search == null) {
	search = "";
}

List<CalendarDto> searchlist = CalendarDao.getInstance().getCalSearchList(choice, search);
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div></div>
</body>
</html>