/*
 * Copyright 2007 AOL, LLC.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.org.groupwareworkbench.arquigrafia.oauth;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.oauth.OAuth;
import net.oauth.OAuthAccessor;
import net.oauth.OAuthMessage;
import net.oauth.server.OAuthServlet;

import org.springframework.security.core.context.SecurityContextHolder;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.download.InputStreamDownload;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupwareworkbench.core.session.GWLoginUser;

/**
 * Autherization request handler.
 * 
 * @author Praveen Alavilli
 */
@Resource
@RequestScoped
public class Authorization {
    private SampleOAuthProvider provider;
    private Result result;

    public Authorization(SampleOAuthProvider provider, Result result) {
        this.provider = provider;
        this.result = result;
    }

    public Download authorizeGet(HttpServletRequest request, HttpServletResponse response) throws IOException,
            ServletException {
        try {
            OAuthMessage requestMessage = OAuthServlet.getMessage(request, null);

            OAuthAccessor accessor = provider.getAccessor(requestMessage);

            if (Boolean.TRUE.equals(accessor.getProperty("authorized"))) {
                // already authorized send the user back
                return returnToConsumer(request, response, accessor);
            }
            sendToAuthorizePage(request, accessor);
            return null;

        } catch (Exception e) {
            provider.handleException(e, request, response, true);
            return null;
        }

    }

    public Download authorizePost(HttpServletRequest request, HttpServletResponse response) throws IOException,
            ServletException {

        try {
            OAuthMessage requestMessage = OAuthServlet.getMessage(request, null);
            OAuthAccessor accessor = provider.getAccessor(requestMessage);

            String userId = request.getParameter("userId");
            if (userId == null) {
                sendToAuthorizePage(request, accessor);
                return null;
            }
            // set userId in accessor and mark it as authorized
            provider.markAsAuthorized(accessor, userId);

            return returnToConsumer(request, response, accessor);

        } catch (Exception e) {
            provider.handleException(e, request, response, true);
            return null;
        }
    }

    private void sendToAuthorizePage(HttpServletRequest request, OAuthAccessor accessor) throws IOException,
            ServletException {
        String callback = request.getParameter("oauth_callback");
        if (callback == null || callback.length() <= 0) {
            callback = "none";
        }

        String consumer_description = (String) accessor.consumer.getProperty("description");

        result.include("appDesc", consumer_description);
        result.include("callback", callback);
        result.include("token", accessor.requestToken);
        result.forwardTo(OAuthController.class).authorize();

    }

    private Download returnToConsumer(HttpServletRequest request, HttpServletResponse response, OAuthAccessor accessor)
            throws IOException, ServletException {
        // send the user back to site's callBackUrl
        String callback = request.getParameter("oauth_callback");
        if ("none".equals(callback) && accessor.consumer.callbackURL != null &&
                accessor.consumer.callbackURL.length() > 0) {
            // first check if we have something in our properties file
            callback = accessor.consumer.callbackURL;
        }

        if ("none".equals(callback)) {
            // no call back it must be a client
            StringBuilder out = new StringBuilder();
            out.append("You have successfully authorized '" + accessor.consumer.getProperty("description") +
                    "'. Please close this browser window and click continue" + " in the client.");
            result.nothing();
            return new InputStreamDownload(new ByteArrayInputStream(out.toString().getBytes()), "text/plain", "");

        }
        // if callback is not passed in, use the callback from config
        if (callback == null || callback.length() <= 0) callback = accessor.consumer.callbackURL;
        String token = accessor.requestToken;
        if (token != null) {
            callback = OAuth.addParameters(callback, "oauth_token", token);
        }
        result.redirectTo(callback);
        // response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
        // response.setHeader("Location", callback);
        return null;

    }
}
