<!--
    Description: Holds the list of components, plus the canvases and all associated structures. 
    Created By: Gustavo H. Braga (gustavo.henrick@gmail.com)
    Date: 08/09/2010
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Cache-Control" content="no-cache" />
        <title><c:out value="${Title}" /></title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    </head>
    <body>
        <form>
            <input type="hidden" value="<c:out value="${coor_x}" />" id="coord_x_<c:out value="${collablet.id}" />" />
            <input type="hidden" value="<c:out value="${coor_y}" />" id="coord_y_<c:out value="${collablet.id}" />" />
        </form>
    </body>
</html>