<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	System.out.println("id: " + id);

	MemberDao dao = MemberDao.getInstance();
	boolean b = dao.getId(id);
	
	if(b) out.println("No");	// id있음
	else out.println("Yes");
%>    