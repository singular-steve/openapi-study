package httpclient_test;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.DeleteMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.PutMethod;

public class Test02 {

	public static void main(String[] args) throws HttpException, IOException {
		HttpClient client = new HttpClient();
		client.getParams().setContentCharset("utf-8");
		
		String url = "http://70.12.107.190:8000/contactsvc/contacts";
		PostMethod method = new PostMethod(url);
		
		method.setRequestHeader("Content-type", "application/json");
		method.setRequestBody("{\"name\":\"정유라\", \"tel\":\"010-2222-9999\"}");
		int status = client.executeMethod(method);
		
		if(status == 200) {
			String json = method.getResponseBodyAsString();
			System.out.println(json);
		} else {
			System.out.println("Status : " + status);
		}
	}

}
