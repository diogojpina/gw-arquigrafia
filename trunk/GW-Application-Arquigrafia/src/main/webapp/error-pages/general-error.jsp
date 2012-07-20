<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="arquigrafia"
	uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="album"
	uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ taglib prefix="photo"
	uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="tag"
	uri="http://www.groupwareworkbench.org.br/widgets/tag"%>
<%@ taglib prefix="comment"
	uri="http://www.groupwareworkbench.org.br/widgets/comment"%>
<%@ taglib prefix="counter"
	uri="http://www.groupwareworkbench.org.br/widgets/counter"%>
<%@ taglib prefix="s"
	uri="http://www.groupwareworkbench.org.br/widgets/security"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Erro"/></title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
<album:buttonAdd-script />
</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEZALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />
		<!--   MEIO DO SITE - ÃREA DE NAVEGAÃÃO   -->
		<div id="content">
			<p>Aconteceu um erro durante a execução da tarefa.</p>

			<p>Esta é a versão Beta 2012 do Arquigrafia-Brasil. Ela está em fase de
				implementação e sujeita a ocorrência de erros. Nossa equipe está trabalhando
				para corrigir todas as falhas que forem identificadas. Mas para isso pedimos sua
				colaboração para que nos ajude a deixar este projeto seja cada vez melhor.</p>

			<p>
				Sua ajuda é muito importante para o projeto. Solicitamos que envie um e-mail
				informando as ações executadas que causaram o erro para <a
					href="mailto:arquigrafiabrasil@gmail.com">arquigrafiabrasil@gmail.com</a> 
				para que corrijamos o problema.
			</p>

			<p>Obrigado por sua colaboração.</p>
		</div>
		<!--   FUNDO DO SITE   -->
		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<arquigrafia:tabs arquigrafiaInstance="${arquigrafiaMgr}" />
			<!--   FIM - BARRA DE IMAGENS - (RODAPÉ)   -->

			<!--   CRÉDITOS - LOGOS   -->
			<arquigrafia:footer arquigrafiaInstance="${arquigrafiaMgr}" />
		</div>
		<!--   FIM - FUNDO DO SITE   -->
		<!--   MODAL   -->
		<div id="mask"></div>
		<div id="form_window">
			<!-- ÁREA DE LOGIN - JANELA MODAL -->
			<a class="close" href="#" title="FECHAR"></a>
			<div id="registration"></div>
		</div>
		<!--   FIM - MODAL   -->
	</div>
	<!--   FIM - CONTAINER   -->
</body>
</html>
