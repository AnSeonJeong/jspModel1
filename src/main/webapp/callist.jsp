<%@page import="dto.MemberDto"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");

	String year = request.getParameter("year");
	String month = CalendarUtil.two(request.getParameter("month"));
	String day = CalendarUtil.two(request.getParameter("day"));
	
	String yyyymmdd = year + CalendarUtil.two(month+"") + CalendarUtil.two(day+"");
%>    
<%
	CalendarDao dao = CalendarDao.getInstance();
	
	List<CalendarDto> list = dao.getDayList(login.getId(), yyyymmdd);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2><%=year %>년 <%=month %>월 <%=day %>일 일정</h2>
	<div align="center">
		<table border="1">
			<col width="50">
			<col width="300">
			<tr>
				<th>일정</th>
				<th>제목</th>
				<%
					for(int i = 0; i < list.size(); i++) {
						CalendarDto dto = list.get(i);
				%>
			</tr>
			<tr>
				<%-- <td><%=CalendarUtil.toDates(dto.getRdate()) %></td> --%>
				<th><%=i+1 %></tdh>
				<td>
					<a href="caldetail.jsp?seq=<%=dto.getSeq() %>">
						<%=dto.getTitle() %></td>
					</a>
			</tr>
				<%
					}
				%>
		</table>
	</div>
</body>
</html>