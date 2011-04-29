<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<script type="text/javascript">
            $(function() {
                var myLatlng = new google.maps.LatLng(<c:out value="${trackRequest.latitude}" />, <c:out value="${trackRequest.longitude}" />);
                var myOptions = {
                    zoom: 13,
                    center: myLatlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                var map = new google.maps.Map(document.getElementById("mapa"), myOptions);
                <c:forEach items="${trackingInfoList}" var="ti">
		    new google.maps.Marker({
		    	position: new google.maps.LatLng(<c:out value="${ti.latitude}" />, <c:out value="${ti.longitude}" />),
		    	map: map,
		    	title: "<c:out value="${ti.user.name}" />"
		    });
                </c:forEach>
            });
        </script>
		<style type="text/css">
			#mapa {
				width: 500px;
				height: 400px;
			}
		</style>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div class="default_div">
			<h1>TrackingInfo</h1>
			<table border="1">
				<tr>
					<th>UserId</th>
					<th>Accuracy</th>
					<th>Longitude</th>
					<th>Latitude</th>
					<th>Date</th>
				</tr>
				<c:if test="${!empty trackingInfoList}">
					<c:forEach var="ti" items="${trackingInfoList}">
						<tr>
							<td><c:out value="${ti.user.id}" />
							</td>
							<td><c:out value="${ti.accuracy}" />
							</td>
							<td><c:out value="${ti.latitude}" />
							</td>
							<td><c:out value="${ti.longitude}" />
							</td>
							<td><c:out value="${ti.dateUpdate}" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty trackingInfoList}">
					<tr>
						<td colspan="5">Nenhum TrackingInfo cadastrado nas
							proximidades.</td>
					</tr>
				</c:if>
			</table>
			<div id="mapa"></div>
		</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>

