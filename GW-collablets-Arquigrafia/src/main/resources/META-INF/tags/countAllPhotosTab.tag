<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>

<c:if test="${photoMgr.collablet.enabled}">
	<r:callMethod methodName="countAllPhotos" instance="${photoMgr}" var="count" />
	
	<p class="counter">O Arquigrafia conta com um total de <c:out value="${count}"/> fotos.
	<s:n-check name="X-X-usuario"> <a href="#" id="footer_login_link" >  Faça o login e compartilhe também suas imagens. </a></s:n-check>
</c:if>