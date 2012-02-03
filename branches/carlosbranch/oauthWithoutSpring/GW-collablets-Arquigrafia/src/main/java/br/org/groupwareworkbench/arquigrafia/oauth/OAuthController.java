package br.org.groupwareworkbench.arquigrafia.oauth;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.oauth.OAuthAccessor;
import net.oauth.OAuthException;
import net.oauth.OAuthMessage;
import net.oauth.server.OAuthServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.download.InputStreamDownload;
import br.org.groupwareworkbench.collablet.coord.role.Role;
import br.org.groupwareworkbench.collablet.coord.user.User;

@Resource
public class OAuthController {
    @Autowired
    private Result result;
    @Autowired
    private RequestToken requestToken;
    @Autowired
    private Authorization authorization;
    @Autowired
    private AccessToken accessToken;
    @Autowired
    private SampleOAuthProvider provider;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private HttpServletResponse response;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /*
     * public OAuthController(Result result, RequestToken requestToken, Authorization authorization, AccessToken
     * accessToken, SampleOAuthProvider provider, HttpServletRequest request, HttpServletResponse response) {
     * this.result = result; this.accessToken = accessToken; this.requestToken = requestToken; this.authorization =
     * authorization; this.provider = provider; this.request = request; this.response = response; }
     */

    @Get
    @Post
    @Path("/request_token")
    public void requestToken() {
        try {
            requestToken.requestToken(request, response);
            result.nothing();
        } catch (Exception e) {
            logger.error("Aconteceu um erro processando o request token", e);
            result.notFound();
        }
    }

    @PreAuthorize("hasRole('ROLE_CLIENT')")
    @Get
    @Path("/authorize")
    public Download authorizeGet() {
        try {
            return authorization.authorizeGet(request, response);
        } catch (Exception e) {
            logger.error("Aconteceu um erro processando o authorization request", e);
            result.notFound();
            return null;
        }
    }

    @PreAuthorize("hasRole('ROLE_CLIENT')")
    @Post
    @Path("/authorize")
    public Download authorizePost() {
        try {
            return authorization.authorizePost(request, response);
        } catch (Exception e) {
            logger.error("Aconteceu um erro processando o authorization request post", e);
            result.notFound();
            return null;
        }
    }

    @Get
    @Post
    @Path("/access_token")
    public void accessToken() {
        try {
            accessToken.accessTokenRequest(request, response);
            result.nothing();
        } catch (Exception e) {
            logger.error("Aconteceu um erro processando o access token", e);
            result.notFound();
        }
    }

    public void authorize() {
    }

    @Get
    @Post
    @Path("/echo")
    public Download echo() throws IOException, ServletException {
        try {
            OAuthMessage requestMessage = OAuthServlet.getMessage(request, null);
            OAuthAccessor accessor = provider.getAccessor(requestMessage);
            provider.VALIDATOR.validateMessage(requestMessage, accessor);

            String userId = (String) accessor.getProperty("user");

            StringBuilder out = new StringBuilder();
            out.append("[Your UserId:" + userId + "]\n");
            for (Object item : request.getParameterMap().entrySet()) {
                Map.Entry parameter = (Map.Entry) item;
                String[] values = (String[]) parameter.getValue();
                for (String value : values) {
                    out.append(parameter.getKey() + ": " + value + "\n");
                }
            }
            return new InputStreamDownload(new ByteArrayInputStream(out.toString().getBytes()), "text/plain", "echo");

        } catch (Exception e) {
            provider.handleException(e, request, response, false);
            result.nothing();
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return null;
        }
    }

    @Get
    @Path("/protected")
    public Download protectedResource() {
        Set<String> roleCodes = new TreeSet<String>();
        roleCodes.add("ROLE_CLIENT");

        OAuthMessage requestMessage = OAuthServlet.getMessage(request, null);
        OAuthAccessor accessor = null;
        try {
            accessor = provider.getAccessor(requestMessage);
            provider.VALIDATOR.validateMessage(requestMessage, accessor);

            User user = User.findById(Long.parseLong((String) accessor.getProperty("user")));

            if (user != null) {
                if (!Role.areGWSecurityRolesPresentInRoles(roleCodes, user.getRoles()))
                    throw new OAuthException(
                            "O usuario con este access token não possui permisoẽs suficienes para o recurso");

            } else throw new OAuthException("não existe um usuario para este access token");

        } catch (OAuthException e) {
            if (accessor == null) logger.info("Não há um access token");
            else logger.info(e.getMessage());
            result.nothing();
            response.setStatus(401);
            return null;
        } catch (IOException e) {
            logger.error("Error de entrada saida", e);
            result.nothing();
            response.setStatus(401);
            return null;
        } catch (URISyntaxException e) {
            logger.warn("Erro de sintaxi na uri", e);
            result.nothing();
            response.setStatus(401);
            return null;
        }

        return new InputStreamDownload(new ByteArrayInputStream("accesando recurso protegido".getBytes()),
                "text/plain", "");

    }
}
