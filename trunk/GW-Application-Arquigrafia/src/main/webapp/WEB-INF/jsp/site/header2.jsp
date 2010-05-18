<div id="bay"> 
    <div> 
        <div class="bay_title">Compartilhar | Coletar</div> 
        <div class="bay_banner" id="small_bay_banner"> 
            One ball, two players. Lots of fun.
        </div> 
    </div> 
</div>
<div id="header">
    <div id="title">
        <a href="${pageContext.request.contextPath}/groupware-workbench/1/site"><img src="${pageContext.request.contextPath}/images/head1_left_top.png" width="350" height="100" alt="Arquigrafia Brasil" /></a>
    </div>
    <div id="header_top_right">
        <div id="user_top_links">
            <a href="#" class="black_link"><c:out value="${sessionScope.User}" /></a>
            &nbsp;&nbsp;
            <a href="#" class="gray_link">sair</a>
        </div>
        <div id="suggestions">
            <a href="mailto:test@somewhere" class="white_link">Sugest&otilde;es e Cr&iacute;ticas</a><br />
            <a href="mailto:test@somewhere" class="white_link">Reportar Problema</a>
        </div>
        <div id="user_bottom_links">
            <a href="#" id="link_profile"><img src="${pageContext.request.contextPath}/images/profile_bt.gif" width="43" height="13" alt="perfil" /></a>
            <a href="#" id="link_pictures"><img src="${pageContext.request.contextPath}/images/pictures_bt.gif" width="45" height="13" alt="fotos" /></a>
            <a href="#" id="drop_plus"><img src="${pageContext.request.contextPath}/images/plus_bt.gif" width="41" height="13" alt="mais" /></a>
        </div>
    </div>
    <div id="top_links" class="blue_link">
        <a href="${pageContext.request.contextPath}/groupware-workbench/1/site">In&iacute;cio</a>
        &nbsp;|&nbsp;
        <a href="help.htm">Ajuda</a>
        &nbsp;|&nbsp;
        <a href="privacy.htm">Privacidade</a>
        &nbsp;|&nbsp;
        <a href="legal.htm">Legal</a>
    </div>
    <div id="search_field">
        <img src="${pageContext.request.contextPath}/images/head1_left2_top.png" width="99" height="100" alt="campo de busca" />
        <div id="search_input">
            <ul style="list-style: none">
                <li style="display: inline">
                    <c:if test="${environment_photo != null}">
                        <photo:simpleSearch photoInstance="${environment_photo}" />
                    </c:if>
                    <c:if test="${photoInstance != null}">
                        <photo:simpleSearch photoInstance="${photoInstance}" />
                    </c:if>
                </li>
                <li style="display: inline">
                    <div id="search_options1">
                        <span class="option_on">Texto</span>
                        <span class="fat_separator">|</span>
                        <span class="option_off">Tags</span>
                        <br />
                        <span id="advancedSearch">
                            <a href="#" class="orange_link">Busca Avan&acute;ada &gt;&gt;</a>
                        </span>
                    </div>
                    <div id="search_options2">
                        <span class="option_on">Texto</span>
                        <span class="fat_separator">|</span>
                        <span class="option_off">Tags</span>
                        <br />
                        <span id="simpleSearch">
                            <a href="#" class="orange_link">Busca Simples &gt;&gt;</a>
                        </span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div id="advancedSearchField">
        <c:if test="${environment_photo != null}">
            <photo:advancedSearch photoInstance="${environment_photo}" formClass="form1" formLineClass="field_line_f1" formLabelClass="label_f1" formInputClass="input_f1"
                formLineBtClass="bt_line_f1" formSubmitBtClass="bt_cell_submit" />
        </c:if>
        <c:if test="${photoInstance != null}">
            <photo:advancedSearch photoInstance="${photoInstance}" formClass="form1" formLineClass="field_line_f1" formLabelClass="label_f1" formInputClass="input_f1"
                formLineBtClass="bt_line_f1" formSubmitBtClass="bt_cell_submit" />
        </c:if>
    </div>
    <script type="text/javascript">
        $("#search_options2").hide();
        $("#advancedSearchField").hide();
        $("#simpleSearch").click(function() {
            $("#search_options1").show();
            $("#search_options2").hide();
            $("#advancedSearchField").hide();
        });
        $("#advancedSearch").click(function() {
            $("#search_options2").show();
            $("#search_options1").hide();
            $("#advancedSearchField").show();
        });
    </script>
</div>