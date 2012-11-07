<%@ include file="/WEB-INF/jsp/imports.jsp" %>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div id="main_section">
		    <div id="makeMeScrollable" style="border-style: solid; border-width: thin; border-color: #666; padding-left: 0px; height: 500px;">
		        <div class="scrollingHotSpotLeft" style="height: 500px;"></div>
		        <div class="scrollingHotSpotRight" style="height: 500px;"></div>
		        <div class="scrollWrapper" id="images_scrollable">
		            <div class="scrollableArea">
		                <div class="wallBackground">
		                    <c:forEach begin="0" end="21" var="indice">
		                        <photo:listPage linkClass="" photoInstance="${photoMgr}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="${indice}" wrapClass="imageColumn" />
		                    </c:forEach>
		                </div>
		                <div class="image_line">
		                </div>
		                <div class="image_line">
		                </div>
		                <div class="image_line">
		                </div>
		                <div class="image_line">
		                </div>
		                <script type="text/javascript" src="plugins/visual_lightbox/engine/js/visuallightbox.js" ></script>
		            </div>
		        </div>
		    </div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>