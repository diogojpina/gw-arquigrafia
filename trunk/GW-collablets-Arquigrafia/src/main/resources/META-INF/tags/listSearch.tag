<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.Map" %>

<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>


<div class="list_photos">

		Imagens com a tag ${searchTerm}
		
		<c:if test="${not empty photosByTag}">
			<a class="load_photos_by_tag" href='<c:url value="/tags/${tagMgr.id}/${searchTerm}"/>' >Ver todas as imagens</a>		
		
		</c:if>
		<c:if test="${empty photosByTag}">
			<a class="not_load_photos">Nenhuma imagem encontrada</a>
		</c:if>
				
		<hr/>
			
		<c:forEach var="photo" items="${photosByTag}">
					     	<c:if test="${!photo.entity.deleted}">

								    <div class="${lineClass}" style="float: left">
								        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${photo.entity.id}"/>">
								            <img alt="${photo.entity.name}" src="<c:url value="/photo/img-thumb/${photo.entity.id}"/>?_log=no" />
								        </a>
								    </div>
		
								</c:if>
		</c:forEach>
		
</div>       
<br/><br/>

<c:forEach var="photo" items="${photos}">

	    	<div class="list_photos">
	    		
					<fmt:message key="${photo.key}"/>
					
						<c:choose>
							<c:when test="${fn:length(photo.value) >= 8 }">
								<a href="<c:url value="/photos/${photoInstance.id}/search/term?q=${searchTerm}&term=${photo.key}&perPage=8"/>" class="load_photos" data-page="2">Ver mais 8 imagens</a>
							</c:when>
							<c:when test="${fn:length(photo.value) eq 0 }">
								<a class="not_load_photos">Nenhuma imagem encontrada</a>
							</c:when>
						
						</c:choose>
					  <hr/>
					  
						<c:forEach items="${photo.value}" var="p">
	    					
						    <div class="${lineClass}" style="float: left">
						        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${p.id}"/>">
						            <img alt="${p.name}" src="<c:url value="/photo/img-thumb/${p.id}"/>?_log=no" />
						        </a>
						    </div>
				  </c:forEach>
				  <br/><br/>
			</div>
			<br/><br/>
</c:forEach>

