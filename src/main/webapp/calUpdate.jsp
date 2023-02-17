<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberDto login = (MemberDto) session.getAttribute("login");
if (login == null) {
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
	<h2>일정 수정</h2>

	<div align="center">
		<form action="calUpdateAf.jsp?seq=<%=dto.getSeq() %>" method="post">
		<table border="1">
			<col width="100">
			<col width="500">
			<tr>
				<th>아이디</th>
				<td><%=dto.getId()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="title" value="<%=dto.getTitle()%>">
				</td>
			</tr>
			<tr>
				<th>일정</th>
				<td>
					<input type="date" id="date" name="date">&nbsp; 
					<inputtype="time" id="time" name="time"></td>
				</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="20" cols="50" name="content"><%=dto.getContent()%></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">수정하기</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>