package com.kh.mvc.chat.ws;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import com.kh.mvc.member.model.vo.Member;

public class HelloWebSocketConfig extends Configurator{
	
	/*
	 * HandshakeRequest request
	 * HandshakeResponse response
	 * 
	 * ServerEndPointConfig객체에 memberId정보를 넣어 다시 HelloWebSocket으로 전달
	 * 여기서의 ServerEndpointConfig객체와 HelloWebSocket의 EndpointConfig객체는 완전히 동일함
	 */
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		
		HttpSession httpSession = (HttpSession) request.getHttpSession();
		Member loginMember = (Member)httpSession.getAttribute("loginMember");
		
		Map<String,Object> userProp = sec.getUserProperties();
		userProp.put("memberId",loginMember.getMemberid());
		
		System.out.println("ServerEndpointConfig.getUserProperties()@HelloWebSocketConfig : "+userProp);
		System.out.println("ServerEndpointConfig@HelloWebSocketConfig"+sec);
//		Set<String> keySet = userProp.keySet();
//		for(String key : keySet) {
//			System.out.println(key+" = "+userProp.get(key));
//		}
		
	}
	
}
