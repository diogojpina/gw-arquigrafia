<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.groupwareworkbench.org.br/widgets/util"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.Map" %>

<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>

		
<c:if test="${not empty photosByTag}">
		<div class="list_photos">
				Imagens com a tag: ${searchTerm}
					<c:out value="${stringVariable}"/>
					<a class="load_photos_by_tag" href='<c:url value="/tags/${tag.id}" />' >Ver todas as imagens</a>		
				
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
				<br/><br/>
		</div>       
		<br/><br/>
</c:if>
		

<c:forEach var="photo" items="${photos}">

			<c:if test="${fn:length(photo.value) >= 1 }">
	    	<div class="list_photos">
	    		
					<fmt:message key="${photo.key}"/> ${searchTerm}
					<c:if test="${fn:length(photo.value) >= 8 }">
						<a id="${photo.key}" href="<c:url value="/photos/${photoInstance.id}/search/term?q=${util:encode(searchTerm)}&term=${util:encode(photo.key)}&perPage=8"/>" class="load_photos" data-count="0" data-page="2"></a>
					</c:if>						
				  <hr/>
				  
					<c:forEach items="${photo.value}" var="p">
    					
					    <div class="${lineClass}" style="float: left">
					        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${p.id}"/>" title="${p.name}">
					            <img alt="${p.name}" src="<c:url value="/photo/img-thumb/${p.id}"/>?_log=no" />
					        </a>
					    </div>
			  </c:forEach>
				  <br/><br/>
			</div>
			<br/><br/>
		</c:if>					
</c:forEach>
			

