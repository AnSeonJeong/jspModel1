<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	
	BbsDao dao = BbsDao.getInstance();
	boolean isS = dao.deleteBbs(seq);
	
	if(isS) {
		%>    
			<script type="text/javascript">
				alert("글이 삭제 되었습니다");
				location.href = "bbslist.jsp";
			</script>
		<%
	} else {
		%>
			<script type="text/javascript">
				alert("다시 시도해 주십시오");
				let seq = "<%=seq %>";
				location.href = "bbsdetail.jsp?seq=" + seq;			
			</script>	
		<%
	}
%>