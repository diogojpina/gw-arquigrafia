
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:forEach var="person" items="${people}">

					    <div class="${lineClass}" style="float: left">
					        <a  class="search_image" title="${person.name}" rel="linkimage" href="<c:url value="/friends/11/show/${person.id}" />">
					            <img alt="${person.name}" src="<c:url value="${person.photoURL}"  />" width="105" height="72"/>
					        </a>
					    </div>

</c:forEach>
