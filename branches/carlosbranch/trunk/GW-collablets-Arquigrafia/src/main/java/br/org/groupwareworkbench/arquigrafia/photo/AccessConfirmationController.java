package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.common.util.OAuth2Utils;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.code.UnconfirmedAuthorizationCodeClientToken;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;

@Resource
public class AccessConfirmationController {

    private Result result;

    @Autowired
    private ClientDetailsService clientDetailsService;

    public AccessConfirmationController(Result result) {
        this.result = result;
    }
    
    
    @Get
    @Path("/oauth/confirm_access")
    public void alguna(String client_id, String client_secret, String redirect_uri, String state,
            String scopes){

        Set<String> scope = OAuth2Utils.parseScope(scopes);
        UnconfirmedAuthorizationCodeClientToken clientAuth =
                new UnconfirmedAuthorizationCodeClientToken(client_id, client_secret, scope, state, redirect_uri);

        ClientDetails client = clientDetailsService.loadClientByClientId(clientAuth.getClientId());
        
        result.include("auth_request", clientAuth);
        result.include("client", client);
        //result.redirectTo(AccessConfirmationController.class).accessconfirmation();
    }
    
    @Get
    @Path ("/oauth/algo")
    public void accessconfirmation() {
        
    }
}
