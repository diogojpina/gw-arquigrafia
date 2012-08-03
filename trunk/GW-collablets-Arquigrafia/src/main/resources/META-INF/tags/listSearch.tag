<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.Map" %>

<%@ attribute name="showName" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showLocation" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--
    TODO: Evitar inserir <div> que nao fecham de forma obvia pois dependem de analise sensivel ao contexto para
    garantir que sao bem formadas.
--%>


<c:forEach var="photo" items="${photos}">

	    	<div class="list_photos">
	    		
					<fmt:message key="${photo.key}"/>
					
						<c:choose>
							<c:when test="${fn:length(photo.value) >= 8 }">
								<a href="<c:url value="/photos/${photoInstance.id}/search/term?q=${searchTerm}&term=${photo.key}&perPage=8"/>" class="load_photos" data-page="2">Ver mais 8 fotos</a>
							</c:when>
							<c:when test="${fn:length(photo.value) eq 0 }">
								<a class="not_load_photos">Nenhuma imagem encontrada</a>
							</c:when>
						
						</c:choose>
					  <hr/>
					  
						<c:forEach items="${photo.value}" var="p">
	    					
						    <div class="${lineClass}" style="float: left">
						        <c:if test="${showName || showLocation}">
						            <div>
						        </c:if>
						        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${p.id}"/>">
						            <img src="<c:url value="/photo/img-thumb/${p.id}"/>?_log=no" />
						        </a>
						        <c:if test="${showName || showLocation}">
						            </div>
						        </c:if>
						        <c:if test="${showName}">
						            <div class="${nameClass}">
						                <c:out value="${p.name}" />
						            </div>
						        </c:if>
						        <c:if test="${showLocation}">
						            <div class="${locationClass}" >
						                <c:out value="${p.lugar}" />
						            </div>
						        </c:if>
						    </div>
				  </c:forEach>
				  <br/><br/>
			</div>
			<br/>
			<br/>
</c:forEach>

