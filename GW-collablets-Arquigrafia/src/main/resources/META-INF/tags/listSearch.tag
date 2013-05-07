<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.groupwareworkbench.org.br/widgets/util"%>
<%@ taglib prefix="tagMgr" uri="http://www.groupwareworkbench.org.br/widgets/tag"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.Map" %>

<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>



<c:if test="${not empty people}">
		
					<div class="list_photos">
								Pessoa(s) com nome: ${searchTerm}

<%-- 								<c:out value="${stringVariable}"/>
 --%>
								<c:if test="${fn:length(people) >= 8 }">
										<a id="people" href="<c:url value="/users/search?q=${util:encode(searchTerm)}&perPage=8"/>" class="load_photos" data-count="0" data-page="2"></a>
								</c:if>							

								<hr/>
								
								<c:forEach var="person" items="${people}">
					
													    <div class="${lineClass}" style="float: left">
													        <a  class="search_image" title="${person.name}" rel="linkimage" href="<c:url value="/friends/11/show/${person.id}" />">
													            <img alt="${person.name}" src="<c:url value="${person.photoURL}"  />" height="72"/>
													        </a>
													    </div>
							
								</c:forEach>
							<br/><br/>
					</div>     

		<br/><br/>
</c:if>

		
<c:if test="${not empty tags}">
		
		<c:forEach var="tag" items="${tags}">
				<c:if test="${tag.size > 0 }">
					<div class="list_photos">
								Imagens com a tag: ${tag.name}
								<c:out value="${stringVariable}"/>
								<a class="load_photos_by_tag" href='<c:url value="/tags/${tag.id}" />' >Ver todas as imagens</a>		
							
								<hr/>
								
								<c:forEach var="photo" items="${tagMgr:getAssignments(tag, 8)}">
										     	<c:if test="${!photo.entity.deleted}">
					
													    <div class="${lineClass}" style="float: left">
													        <a  class="search_image" title="${photo.entity.name}" rel="linkimage" href="<c:url value="/photo/${photo.entity.id}"/>">
													            <img alt="${photo.entity.name}" src="<c:url value="/photo/img-thumb/${photo.entity.id}"/>?_log=no" />
													        </a>
													    </div>
							
													</c:if>
								</c:forEach>
							<br/><br/>
					</div>     
				</c:if>
		</c:forEach>  
		<br/><br/>
</c:if>
		

<c:forEach var="photo" items="${photos}">

			<c:if test="${fn:length(photo.value) >= 1 }">
	    	<div class="list_photos">
	    		
					<fmt:message key="${photo.key}"/> ${searchTerm}
					<c:if test="${fn:length(photo.value) >= 8 }">
						<a  id="${photo.key}" href="<c:url value="/photos/${photoInstance.id}/search/term?q=${util:encode(searchTerm)}&term=${util:encode(photo.key)}&perPage=8"/>" class="load_photos" data-count="0" data-page="2" style="color: #A6A6A6"></a>
					</c:if>						
				  <hr/>
				  
					<c:forEach items="${photo.value}" var="p">
    					
					    <div class="${lineClass}" style="float: left">
					        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${p.id}"/>" title="${p.name}">
					            <img src="<c:url value="/photo/img-thumb/${p.id}"/>?_log=no" />
					        </a>
					        
					    </div>
			  </c:forEach>
				  <br/><br/>
			</div>
			<br/><br/>
		</c:if>					
</c:forEach>
			

