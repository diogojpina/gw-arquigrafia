<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r"
uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true"
       type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>
<%@ attribute name="amount" required="false" rtexprvalue="false"
type="java.lang.Integer" %>
<%@ attribute name="columns" required="false" rtexprvalue="false"
type="java.lang.Integer" %>

<c:if test="${photoInstance.collablet.enabled}">
       <r:callMethod methodName="listLastPhotos" instance="${photoInstance}"
var="photos" >
       <r:param type="java.lang.Integer" value="${amount}" />
       </r:callMethod>
       <div id="panel">
	       <div class="images_column">
	               <c:forEach var="foto" items="${photos}" varStatus="counter">
	                               <a href="<c:url value="/16/photo/${foto.id}"/>" class="image"> 
	                                  <img src="<c:url value="/photo/img-crop/${foto.id}"/>?_log=no" width="170" height="117" />
	                               </a>
	                               <c:if test="${ ( (counter.count > 0) and ((counter.count mod columns) eq 0 ))}">
	                                       </div>
	                                       <div class="images_column">
	                               </c:if>
	               </c:forEach>
           </div>
       </div>
</c:if>