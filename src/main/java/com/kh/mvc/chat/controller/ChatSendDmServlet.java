package com.kh.mvc.chat.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.google.gson.Gson;
import com.kh.mvc.chat.ws.HelloWebSocket;

/**
 * Servlet implementation class ChatSendDmServlet
 */
@WebServlet("/chat/sendDm")
public class ChatSendDmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력값
		String msg = request.getParameter("msg"); // 제이슨문자열 형태의 객체를 저장
		System.out.println(msg);
		Map<String, Object> map = new Gson().fromJson(msg, Map.class);
		System.out.println("[ChatSendDmServlet] map = "+map); // 제이슨 문자열 형태의 객체를 map에 저장
		
		// 2. 업무로직 : clients에서 해당 receiver조회
		Map<String, Object> resultMap = new HashMap<>();
		String receiver = (String)map.get("receiver"); //map내의 제이슨 문자열 형태의 객체에서 receiver속성 가져옴
		Set<String> memberIdSet = HelloWebSocket.clients.keySet(); // clients 목록 가져옴
		if(memberIdSet.contains(receiver)) { // client목록에 수신자가 있다면 -> 현재 수신자가 접속 상태라면
			Session sess = HelloWebSocket.clients.get(receiver); // 리시버의 웹소켓 세션 가져옴
			sess.getBasicRemote().sendText(msg);// json문자열로 전송
			resultMap.put("result","성공적으로 DM을 전송했습니다.");
		}
		else {
			resultMap.put("result", "상대가 접속중이 아닙니다.");
		}
		
		// 3. 응답작성
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(resultMap,response.getWriter());
	}

}
