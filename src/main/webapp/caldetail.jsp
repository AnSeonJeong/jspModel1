<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");	
	if(login == null) {
		%>
	<script>
		alert('로그인 후 이용해주세요');
		location.href = "login.jsp"
	</script>
<%
	}
%>   

<%
	int seq = Integer.parseInt(request.getParameter("seq"));

	CalendarDao dao = CalendarDao.getInstance();
	CalendarDto dto = dao.getDay(seq);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>상세일정</h2>
	<hr>
	<div align="center">
		<table border="1">
			<col width="100">
			<col width="500">
			<tr>
				<th>아이디</th>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>일정</th>
				<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=dto.getContent() %></td>
			</tr>
		</table>
			<br>
			<button type="button" onclick="location.href='calendar.jsp'">목록</button>&nbsp;
			<button type="button" onclick="calUpdate(<%=dto.getSeq()%>)">수정</button>&nbsp;
			<button type="button" onclick="calDelete(<%=dto.getSeq()%>)">삭제</button>
	</div>
</body>
<script type="text/javascript">
function calUpdate(seq) {
	location.href = "calUpdate.jsp?seq=" + seq;
}

function calDelete(seq) {
	location.href = "calDelete.jsp?seq=" + seq;
}
</script>
</html>