<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>OAuth Simple Provider Example!</h1>
	<hr>
	-----------------------------------<br/>
	Consumer ��� �ܰ� <br/>
	-----------------------------------<br/>	
	1. ����� ID�� �α����Ѵ�. �̸� �����Ǵ� ID�� gdhong, user1, user2. ��ȣ�� ��� 12345!!<br/>
	2. Application ��� �������� �̵��Ͽ� Application Name�� Callback URL�� �Է��ϰ� ��Ϲ�ư�� �����Ѵ�.<br/>
	3. Consumer Key & Consumer Secret �� Access Token & Access Token Secret�� �����Ͽ� tbl_users
	���̺� ����Ѵ�. <br/><br/>
	-----------------------------------<br/>
	requestToken ��û �ܰ�  - request_token ����<br/>
	-----------------------------------<br/>
	1. Consumer�� request Token�� ��û�ؿ��� ��û ������ �Ľ��Ѵ�.<br/>
	2. ��û ���� ����<br/>
	  - oauth_consumer_key : <br/>
	  - oauth_signature_method :<br/>
	  - oauth_timestamp :<br/>
	  - oauth_nonce :<br/>
	  - oauth_callback : <br/>
	  - oauth_signature :<br/><br/>
	  
	3. Ȯ���� ����<br/>
	  - consumer_key�� �ش��ϴ� ���ڵ带 tbl_oauth_key ���̺��� �о. --> ���ڵ尡 ������ ����!!<br/>
	  - consumersecret���� �о -> �̰����� consumerkey~callback������ �����Ͽ� ������ ���� 
	          ���۵� oauth_signature���� ��ġ�ϴ��� ���� Ȯ��. --> ��ġ���� ������ ����!! <br/>
	  - oauth_timestamp ���� �ð����� �������� ������ timestamp���� ���̰� 10�� �̻�(�̰��� 
	         ���� ���ι��̴��� ������ ������ ��.)�̶�� ��ȿ�� request�� �ƴ϶�� �Ǵ��Ͽ� �����߻�!!<br/>
	  - callbackUrl: ���� ���۵��� �ʾҴٸ�, callbackUrl�� ���� �� �̵��ϴ� ��ΰ� ��.<br/>
	  - ��� �������̶�� requesttoken�� request token secret �����ϰ�, 
	     tbl_request_token ���̺� ���ڵ� ���� 
	     --> ���嵥���ʹ�  requesttoken,request token secret, consumer key<br/> 
	4. Ȯ���� �Ϸ�Ǿ��ٸ�, ���� ������ Consumer���� ����<br/>
      - oauth_token : request_token<br/>
      - oauth_token_secret : request_token_secret<br/>
      - oauth_callback_confirmed : true<br/>
      - �̿��� �߰����� �Ķ����<br/><br/>
 	-----------------------------------<br/>
	Authorize ��û �ܰ�- authorize ����<br/>
	-----------------------------------<br/>     
    1. ��û ������ Ȯ���Ͽ� oauth_token ���� �Ľ��Ѵ�.<br/>
    2. �α��� �������� �̵��Ѵ�. --> �α����ϰ� �����ϵ��� �Ѵ�. ���� �α��ε� ���¶��,
                  ���ι�ư�� Ŭ���Ͽ� �����ϵ��� �Ѵ�.<br/>
    3. ���ι�ư�� Ŭ���ϸ�, tbl_request_token ���̺��� request_token(oauth_token) ���� ���� ���ڵ带 
                ã�� verifier ���� ������ ���� ���ڵ� ���� �����Ѵ�. (����ִ� verifier �ʵ尪 ����)<br/>
    4. �׷� �� �̸� ����ϰų� ��û���� callback URL�� �̵���Ų��.
                �̵���ų �� oauth_token�� verifier ���� queryString ���·� �ٿ� �����Ѵ�.<br/><br/>
	      
 	-----------------------------------<br/>
	AccessToken ��û �ܰ� <br/> - access_token ����<br/>
	-----------------------------------<br/>     
	1. ��û ������ Ȯ���Ͽ� �� ������ �Ľ��Ѵ�.
	    - oauth_consumer_key :
		- oauth_signature_method :
		- oauth_token :
		- oauth_verifier : 
		- oauth_callback : 
		- oauth_timestamp : 
		- oauth_nonce : 
		- oauth_signature : 
	2. 1���� oauth_signature���� ������ ���� HMAC + Consumer Secret ���� ������ ����� �ǹ��Ѵ�.
	3. Consumer Key ������ �̿��Ͽ� tbl_auth_key ���̺��� Consumer Key�� ���� ���ڵ� ������ �ε��Ѵ�.
	4. ��û ��������, oauth_signature����, ������ ������ ���̺��� �о Consumer Secret ������ 
	    ������ ���� ���Ͽ� ���������� Ȯ���Ѵ�. �ٸ��ٸ� ���� ��������!!
    5. oauth_timestamp ���� �ð� ���� �������� ������ timestamp���� ���̰� 10�� �̻�(�̰��� 
	         ���� ���ι��̴��� ������ ������ ��.)�̶�� ��ȿ�� request�� �ƴ϶�� �Ǵ��Ͽ� �����߻�!!<br/>
	6. ���� ��� ������ �����Ӵٸ�, tbl_request_token ���̺��� ���ڵ��� oauth_token�� �ش��ϴ� 
	     ���ڵ带 �����ϰ�
	7. Consumer ���̺��� Consumer Key�� �ش��ϴ� Access Token ���� ��(oauthtoken, 
	   oauthtokensecret �ʵ尪)�� �о�� Consumer���� �����Ѵ�.
	
	-------------------------------------<br/>
	Access Token �� Access TOken Secret�� ���� Consumer�� ó��<br/>
    : Consumer�� Request Token & Secret ��� Access Token & Secret�� �Ѱܹ޾Ҵ�.<br/>
       �������� �̿��� �����Ͽ� Provider���� ��ȣ�� �ڿ��� ��û�Ѵ�.<br/>
	-------------------------------------<br/>
	1. ���� ������ ������ ������ �Բ� Protected Resource�� �����Ѵ�.<br/>
	- oauth_consumer_key :<br/>
	- oauth_token : Access Token<br/>
	- oauth_signature_method :<br/>
    - oauth_timestamp : <br/>
	- oauth_nonce :<br/>
	- oauth_version :<br/>
	- oauth_signature : Access Token Secret���� ���� ������ ������ ��!! <br/>
	
	
	
	
		
</body>
</html>