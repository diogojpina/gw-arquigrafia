<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="idPhoto" required="true" rtexprvalue="true" type="java.lang.Long" %>

<r:callMethod methodName="buscaPhotoById" instance="${photoInstance}" var="foto">
    <r:param type="long" value="${idPhoto}"/>
</r:callMethod>

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
    <img alt="${foto.nome}" src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-show/${foto.nomeArquivoUnico}"/>"/>
</div>