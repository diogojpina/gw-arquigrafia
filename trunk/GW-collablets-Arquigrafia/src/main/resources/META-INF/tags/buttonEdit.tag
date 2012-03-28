<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<%@ attribute name="idButton" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="className" required="false" rtexprvalue="true" type="java.lang.String" %>

<script type="text/javascript">
    
    function editPhoto() {
    	$.post("${pageContext.request.contextPath}/photo/" + ${photoInstance.id} + "/photo/" + ${photo.id}, function(data) {});
    }
</script>

<a class="${className}" style="text-decoration: none; padding:0px;" id="idEdit" href="${pageContext.request.contextPath}/photo/${photoInstance.id}/edit/${photo.id}" onclick="">Editar</a>
