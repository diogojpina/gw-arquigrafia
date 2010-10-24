<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="foto" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>

<script type="text/javascript">
    $(function() {
        $("a#[rel=linkimage]").fancybox({
            "titleShow": false,
            "transitionIn": "elastic",
            "transitionOut": "elastic"
        });
    });
</script>
<div>
    <img alt="<c:out value="${foto.nome}" />" src="<c:url value="/groupware-workbench/photo/img-show/${foto.id}"/>" />
</div>