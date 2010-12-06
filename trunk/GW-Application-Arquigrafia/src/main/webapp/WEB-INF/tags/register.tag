<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance" %>
<%@ attribute name="geoReferenceMgr" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.georeference.GeoReferenceMgrInstance" %>

<script src="${pageContext.request.contextPath}/js/formToWizard.js" type="text/javascript"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        $("#photoRegisterForm").formToWizard();
    });
</script> 
        
<div class="big_white_title" id="register_title">
    <div><img src="${pageContext.request.contextPath}/images/upload.png" alt="upload" />&nbsp;</div>
    <div>Enviar Imagem</div>
</div>
<c:if test="${not empty errors}">
    <div id="errors">
        <c:forEach var="error" items="${errors}">
            <c:out value="${error.category}" /> - <c:out value="${error.message}" />
        </c:forEach>
    </div>
</c:if>
<c:if test="${not empty successMessage}">
    <div id="success" class="messages">
        <script type="text/javascript">
            $("#success").show().delay(10000).slideUp(300);
        </script>
        <c:out value="${successMessage}" />
    </div>
</c:if>
<div id="internal_wrap">
    <div class="mid_blue_text" style="margin-left: 30px; background-color: #fff;">
        <form name="photoRegisterForm" id="photoRegisterForm" method="post" enctype="multipart/form-data"
                action="<c:url value="/groupware-workbench/photo/${photoInstance.id}/registra" />">
            <photo:save photoRegister="${photoRegister}"
                    photoInstance="${photoInstance}" tagMgr="${tagMgr}"
                    geoReferenceMgr="${geoReferenceMgr}"
                    user="${sessionScope.userLogin}" formClass="form1"
                    formLineClass="field_line_f1 upload_form" formLabelClass="label_f1"
                    formInputClass="input_f1" />
        </form>
    </div>
</div>