<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="footer_wrap">
    <div style="float: left">
        <img src="${pageContext.request.contextPath}/images/footer_left_top.png" width="667" height="44" alt="&Uacute;ltimas fotos" />
    </div>

    <c:if test="${tagMgr != null}">
        <TagMgr:TagCloud tagMgr="${tagMgr}" collabletInstance="${siteInstance}"/>
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
                        <c:if test="${environment_photo != null}">
                            <photo:listFirstHundred linkClass="" photoInstance="${environment_photo}" keepRatio="true" />
                        </c:if>
                        <c:if test="${photoInstance != null}">
                            <photo:listFirstHundred linkClass="" photoInstance="${photoInstance}" keepRatio="true" />
                        </c:if>
                    </div>
                </div>
             </div>
        </div>
    </div>
    <div id="footer_bottom">
        <div id="footer_bottom_text">
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat.
        </div>
    </div>
</div>