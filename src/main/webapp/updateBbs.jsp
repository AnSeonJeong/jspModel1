<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = dao.getBbs(seq);
%>
<h2>글수정</h2>

<div align="center">
	<form action="updateBbsAf.jsp" mehtod="post" id="frm" onsubmit="return check()">
	<input type="hidden" value="<%=seq %>" name="seq">
		<table border="1">
			<col width="100">
			<col width="700">
			<tr>
				<th>작성자</th>
				<td>
					<%=dto.getId() %>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" size="100px" id="title" name="title" value="<%=dto.getTitle() %>">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="30" cols="100" id="content" name="content"><%=dto.getContent() %></textarea>
				</td>
			</tr>
		</table>
		<br>
		<button type="submit">수정하기</button>
	</form>
</div>

<script type="text/javascript">
function check() {
	let title = document.getElementById("title").value;
	let content = document.getElementById("content").value;
	let form = document.getElementById("frm");
	
	if(title == "") {
		alert("제목을 입력해주십시오");
		return false;
	} else if(content == "") {
		alert("내용을 입력해주십시오");
		return false;		
	} 
}
</script>
</body>
</html>