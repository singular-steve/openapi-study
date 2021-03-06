package org.thinker.oauth.controller;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.thinker.oauth.AccessTokenVO;
import org.thinker.oauth.OAuthMsgConstants;
import org.thinker.oauth.OAuthUtil;
import org.thinker.oauth.RequestTokenVO;
import org.thinker.oauth.ResourceTokenVO;
import org.thinker.oauth.Setup;
import org.thinker.oauth.TokenSender;

/**
 * Servlet implementation class TwitterCallBackServlet
 */
public class TwitterCallBackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TwitterCallBackServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 2번 단계
		
		HttpSession session =request.getSession();
		String RT = (String)session.getAttribute("T");
		String RTS = (String)session.getAttribute("TS");
		
		String qs = request.getQueryString();
		AccessTokenVO vo = new AccessTokenVO(qs);
		
		vo.setMethod("GET");
		vo.setConsumerKey(Setup.CK);
		vo.setConsumerSecretKey(Setup.CS);
		vo.setVerifier(vo.getVerifier());		// verifier 값도 넘긴다. AccessTokenVO 생성자에 포함된 로직
		vo.setRequestURL(Setup.AT_URL);
		vo.setRequestOauthToken(RT);
		vo.setRequestOauthTokenSecret(RTS);
		vo.sign();
		
		TokenSender sender = new TokenSender();
		try {
			sender.sendHttpClient(vo);
			session.setAttribute("T", vo.getRequestOauthToken());
			session.setAttribute("TS", vo.getRequestOauthTokenSecret());
			response.sendRedirect("resource");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
