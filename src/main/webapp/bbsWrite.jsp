<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

<div align="center">
	<form action="bbsWriteAf.jsp" mehtod="post" id="frm">
		<table>
			<col width="100">
			<col width="700">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="id" size="50px" value="<%=login.getId() %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" id="title" name="title">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="30" cols="100" id="content" name="content"></textarea>
				</td>
			</tr>
		</table>
		<br>
		<!-- <input id="submitBtn" type="submit" value="글쓰기"> -->
		<button type="submit">글쓰기</button>
	</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$("button").click(function() {
		if($("#title").val().trim() == "") {
			alert('제목을 입력해주세요');
		} 
		if($("#content").val().trim() == "") {
			alert('내용을 입력해주세요');
		}
		else {
			$("frm").submit();
		}
	});
});
</script>

</body>
</html>