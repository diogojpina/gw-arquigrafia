<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" media="screen" href="css/reset.css" />
<link rel="stylesheet" media="screen" href="css/arq-common.css" />
<style type="text/css">#vlightbox a#vlb{display:none}</style> 
<link rel="stylesheet" href="plugins/visual_lightbox/engine/css/visuallightbox.css" type="text/css" media="screen" /> 
<link rel="stylesheet" href="plugins/visual_lightbox/engine/css/vlightbox.css" type="text/css" media="screen" />
<link rel="stylesheet" href="plugins/sds/css/smoothDivScroll.css" type="text/css" media="screen" />
<link rel="stylesheet" media="screen" href="css/footer.css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script src="plugins/sds/js/jquery.smoothDivScroll-0.9-min.js" type="text/javascript"></script>
<script src="plugins/sds/js/scroll.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
	
});
</script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Arquigrafia Brasil - Início</title>
</head>
<body>
<h1>Bem-vindo a Arquigrafia</h1>
	<!-- cabeçalho: provavelmente melhor tratar com tags -->
    <!-- carrossel principal de imagens, seguir o modelo para montar cada uma das linhas -->
    <!-- rodapé, seguir o modelo para inserir imagens e tags -->
    <jsp:include page="footer.htm" flush="true" />
</body>
</html>