<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>
 <c:remove var="userId" scope="session"/><!-- 세션무효화  -->
 <c:remove var="userLevel" scope="session"/><!-- 세션무효화  -->
<meta http-equiv="refresh" content="0; url=${ctxpath}/member/login.do">