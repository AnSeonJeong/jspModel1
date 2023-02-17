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
	String id = login.getId();
	int seq = Integer.parseInt(request.getParameter("seq"));

	CalendarDao dao = CalendarDao.getInstance();
	boolean isS = dao.deleteCalendar(id, seq);
	if(isS) {
		%>     
		<script type="text/javascript">
			alert("일정이 삭제되었습니다");
			location.href = "calendar.jsp";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("일정이 삭제되지 않았습니다");
			location.href = "caldetail.jsp?seq=" + <%=seq %>;
		</script>
		<%
	}
%>