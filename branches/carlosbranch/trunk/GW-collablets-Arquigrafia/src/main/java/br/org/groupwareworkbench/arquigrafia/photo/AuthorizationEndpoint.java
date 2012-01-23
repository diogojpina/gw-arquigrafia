package br.org.groupwareworkbench.arquigrafia.photo;

import java.security.Principal;
import java.util.Collections;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.common.exceptions.InvalidClientException;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;
import org.springframework.security.oauth2.common.exceptions.UnapprovedClientAuthenticationException;
import org.springframework.security.oauth2.common.exceptions.UnsupportedResponseTypeException;
import org.springframework.security.oauth2.common.exceptions.UserDeniedAuthorizationException;
import org.springframework.security.oauth2.common.util.OAuth2Utils;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.code.DefaultRedirectResolver;
import org.springframework.security.oauth2.provider.code.DefaultUserApprovalHandler;
import org.springframework.security.oauth2.provider.code.RedirectResolver;
import org.springframework.security.oauth2.provider.code.UnconfirmedAuthorizationCodeAuthenticationTokenHolder;
import org.springframework.security.oauth2.provider.code.UnconfirmedAuthorizationCodeClientToken;
import org.springframework.security.oauth2.provider.code.UserApprovalHandler;
import org.springframework.security.oauth2.provider.endpoint.AbstractEndpoint;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.org.groupwareworkbench.core.session.GWLoginUser;

@Resource
@SessionAttributes(types = UnconfirmedAuthorizationCodeClientToken.class)
public class AuthorizationEndpoint extends AbstractEndpoint {

    @Autowired
    private ClientDetailsService clientDetailsService;

    @Autowired
    private AuthorizationCodeServices authorizationCodeServices;
    
    @Autowired
    private Result result;

    private RedirectResolver redirectResolver = new DefaultRedirectResolver();

    private UserApprovalHandler userApprovalHandler = new DefaultUserApprovalHandler();

    private String userApprovalPage = "/oauth/confirm_access";

    @Override
    public void afterPropertiesSet() throws Exception {
        super.afterPropertiesSet();
        Assert.state(clientDetailsService != null, "ClientDetailsService must be provided");
        Assert.state(authorizationCodeServices != null, "AuthorizationCodeServices must be provided");
    }
    
    @Get
    @Path(value = "/oauth/authorize")
    public void implicitAuthorizationA(String response_type,
            String client_id,
            String client_secret,
            String redirect_uri,
            String state,
            String scopes,
            SessionStatus sessionStatus){
        
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        
        Set<String> scope = OAuth2Utils.parseScope(scopes);
        UnconfirmedAuthorizationCodeClientToken authToken = 
            new UnconfirmedAuthorizationCodeClientToken(client_id, client_secret, scope, state, redirect_uri);
        
        
        if(response_type.equals("code"))
            startAuthorization(authToken, sessionStatus, principal);
        else if(response_type.equals("token"))
            implicitAuthorization(authToken, sessionStatus, principal);
        else
            rejectAuthorization(response_type);
    }
    

    // if the "response_type" is "code", we can process this request.
    //@RequestMapping(value = "/oauth/authorize", params = "response_type=code", method = RequestMethod.GET)
    public void startAuthorization(UnconfirmedAuthorizationCodeClientToken authToken, 
            SessionStatus sessionStatus, Object principal ) {
        if (authToken.getClientId() == null) {
            sessionStatus.setComplete();
            throw new InvalidClientException("A client_id parameter must be supplied.");
        }

        if (!(principal instanceof GWLoginUser)) {
            throw new InsufficientAuthenticationException(
                    "User must be authenticated with Spring Security before authorizing an access token.");
        }
        logger.debug("Forwarding to " + userApprovalPage);        
        result.forwardTo(userApprovalPage);
    }
    
    
    // if the "response_type" is "token", we can process this request.
    // TODO: the request param is unnecessary?
    //@RequestMapping(value = "/oauth/authorize", params = "response_type=token", method = RequestMethod.GET)
    public void implicitAuthorization(UnconfirmedAuthorizationCodeClientToken authToken, 
            SessionStatus sessionStatus, Object principal) {

        if (authToken.getClientId() == null) {
            sessionStatus.setComplete();
            throw new InvalidClientException("A client_id parameter must be supplied.");
        } else {
            authToken.setDenied(false);
        }

        if (!(principal instanceof Authentication)) {
            throw new InsufficientAuthenticationException(
                    "User must be authenticated with Spring Security before authorizing an access token.");
        }

        try {
            String requestedRedirect =
                    redirectResolver.resolveRedirect(authToken.getRequestedRedirect(), clientDetailsService
                            .loadClientByClientId(authToken.getClientId()));
            OAuth2AccessToken accessToken =
                    getTokenGranter().grant("implicit", Collections.<String, String> emptyMap(),
                            authToken.getClientId(), authToken.getClientSecret(), authToken.getScope());
            result.redirectTo(appendAccessToken(requestedRedirect, accessToken));
        } catch (OAuth2Exception e) {
            result.redirectTo(getUnsuccessfulRedirect(authToken, e));
        } finally {
            sessionStatus.setComplete();
        }

    }

    public void rejectAuthorization(String responseType) {
        throw new UnsupportedResponseTypeException("Unsupported response type: " + responseType);
    }

    //@RequestMapping(value = "/oauth/authorize", method = RequestMethod.POST)
    @Post
    @Path(value = "/oauth/authorize")
    public void approveOrDeny(boolean user_oauth_approval,
            String client_id,
            String client_secret,
            String redirect_uri,
            String state,
            String scopes,
            SessionStatus sessionStatus) {
        
        Set<String> scope = OAuth2Utils.parseScope(scopes);
        UnconfirmedAuthorizationCodeClientToken authToken = 
            new UnconfirmedAuthorizationCodeClientToken(client_id, client_secret, scope, state, redirect_uri);
        
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();        

        if (authToken.getClientId() == null) {
            throw new InvalidClientException("A client_id parameter must be supplied.");
        } else {
            authToken.setDenied(!user_oauth_approval);
        }

        if (!(principal instanceof GWLoginUser)) {
            throw new InsufficientAuthenticationException(
                    "User must be authenticated with Spring Security before authorizing an access token.");
        }

        try {
            Authentication authUser = SecurityContextHolder.getContext().getAuthentication();
            //return new RedirectView(getSuccessfulRedirect(authToken, generateCode(authToken, authUser)), false);
            result.redirectTo(getSuccessfulRedirect(authToken, generateCode(authToken, authUser)));
        } catch (OAuth2Exception e) {
            //return new RedirectView(getUnsuccessfulRedirect(authToken, e), false);
            result.redirectTo(getUnsuccessfulRedirect(authToken, e));
        } finally {
            sessionStatus.setComplete();
        }

    }

    private String appendAccessToken(String requestedRedirect, OAuth2AccessToken accessToken) {
        if (accessToken == null) {
            throw new InvalidGrantException("An implicit grant could not be made");
        }
        StringBuilder url = new StringBuilder(requestedRedirect);
        if (requestedRedirect.contains("#")) {
            url.append("&");
        } else {
            url.append("#");
        }
        url.append("access_token=" + accessToken.getValue());
        url.append("&token_type=" + accessToken.getTokenType());
        Date expiration = accessToken.getExpiration();
        if (expiration != null) {
            long expires_in = (expiration.getTime() - System.currentTimeMillis()) / 1000;
            url.append("&expires_in=" + expires_in);
        }
        return url.toString();
    }

    private String generateCode(UnconfirmedAuthorizationCodeClientToken authToken, Authentication authentication)
            throws AuthenticationException {

        try {
            if (authToken.isDenied()) {
                throw new UserDeniedAuthorizationException("User denied authorization of the authorization code.");
            } else if (!userApprovalHandler.isApproved(authToken)) {
                throw new UnapprovedClientAuthenticationException(
                        "The authorization hasn't been approved by the current user.");
            }

            String clientId = authToken.getClientId();
            ClientDetails client = clientDetailsService.loadClientByClientId(clientId);
            String requestedRedirect = authToken.getRequestedRedirect();
            String redirectUri = redirectResolver.resolveRedirect(requestedRedirect, client);
            if (redirectUri == null) {
                throw new OAuth2Exception("A redirect_uri must be supplied.");
            }

            UnconfirmedAuthorizationCodeAuthenticationTokenHolder combinedAuth =
                    new UnconfirmedAuthorizationCodeAuthenticationTokenHolder(authToken, authentication);
            String code = authorizationCodeServices.createAuthorizationCode(combinedAuth);

            return code;

        } catch (OAuth2Exception e) {

            if (authToken.getState() != null) {
                e.addAdditionalInformation("state", authToken.getState());
            }

            throw e;

        }
    }

    protected String getSuccessfulRedirect(UnconfirmedAuthorizationCodeClientToken clientAuth, String authorizationCode) {

        if (authorizationCode == null) {
            throw new IllegalStateException("No authorization code found in the current request scope.");
        }

        String requestedRedirect =
                redirectResolver.resolveRedirect(clientAuth.getRequestedRedirect(), clientDetailsService
                        .loadClientByClientId(clientAuth.getClientId()));
        String state = clientAuth.getState();

        StringBuilder url = new StringBuilder(requestedRedirect);
        if (requestedRedirect.indexOf('?') < 0) {
            url.append('?');
        } else {
            url.append('&');
        }
        url.append("code=").append(authorizationCode);

        if (state != null) {
            url.append("&state=").append(state);
        }

        return url.toString();
    }

    protected String getUnsuccessfulRedirect(UnconfirmedAuthorizationCodeClientToken token, OAuth2Exception failure) {

        // TODO: allow custom failure handling?
        if (token == null || token.getRequestedRedirect() == null) {
            // we have no redirect for the user. very sad.
            throw new UnapprovedClientAuthenticationException("Authorization failure, and no redirect URI.", failure);
        }

        String redirectUri = token.getRequestedRedirect();
        StringBuilder url = new StringBuilder(redirectUri);
        if (redirectUri.indexOf('?') < 0) {
            url.append('?');
        } else {
            url.append('&');
        }
        url.append("error=").append(failure.getOAuth2ErrorCode());
        url.append("&error_description=").append(failure.getMessage());

        if (failure.getAdditionalInformation() != null) {
            for (Map.Entry<String, String> additionalInfo : failure.getAdditionalInformation().entrySet()) {
                url.append('&').append(additionalInfo.getKey()).append('=').append(additionalInfo.getValue());
            }
        }

        return url.toString();

    }

    public void setUserApprovalPage(String userApprovalPage) {
        this.userApprovalPage = userApprovalPage;
    }

    public void setClientDetailsService(ClientDetailsService clientDetailsService) {
        this.clientDetailsService = clientDetailsService;
    }

    public void setAuthorizationCodeServices(AuthorizationCodeServices authorizationCodeServices) {
        this.authorizationCodeServices = authorizationCodeServices;
    }

    public void setRedirectResolver(RedirectResolver redirectResolver) {
        this.redirectResolver = redirectResolver;
    }

    public void setUserApprovalHandler(UserApprovalHandler userApprovalHandler) {
        this.userApprovalHandler = userApprovalHandler;
    }

}
