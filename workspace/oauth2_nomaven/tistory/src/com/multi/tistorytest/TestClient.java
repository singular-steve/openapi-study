package com.multi.tistorytest;

import java.util.HashMap;

public class TestClient {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("a", "1");
		map.put("name", "ȫ�浿");
		map.put("tel", "010-222-3333");
		
		System.out.println(Settings.getParamString(map)); 
	}

}
