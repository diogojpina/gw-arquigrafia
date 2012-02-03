package br.org.groupwareworkbench.arquigrafia.oauth;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.net.URISyntaxException;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.oauth.OAuthAccessor;
import net.oauth.OAuthException;
import net.oauth.OAuthMessage;
import net.oauth.server.OAuthServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Sets;

import br.com.caelum.vraptor.InterceptionException;
import br.com.caelum.vraptor.core.InterceptorStack;
import br.com.caelum.vraptor.interceptor.Interceptor;
import br.com.caelum.vraptor.resource.ResourceMethod;
import br.org.groupwareworkbench.collablet.coord.role.Role;
import br.org.groupwareworkbench.collablet.coord.user.User;

public class OAuthResourceAccessVerificationInterceptor implements Interceptor {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private SampleOAuthProvider provider;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public OAuthResourceAccessVerificationInterceptor(HttpServletRequest request, HttpServletResponse response,
            SampleOAuthProvider provider) {
        this.request = request;
        this.response = response;
        this.provider = provider;
    }

    @Override
    public boolean accepts(ResourceMethod arg0) {
        if (arg0.containsAnnotation(OAuthResource.class)) return true;
        return false;
    }

    @Override
    public void intercept(InterceptorStack stack, ResourceMethod method, Object resourceInstance)
            throws InterceptionException {
        String[] codes = method.getMethod().getAnnotation(OAuthResource.class).roles();
        Set<String> roleCodes = Sets.newHashSet(codes);
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
            response.setStatus(401);
        } catch (IOException e) {
            logger.error("Error de entrada saida", e);
            response.setStatus(401);
        } catch (URISyntaxException e) {
            logger.warn("Erro de sintaxi na uri", e);
            response.setStatus(401);
        }
    }
}
