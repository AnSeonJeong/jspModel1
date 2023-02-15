<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int seq = Integer.parseInt(request.getParameter("seq"));
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null){
		%>
		<script>
		alert('로그인 해 주십시오');
		location.href = "login.jsp";
		</script>
		<%
	}
	
	
	BbsDao dao = BbsDao.getInstance();
	
	// readcount 증가
	dao.readcount(seq);
	/* 
		새로고침 됐을 때 readcount 증가 막아주기
		No
		seq 34
		id  abc
	
		select count(*)
		from bbsread
		where seq=34 and id'abc'
	*/
	
	BbsDto dto = dao.getBbs(seq);
	
%>
	<h1>상세글 보기</h1>
	<div align="center">
		<table border="1">
			<colgroup>
				<col style="width:100px">
				<col style="width:600px">
			</colgroup>
			<!-- <col width="100">
			<col width="600"> -->
			<tr>
				<th>작성자</th>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWdate() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getReadcount() %></td>
			</tr>
			<tr>
				<th>답글정보</th>
				<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=dto.getContent() %></td>
			</tr>
		</table>
		<br>
		<button type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>
		<button type="button" onclick="location.href='bbslist.jsp'">글목록</button>
		
		<%
			if(dto.getId().equals(login.getId())) {
		%>
		
		<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
		<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
		
		<%
			}
		%>
	</div>
	
	<script type="text/javascript">
		function answerBbs(seq) {
			location.href = "answer.jsp?seq=" + seq;
		}
		function updateBbs(seq) {
			location.href = "updateBbs.jsp?seq=" + seq;
		}
		function deleteBbs(seq) {
			location.href = "deleteBbs.jsp?seq=" + seq;	// update del = 1
		}
		// readcount 추가
	</script>
</body>
</html>