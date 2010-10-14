<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<div id="footer_wrap">
    <div style="float: left">
        <img src="${pageContext.request.contextPath}/images/footer_left_top.png" width="717" height="44" alt="&Uacute;ltimas fotos" />
    </div>

    <c:if test="${tagMgr != null}">
        <tag:tagCloud tagMgr="${tagMgr}" collabletInstance="${photoInstance.collablet}" />
    </c:if>

    <div id="footer_carrousel_wrap">
        <br />
        <br />
        <br />
        <br />
        <div id="small_carrousel">
            <div id="makeMeScrollable" class="footer_scroll">
                <div id="footer_scroll_left" class="scrollingHotSpotLeft"></div>
                <div id="footer_scroll_right" class="scrollingHotSpotRight"></div>
                <div class="scrollWrapper">
                    <div id="footer_scroll_list" class="scrollableArea" >
                        <%-- Modelo para inserção de imagens aqui. --%>
                        <photo:listPage linkClass="" photoInstance="${photoInstance}" keepRatio="true" pageSize="100" pageNumber="0" wrapClass="footerImages" />
                    </div>
                </div>
             </div>
        </div>
    </div>
    <div id="footer_bottom" style="clear:both">
        <div id="footer_bottom_text">
            O desenvolvimento deste projeto recebe o apoio de:
            <br />
            <div style="float: left; width: 25%; margin-top: 20px;">
                <img src="${pageContext.request.contextPath}/images/rnp_logo.png" alt="RNP" />
            </div>
            <div style="float: left; width: 20%; margin-top: 20px;">
                <img src="${pageContext.request.contextPath}/images/usp_logo.png" alt="USP" />
            </div>
            <div style="float: left; width: 20%; margin-top: 20px;">
                <img src="${pageContext.request.contextPath}/images/ime_logo.png" alt="IME" />
            </div>
            <div style="float: left; width: 20%; margin-top: 20px;">
                <img src="${pageContext.request.contextPath}/images/fau_logo.png" alt="FAU" />
            </div>
            <div style="float: left; width: 15%; margin-top: 20px;">
                <img src="${pageContext.request.contextPath}/images/eca_logo.gif" alt="ECA" style="width: 114px" />
            </div>
        </div>
    </div>
</div>