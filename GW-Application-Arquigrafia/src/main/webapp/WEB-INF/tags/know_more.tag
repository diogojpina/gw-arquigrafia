<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<div id="know_more">
    <div id="know_more_top">
        <h2 >Bem vindo ao Arquigrafia-Brasil! </h2>
  		<h1>
  			Olá, a versão de testes do Arquigrafia será liberada em breve. Caso queira ser um usuário de teste do sistema envie um email para <strong>arquigrafiabrasil@gmail.com</strong>.
  		</h1>
  		<br />
        <!-- <p>Esta é a uma versão alfa em desenvolvimento do Arquigrafia-Brasil caso tenha algum problema ou sugestão entre em contato pelo e-mail <strong>arquigrafiabrasil@gmail.com</strong>.</p> -->
        <p>O projeto Arquigrafia-Brasil propõe a construção colaborativa de um acervo digital de imagens da arquitetura brasileira. 
        Valendo-se da dinâmica de uma rede social na Web 2.0, o Arquigrafia reúne fotografias, desenhos e vídeos dos vários recantos 
        do país, produzidos por arquitetos, estudantes, professores, fotógrafos e pessoas interessadas em arquitetura. O acervo e 
        as funcionalidades do Arquigrafia são disponíveis via Web e por meio de dispositivos móveis (Android). O acervo de imagens 
        digitais em contínua expansão será em breve aberto ao público.
		</p>
    </div>
    <div id="know_more_1">
        <img src="${pageContext.request.contextPath}/images/know_more_1.jpg" width="148" height="140" alt="compartilhe" />
        <h3>Compartilhe</h3>
        <p>Compartilhe suas imagens com seus amigos, faça comentários e discuta sobre suas imagens favoritas.</p>
    </div>
    <div id="know_more_3">
        <img src="${pageContext.request.contextPath}/images/know_more_3.jpg" width="149" height="133" alt="localize" />
        <h3>Localize</h3>
        <p id="login_easter_eeg">É possível adicionar informações geográficas em suas imagens facilitando a descoberta de novidades perto você.</p>
    </div>
    <div id="know_more_2">
        <img src="${pageContext.request.contextPath}/images/know_more_2.jpg" width="212" height="140" alt="busque e organize" />
        <h3>Busque e Organize</h3>
        <p>Utilize a ferramenta de busca para ver todas as imagens compartilhadas. Organize também as imagens em álbuns e com o <strong>"Meu Arquigrafia"</strong> fica muito mais fácil para seus amigos verem suas contribuições.</p>
    </div>
</div>



<div id="footer_bottom" style="clear:both; max-width: 99%;">
	<hr width="100%" align="center" color="#333" noshade>
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
            <a href="http://winweb.redealuno.usp.br/quapa/" target="_blanck"><img src="${pageContext.request.contextPath}/images/quapa.png" alt="QUAPÁ" style="height: 114px" /></a>
        </div>
        <div style="float: left; width: 10%; margin-top: 20px;">
             Sob a licença de: <br/>
             <a href="http://creativecommons.org/licenses/by/3.0/br/" target="_blanck"><img src="${pageContext.request.contextPath}/images/creative_commons.jpg" style="height: 55px" alt="Creative Commons"/></a>
        </div>
    </div>
</div>
