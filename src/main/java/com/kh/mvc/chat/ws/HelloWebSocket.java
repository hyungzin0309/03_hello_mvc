package com.kh.mvc.chat.ws;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


import com.google.gson.Gson;
import com.google.gson.internal.LinkedHashTreeMap;

@ServerEndpoint(value="/chat/websocket",configurator=HelloWebSocketConfig.class)
public class HelloWebSocket {
	public static Map<String,Session> clients = new HashMap<>(); // 웹소켓 세션
	
	public void clientsLog() {
		System.out.println("현재 접속자 수("+clients.size()+") : "+clients.keySet());
	}
	
	public String msgToJson(String type, String msg, String sender) {
		Map<String,Object> map = new HashMap<>();
		map.put("type", type);
		map.put("msg", msg);
		map.put("sender", sender);
		map.put("time", System.currentTimeMillis());
		return new Gson().toJson(map);
	}
	
	
	//EndpointConfig와 Session은 다르지만 각각의 getUserProperites() 리턴값은 완전 일치
	@OnOpen
	public void onOpen(EndpointConfig config, Session session) { // config-> 속성값으로 memberId, methodMapping 전달
		System.out.println("EndpointConfig.getUserProperties()@HelloWebSocket : "+config.getUserProperties());
		System.out.println("Session.getUserProperties()@HelloWebSocket : "+session.getUserProperties());
//		System.out.println("EndpointConfig : "+config);
//		System.out.println("Session : "+session);
		
		System.out.println("[open]");
		
		Map<String, Object> userProp = config.getUserProperties(); // memberId, methodMapping값? 
		String memberId = (String)userProp.get("memberId");
		clients.put(memberId,session); // clients 맵에 memberId(key):session(value) 삽입
		clientsLog(); // 현재 접속자 수, 접속자 memberId 나타냄 (clients맵에 담겨있는 memberId키셋의 숫자와 키셋 값 활용)
		
		// Session 내부 UserProperties 맵에 memberId저장 -> onClose메소드에서 사용
		Map<String,Object> sessionUserProp = session.getUserProperties();
		sessionUserProp.put("memberId", memberId);
		
		//웰컴메세지 전송
		String msg = msgToJson("welcome","님이 입장했습니다.",memberId);
		onMessage(msg,session);
	
	}
	@OnMessage
	public void onMessage(String msg, Session session) {
		System.out.println("[message]");
		/**
		 * session 관련 처리를 하는 중 clients맵에 변경이 일어나서는 안되므로,
		 * 멀티쓰레드에 대한 동기화처리해야 한다.
		 */
		synchronized(clients) {
			Collection<Session> sessionList = clients.values();
			System.out.println("sessionList : "+sessionList);
			for(Session sess : sessionList) { // for -> sessionList에 있는 모든 세션에 메세지 전송(client리스트 내의 member모두에게 메세지 전송)
				Basic basic = sess.getBasicRemote();
				try {
					basic.sendText(msg);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		}
		
	}
	@OnError
	public void onError(Throwable e) {
		e.printStackTrace();
	}
	@OnClose
	public void onClose(Session session) {
		System.out.println("[close]");
		
		// clients에서 해당사용자 session제거
		Map<String,Object> sessionUserProp = session.getUserProperties();
		String memberId = (String) sessionUserProp.get("memberId");
		clients.remove(memberId);

		clientsLog();
	
		// 다른 사용자에게 알림
		String msg = msgToJson("bye","님이 퇴장했습니다.",memberId);
		onMessage(msg,session);
	}
}
