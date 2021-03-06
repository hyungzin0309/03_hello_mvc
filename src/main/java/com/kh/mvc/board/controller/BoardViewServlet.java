package com.kh.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.board.model.vo.BoardComment;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardView")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
		// 1. 사용자 입력처리
		int boardNo = Integer.parseInt(request.getParameter("no"));
		
		// 2. 업무로직
		// 상세보기 요청시, 해당 글에 대한 boardCookie가 존재하지 않을 때 조회수를 1증가한다.
		// a. 검사
		Cookie[] cookies = request.getCookies();
		boolean hasRead = false;
		String boardCookieVal = "";
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				if("boardCookie".equals(name)) {
					boardCookieVal = value; // 기존쿠키값
					if(value.contains("["+boardNo+"]")) {
						hasRead = true;
						break;
					}
						
				}
			}
		}
		// b. 쿠키생성
		// **쿠키는 브라우저별로 관리되기 때문에, 다른 브라우저로 접속하면 조회수 1 더 늘릴 수 있음
		if(!hasRead) {
			int result = boardService.readCountUp(boardNo);
			Cookie cookie = new Cookie("boardCookie",boardCookieVal+"["+boardNo+"]"); // 기존 쿠키 덮어씀
			cookie.setPath(request.getContextPath()+"/board/boardView"); // boardView에서만 사용됨
			cookie.setMaxAge(365*24*60*60); //365일짜리 영속쿠키 // 수명안걸면 session에 담겨서 session종료되면 같이 없어짐
			response.addCookie(cookie);
			
			System.out.println("[BoardViewServlet] 조회수 증가 및 boardCookie생성");
		}
		
		
		
//		Board board = boardService.getBoardContent(boardNo);
		Board board = boardService.getBoardContentAttachment(boardNo);
		
		//XSS공격대비 <>변환처리
		String content = board.getContent().replaceAll("<","&lt;").replaceAll(">","&gt;");
		
		// 3. content의 개행문자 처리
		content = content.replaceAll("\n","<br/>");
		System.out.println(board.getContent());
		board.setContent(content);
		
		// 댓글목록 조회
		List<BoardComment> commentList = boardService.selectBoardCommentList(boardNo);
		System.out.println("[BoardViewServlet] commentList = "+commentList);
		
		
		
		// 3. 응답처리
		request.setAttribute("commentList", commentList);
		request.setAttribute("board", board);
		request
			.getRequestDispatcher("/WEB-INF/views/board/boardView.jsp")
			.forward(request,response);
		
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
