<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="showMessage">
  <h2><c:out value="${messageTitle}" default=" "/></h2>
  <br/>
  <h3><c:out value="${messageSubtitle}" default=""/></h3>
  <br />
  <p><c:out value="${messageContent}" default=""/></p>        
</div>