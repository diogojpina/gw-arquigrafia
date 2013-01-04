<div id="footer_wrap">
    <div style="float: left; margin-left: 20px;margin-top: 20px; ">
<!--        <img src="${pageContext.request.contextPath}/images/footer_left_top.png" width="717" height="44" alt="&Uacute;ltimas fotos" />-->
        <span class="big_white_title">Últimas fotos</span>
    </div>

    <c:if test="${tagMgr.collablet.enabled}">
        <tag:tagCloud tagMgr="${tagMgr}" collabletInstance="${photoMgr.collablet}" />
    </c:if>

    <div id="footer_carrousel_wrap">
        <br />
        <br />
        <br />
        <br />
        <div id="small_carrousel">
            <div id="makeMeScrollable2" class="footer_scroll">
                <div id="footer_scroll_left" class="scrollingHotSpotLeft"></div>
                <div id="footer_scroll_right" class="scrollingHotSpotRight"></div>
                                    <div class="scrollWrapper">
                        <div class="scrollableArea">
                <div class="scrollWrapper">
                    <div id="footer_scroll_list" class="scrollableArea" >
                        <%-- Modelo para inserção de imagens aqui. --%>
                        <photo:listPage linkClass="" photoMgr="${photoMgr}" keepRatio="true" pageSize="15" pageNumber="0" showInDiv="true"/>
                    </div>
                </div>
                </div>
                </div>
             </div>
        </div>
    </div>
    <div id="footer_bottom" style="clear:both">
        <div id="footer_bottom_text">
            O desenvolvimento deste projeto recebe ou recebeu o apoio de:
			<br />
            <div style="float: left; width: 10%; margin-top: 20px;">
                <a href="http://www.rnp.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/rnp_logo.png" alt="RNP" /></a>
            </div>
             <div style="float: left; width: 14%; margin-top: 20px;">
                <a href="http://www.fapesp.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/fapesp_logo.png" alt="FAPESP" /></a>
            </div>
            <div style="float: left; width: 14%; margin-top: 20px;">
                <a href="http://www.cnpq.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/cnpq_logo.gif" alt="CNPq" /></a>
            </div>
            <div style="float: left; width: 11%; margin-top: 20px;">
                <a href="http://www.usp.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/usp_logo.png" alt="USP" /></a>
            </div>
            <div style="float: left; width: 11%; margin-top: 20px;">
                <a href="http://www.ime.usp.br" target="_blanck"><img src="${pageContext.request.contextPath}/images/ime_logo.png" alt="IME" /></a>
            </div>
            <div style="float: left; width: 8%; margin-top: 20px;">
                <a href="http://www.usp.br/fau/" target="_blanck"><img src="${pageContext.request.contextPath}/images/fau_logo.png" alt="FAU" /></a>
            </div>
            <div style="float: left; width: 11%; margin-top: 20px;">
                <a href="http://www3.eca.usp.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/eca_logo.gif" alt="ECA" style="width: 114px" />
                </a>
            </div>
            <div style="float: left; width: 11%; margin-top: 20px;">
                <a href="http://ccsl.ime.usp.br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/ccsl.png" alt="CCSL" style="height: 84px" /></a>
            </div>
            <div style="float: left; width: 11%; margin-top: 20px;">
                <a href="http://winweb.redealuno.usp.br/quapa/" target="_blanck"><img src="${pageContext.request.contextPath}/images/quapa.png" alt="QUAPÁ"  /></a>
            </div>
            <div style="float: left; width: 10%; margin-top: 20px;">
                 Sob a licença de: <br/>
                 <a href="http://creativecommons.org/licenses/by/3.0/br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/creative_commons.jpg" style="height: 55px" alt="Creative Commons"/></a>
            </div>
        </div>
    </div>
</div>