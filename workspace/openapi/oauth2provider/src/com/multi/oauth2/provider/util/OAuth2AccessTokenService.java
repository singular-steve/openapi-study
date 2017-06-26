/* access token�� DB�� �������� �ʰ� ��Ģ�� ���� ����/�����ϴ� ���
 * 
 * 1. access token ���� ���(������� ���� ��)
 * Enc(user_id&client_id)_Hash(password&client_secret)
 * 
 * 2. �����ÿ��� �Ųٷ� ����
 *   ��. _ ���� split
 *   ��. �պκ��� ��ȣȭ�ϰ� &�� split�ѵ� userid, clientid Ȯ��
 *   ��. �����ͺ��̽����� password, client_secret�� �˾Ƴ� ���� �����ؽ� ����
 *   ��. ���� �ؽÿ� ���޵� access_token ���� ���� �� --> ���� �Ϸ�
 */

package com.multi.oauth2.provider.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import net.oauth.v2.OAuth2Constant;
import net.oauth.v2.OAuth2Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.oauth2.provider.dao.OAuth2DAO;
import com.multi.oauth2.provider.vo.ClientVO;
import com.multi.oauth2.provider.vo.TokenVO;
import com.multi.oauth2.provider.vo.UserVO;


@Service("TokenService")
public class OAuth2AccessTokenService {

	
	@Autowired
	private OAuth2DAO dao = new OAuth2DAO();
	//��ȣȭ
    public String encrypt(String message) throws Exception {

        // use key coss2
        SecretKeySpec skeySpec = new SecretKeySpec(OAuth2Constant.AES_ENCRYPTION_KEY.getBytes("UTF-8"), "AES");

        // Instantiate the cipher
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

        byte[] encrypted = cipher.doFinal(message.getBytes());
        return OAuth2Util.binaryToHex(encrypted);
    }
    
    //��ȣȭ
    public String decrypt(String encrypted) throws Exception {

        SecretKeySpec skeySpec = new SecretKeySpec(OAuth2Constant.AES_ENCRYPTION_KEY.getBytes("UTF-8"), "AES");

        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] original = cipher.doFinal(OAuth2Util.hexToBinary(encrypted));
        String originalString = new String(original);
        return originalString;
    }
    
    public String generateAccessToken(String client_id, String client_secret, String userid, String password) {
    	try {
    		String prev = encrypt(userid+"&"+client_id);
    		String next = OAuth2Util.getHmacSha256(password+"&"+client_secret);
    		next = next.substring(0, 16);
    		
    		System.out.println("### TOKEN BASE GEN : " + userid+"&"+client_id + ", " + password+"&"+client_secret);
    		System.out.println("### HASH : " + next );

    		return prev+"_"+next;
    	} catch (Exception e) {
    		e.printStackTrace();
    		return null;
    	}
    }
	
    //AccessToken�� ������ �� TokenVO��ü�� ����(client_id, userid ����) 
    public TokenVO validateAccessToken(String access_token) {    
    	try {
    		String[] temp = access_token.split("_");
    		//Ŭ���̾�Ʈ �ؽð�
    		String clientHash = temp[1];
    		
    		String base = decrypt(temp[0]);
    		temp = base.split("&");
    		String userid = temp[0];
    		String client_id = temp[1];
    		
    		ClientVO cVOTemp = new ClientVO();
    		cVOTemp.setClient_id(client_id);
    		ClientVO cVO = dao.getClientOne(cVOTemp);
    		
    		UserVO uVOTemp = new UserVO();
    		uVOTemp.setUserid(userid);
    		UserVO uVO = dao.getUserInfo(uVOTemp);

    		System.out.println("### TOKEN BASE GEN : " + userid+"&"+client_id + ", " + uVO.getPassword()+"&"+cVO.getClient_secret());

    		//�ؽð� ����
    		base = uVO.getPassword() + "&" + cVO.getClient_secret();
    		//���� �ؽ�
    		String hash = OAuth2Util.getHmacSha256(base).substring(0, 16);
    		
    		System.out.println(hash + "<><>" + clientHash);
    		
    		if (!clientHash.equals(hash)) {
    			throw new Exception();
    		}
    		
    		TokenVO tVO = null;
    		if (uVO != null && cVO != null) {
    			tVO = new TokenVO();
    			tVO.setClient_id(client_id);
    			tVO.setScope(cVO.getScope());
    			tVO.setAccess_token(access_token);
    			tVO.setClient_type(cVO.getClient_type());
    			tVO.setUserid(userid);
    		}
    		
    		return tVO;
    	}catch(Exception e) {
    		e.printStackTrace();
    		return null;
    	}
    }
    
	// �׽�Ʈ �ڵ�
	public static void main(String[] args) {

		
	}


}
