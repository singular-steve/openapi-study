package com.sds.testprovider.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.thinker.oauth.parameter.OAuthTokenParam;
import org.thinker.oauth.util.OAuthUtil;

import com.sds.testprovider.dao.ConsumerDAOImpl;
import com.sds.testprovider.model.ConsumerVO;
import com.sds.testprovider.model.UsersVO;
import com.sds.testprovider.service.ConsumerService;
import com.sds.testprovider.service.UsersService;
import com.sds.testprovider.util.SessionUtil;

@Controller
public class MyInfoController {
	private static Logger logger = Logger.getLogger(ConsumerDAOImpl.class); 
	
	@Autowired
	private UsersService usersService;
	
	@Resource(name="xmlTemplate")
	private View xmlView;
	
	@Autowired
	private Jaxb2Marshaller jaxb2Mashaller;
	
	@Autowired
	private ConsumerService consumerService;
	
	@RequestMapping(value="/myinfo")
	public ModelAndView getMyInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			UsersVO usersVO = validateOAuthToken(request);
			mav.setView(xmlView);
			mav.addObject(usersVO);
		} catch (Exception e) {
			throw new Exception (e.getMessage());
		}
		return mav;
	}
	
	//Session���� �̹� ������ �Ǿ��ų�  OAuthToken�� ��ȿ�ϴٸ� ���� ����!
	private UsersVO validateOAuthToken(HttpServletRequest request) throws Exception {
		//�Ʒ� return ���� �ּ� ó���ϰ� �ڵ带 �ۼ��մϴ�.
		return null;
	}
}