package com.kh.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.board.model.service.BoardService;

/**
 * Servlet implementation class CommentDeleteServlet
 */
@WebServlet("/board/commentDelete")
public class CommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		
		// 1. 입력값 처리
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		// 2. 업무로직
		int result = boardService.commentDelete(commentNo);
		String msg = result>0? "댓글 삭제 완료" : "댓글 삭제 실패"; 
		// 3. 응답처리
		request.getSession().setAttribute("msg",msg);

//		String location = request.getContextPath()+"/board/boardView?no="+boardNo;
		String location = request.getHeader("Referer");
		response.sendRedirect(location);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
