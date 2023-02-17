<%@page import="dto.CalendarDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.CalendarDao"%>
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
	request.setCharacterEncoding("utf-8");

	int seq = Integer.parseInt(request.getParameter("seq"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String date = request.getParameter("date");
	String time = request.getParameter("time");

	String datesplit[] = date.split("-");
	String year = datesplit[0];
	String month = datesplit[1];
	String day = datesplit[2];
	
	String timesplit[] = time.split(":");
	String hour = timesplit[0];
	String min = timesplit[1];
	
	String rdate = year + month + day + hour + min;

	CalendarDao dao = CalendarDao.getInstance();
	boolean isS = dao.updateCalendar(seq, title, rdate, content);
	if(isS) {
		%>     
		<script type="text/javascript">
			alert("일정이 수정되었습니다");
			location.href = "calendar.jsp";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("일정이 수정되지 않았습니다");
			location.href = "calUpdate.jsp?seq=" + <%=seq %>;
		</script>
		<%
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>