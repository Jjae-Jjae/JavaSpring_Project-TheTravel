<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jsp-header.jsp" %>    
<c:set var="userId" value="${mdto.id}" scope="session"/>
<c:set var="userLevel" value="${mdto.level}" scope="session"/>
<meta http-equiv="refresh" content="0; url=${ctxpath}/"> 