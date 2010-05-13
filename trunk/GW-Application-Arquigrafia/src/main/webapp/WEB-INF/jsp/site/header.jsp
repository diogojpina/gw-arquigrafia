<div class="backgrounded_bay" id="bay"> 
        <div> 
            <div class="bay_title">Compartilhar | Coletar</div> 
            <div class="bay_banner" id="big_bay_banner"> 
                <img src="${pageContext.request.contextPath}/images/bay_collections.png" width="304" height="124" >
            </div> 
        </div> 
</div>

<div id="big_logo">
	<img src="${pageContext.request.contextPath}/images/big_logo.png" width="113" height="120" alt="Arquigrafia Brasil" />
</div>

<div id="small_header">    
	<div id="small_login_field">
       	  <form action="index2.jsp" method="get">
            	<ul>
                	<li class="s_l_label"><span>usuário:</span></li><li><input type="text" value="" class="s_l_field_bg" id="s_l_user" /></li>
	                <li class="s_l_label"><span>senha:</span></li><li><input type="password" value="" class="s_l_field_bg" id="s_l_pass" /></li>
                    <li><button type="submit" id="s_l_button" class="s_l_login_button" /></li>
                 </ul>
            </form>
        </div>
        <div id="registration_field">
	        <a href="#know_more"><img src="${pageContext.request.contextPath}/images/bt_know_more2.gif" width="18" height="18" alt="saiba mais" /></a>
            <a href="#know_more"><span>Registrar-se</span></a>
        </div>
</div>
<photo:simpleSearch photoInstance="${environment_photo}" ></photo:simpleSearch>