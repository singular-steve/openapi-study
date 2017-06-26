<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.multi.oauth2client.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.httpclient.*"%>
<%@ page import="org.apache.commons.httpclient.methods.*"%>
<%
	//http://localhost:8000/tistory/callback.jsp?code=f89e9f48f02ffb80b83f33c5970b9557625ab1c77bf45fbdd3304f04734a4770716df952
 	//code �Ķ���ʹ� verification ����. ����ڰ� ���������� ��Ÿ��.
	String code = request.getParameter("code");
	String result = "";

	HashMap<String, String> map = new HashMap<String,String>();
	map.put("client_id", Settings.CLIENT_ID);
	map.put("client_secret", Settings.CLIENT_KEY);
	map.put("redirect_uri", Settings.REDIRECT_URI);
	map.put("grant_type", "authorization_code");
	map.put("code", code);
	
	HttpClient client = new HttpClient();
	client.getParams().setContentCharset("utf-8");
	
	//POST �϶��� client�� clientsecret�� �Ķ���ͷ� ���� ����
	String url = Settings.ACCES_TOKEN_URL;
	PostMethod method = new PostMethod(url);
	method.addParameter("client_id", map.get("client_id"));
	method.addParameter("client_secret", map.get("client_secret"));
	method.addParameter("redirect_uri", map.get("redirect_uri"));
	method.addParameter("grant_type", map.get("grant_type"));
	method.addParameter("code", map.get("code"));
	
	int status = client.executeMethod(method);
	
	if (status == 200) {
		String body = method.getResponseBodyAsString();
		System.out.println(body);
		AccessTokenVO token = OAuth2ClientUtil.getObjectFromJSON(body, AccessTokenVO.class);
		session.setAttribute("access_token", token);
		System.out.println(token.toString());
		response.sendRedirect("main.jsp");
	} else {
		result = "���� ����!!";
	}
%>
<%=result %>
