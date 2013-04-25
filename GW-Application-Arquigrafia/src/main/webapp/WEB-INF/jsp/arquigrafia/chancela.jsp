<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
</head>

<body>
  <!--   CONTAINER   -->
  <div id="container">
  
  <!--   CABEÇALHO   -->
    <arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />
    
    <!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
    <div id="content">
      <!--   COLUNA ESQUERDA   -->
      <div id="sub_content">
        <!--   CONTEÚDO SOBRE O PROJETO   -->
        <h1 id="project_title">Chancela do Ministério da Cultura</h1>
        <div id="project_text_tools">
	        <a href="#" title="Diminuir fonte" class="dec-font">A-</a>
	        <a href="#" title="Restaurar fonte" class="res-font">A</a>
	        <a href="#" title="Aumentar fonte" class="inc-font">A+</a>
	        <a href="#"  title="Imprimir" id="printer_icon"></a>
        </div>
        <!--   TEXTO DO PROJETO   -->
        <div id="project_text">
          <br />
          <h2>Arquigrafia recebe chancela do Ministério da Cultura</h2>

		  <p>O projeto Arquigrafia recebeu do Ministério da Cultura, por meio da Secretaria de Políticas Culturais, a chancela de experiências de Cartografia Colaborativas em 19 de fevereiro de 2013. Tal reconhecimento foi motivo de muito orgulho para toda equipe.</p>
          <img class="left" src="<c:url value="/img/chancela.jpg" />" width="600px" height="auto"  alt="Texto alternativo da foto" title="Título da foto" />
 		</div>
        <!--   FIM - TEXTO DO PROJETO   -->
      </div>
      <!--   FIM - COLUNA ESQUERDA   -->
      <!--   COLUNA DIREITA -->  
      <div id="sidebar"> 
        <h2>Equipe</h2>
		<h3>Pesquisadores</h3>
		<ul>
			<li><small><a href="http://lattes.cnpq.br/9297674836039953" target="_blank">Prof. Dr. Artur Simões Rozestraten - FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/4507073071352893" target="_blank">Prof. Dr. Marco Aurélio Gerosa - IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/5382764179565796" target="_blank">Profa. Dra. Maria Laura Martinez - ECAUSP</a></small></li>
		</ul>
		
		<h3>Colaboradores</h3>
		<ul>
			<li><small><a href="http://lattes.cnpq.br/2342739419247924" target="_blank">Prof. Dr. Fábio Kon - IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/4574831233204082" target="_blank">Prof. Dr. Julio Roberto Katinsky - FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/3841951853755817" target="_blank">Prof. Dr. Luiz Américo de Souza Munari - FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/5218253515771817" target="_blank">Prof. Dr. Abílio Guerra e equipe VITRUVIUS</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/6695382764766281" target="_blank">Profa. Dra. Roberta Lima Gomes - Informática UFES</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/7471111924336519" target="_blank">Prof. Dr. Magnos Martinello - Informática UFES</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/3498148304153540" target="_blank">Prof. Dr. Juliano Maranhão - FDUSP</a></small></li>
			<li><small><a href="http://www.usp.br/fau/fau/secoes/biblio/index.htm" target="_blank">Dina Uliana - Diretora biblioteca FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/4131992141506749" target="_blank">Eliana de Azevedo Marques - Biblioteca FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/7542993440465891" target="_blank">Elizabete da Cruz Neves - Biblioteca FAUUSP</a></small></li>
			<li><small><a href="http://www.usp.br/fau/fau/secoes/biblio/index.html" target="_blank">Rejane Alves - Biblioteca FAUUSP</a></small></li>
			<li><small><a href="http://www.cristianomascaro.com.br/" target="_blank">Prof. Dr. Cristiano Mascaro - Consultor de fotografia</a></small></li>
			<li><small><a href="http://www2.nelsonkon.com.br/" target="_blank">Arq. Nelson Kon - Consultor de fotografia</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/9781300883115022" target="_blank">Arq. Rodrigo Luiz Minot Gutierrez - SENAC / UNIUBE</a></small></li>
		</ul>
		
		<h3>Alunos participantes</h3>
		<ul>
			<li><small><a href="http://lattes.cnpq.br/3098839514190572" target="_blank">Aurelio Akira M. Matsui - Doutorando Universidade de Tokyo</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/8776038016041917" target="_blank">Straus Michalsky - Doutorando IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/0999376629124379" target="_blank">Ana Paula Oliveira dos Santos - Mestre IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/3965923523593288" target="_blank">Lucas Santos de Oliveira - Mestre IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/2605934447999302" target="_blank">José Teodoro - Mestrando IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/2350572278366806" target="_blank">Carlos Leonardo Herrera Muñoz - Mestrando IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/2452505576333369" target="_blank">Edith Zaida Sonco Mamani - Mestrando IMEUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/3693915918069542" target="_blank">André Luís de Lima - Mestrando FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/0523942267027344" target="_blank">Diogo Augusto - Graduando em IC FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/7328149928743537" target="_blank">Lucas Caracik - Graduando em IC FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/9088835359158147" target="_blank">Samuel Carvalho G. Fukumoto - Graduando FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/8004254725476493" target="_blank">Ruth Cuiá Troncarelli - Graduanda FAUUSP</a></small></li>
			<li><small><a href="#" target="_blank">Ana Clara Souza Santana - Graduanda FAUUSP</a></small></li>
			<li><small><a href="#" target="_blank">Amanda Stenghel - Graduanda FAUUSP</a></small></li>
			<li><small><a href="#" target="_blank">Giuliano Magnelli - Graduando FAUUSP</a></small></li>
			<li><small><a href="#" target="_blank">Kevin Ritschel - Graduando FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/7968062612895669" target="_blank">Ilka Apocalypse Jóia Paulini - Graduanda FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/3715644973427707" target="_blank">Bhakta Krpa das Santos - Graduando FAUUSP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/5529848738416350" target="_blank">Guilherme A. Nogueira Cesar - Graduando FAUUSP</a></small></li>
			<li><small><a href="#" target="_blank">Rodrigo Ciorciari Salandim - Graduando EACHUSP</a></small></li>
			<li><small><a href="#" target="_blank">Bruna Sellin Trevelin - Graduanda Direito USP</a></small></li>
			<li><small><a href="http://lattes.cnpq.br/1387924249101546" target="_blank">Enzo Toshio S. L. de Mello - FITO</a></small></li>
		</ul>
		
		<h3>Parceiros de desenvolvimento</h3>
		<ul>
			<li><small><a href="http://www.bench.com.br/" target="_blank">Jean Pierre Chamouton - Benchmark Design Total</a></small></li>
			<li><small><a href="http://www.brzcomunicacao.com.br/" target="_blank">Pedro Emilio Guglielmo - BRZ Comunicação</a></small></li>
			<li><small><a href="http://www.brzcomunicacao.com.br/" target="_blank">Tiago Ortlieb - BRZ Comunicação</a></small></li>
			<li><small><a href="http://www.wikimedia.org/" target="_blank">Alexandre Hannud Abdo - Wikimedia</a></small></li>						
		</ul>
      </div>
       <!--   FIM - COLUNA DIREITA -->   
   
    <!--   FIM - MEIO DO SITE-->
    <!--   FUNDO DO SITE   -->
    <div id="footer">
	  <!--   BARRA DE ABAS   -->
	  <arquigrafia:tabs counterMgr="${counterMgr}" photoMgr="${photoMgr}" commentMgr="${commentMgr}" arquigrafiaInstance="${arquigrafiaMgr}" />
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
      <div id="registration">
      </div>
    </div>
    <!--   FIM - MODAL   -->
  </div>
  <!--   FIM - CONTAINER   -->
</body>
</html>