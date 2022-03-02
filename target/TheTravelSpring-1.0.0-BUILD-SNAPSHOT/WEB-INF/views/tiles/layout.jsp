<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="../module/jsp-header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언제든지! AnyTime!!</title>   
   <link rel="stylesheet" type="text/css" href="${ctxpath}/resources/css/tiles/tiles.css">
</head>
<body>
<div align="center">
  <table style="width: 80%;">
    <tr>
      <td>
        <tiles:insertAttribute name="header"/>
      </td>
    </tr>
    
    
    <tr valign="middle">
      <td style="height: 500px">
        <tiles:insertAttribute name="content"/>
      </td>
    </tr>
    
    
    <tr>
      <td align="right">
        <tiles:insertAttribute name="footer"/>
      </td> 
    </tr>    
  </table>
</div>  
</body>
</html>