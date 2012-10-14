<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="foto" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="clazz" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String" %>

<a class="fancybox" href="<c:url value="/photo/img-show/${foto.id}.jpeg"/>" title="${foto.name}" ><img class="${clazz}" style="${style}" src="<c:url value="/photo/img-show/${foto.id}"/>.jpeg" onload="initialize()" /></a>
 <!-- alt="<c:out value="${}" />"  --> 
