<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="idPhoto" required="true" rtexprvalue="true" type="java.lang.Long" %>

<r:callMethod methodName="getDirImagesRelativo" instance="${photoInstance}" var="dirImagem" />
<r:callMethod methodName="getThumbPrefix" instance="${photoInstance}" var="thumbPrefix" />
<r:callMethod methodName="getMostraPrefix" instance="${photoInstance}" var="showPrefix" />

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
    <!--
        <a rel="linkimage" href="${pageContext.request.contextPath}/${dirImagem}/${foto.nomeArquivo}">
            <img alt="${foto.nome}" src="${pageContext.request.contextPath}/${dirImagem}/${showPrefix}${foto.nomeArquivo}" />
        </a>
    -->
    <%--img alt="${foto.nome}" src="${pageContext.request.contextPath}/${dirImagem}/${showPrefix}${foto.nomeArquivoUnico}" /--%>
    <img alt="${foto.nome}" src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-show/${foto.nomeArquivoUnico}"/>"/>
    
</div>