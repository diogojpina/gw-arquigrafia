package br.org.groupwareworkbench.arquigrafia.oauth;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.oauth.OAuth;
import net.oauth.OAuthAccessor;
import net.oauth.OAuthMessage;
import net.oauth.OAuthProblemException;
import net.oauth.server.OAuthServlet;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.ioc.RequestScoped;

@Resource
@RequestScoped
public class AccessToken {
    private SampleOAuthProvider provider;

    public AccessToken(SampleOAuthProvider provider) {
        this.provider = provider;
    }

    public void accessTokenRequest(HttpServletRequest request, HttpServletResponse response) throws IOException,
            ServletException {
        try {
            OAuthMessage requestMessage = OAuthServlet.getMessage(request, null);

            OAuthAccessor accessor = provider.getAccessor(requestMessage);
            provider.VALIDATOR.validateMessage(requestMessage, accessor);

            // make sure token is authorized
            if (!Boolean.TRUE.equals(accessor.getProperty("authorized"))) {
                OAuthProblemException problem = new OAuthProblemException("permission_denied");
                throw problem;
            }
            // generate access token and secret
            provider.generateAccessToken(accessor);

            response.setContentType("text/plain");
            OutputStream out = response.getOutputStream();
            OAuth.formEncode(OAuth.newList("oauth_token", accessor.accessToken, "oauth_token_secret",
                    accessor.tokenSecret), out);
            out.close();

        } catch (Exception e) {
            provider.handleException(e, request, response, true);
        }
    }
}
