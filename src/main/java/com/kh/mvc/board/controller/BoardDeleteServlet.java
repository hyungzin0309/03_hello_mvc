package com.kh.mvc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Attachment;
import com.kh.mvc.board.model.vo.Board;

/**
 * Servlet implementation class BoardDeleteServlet
 */
@WebServlet("/board/boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		// 1. 사용자입력처리
		int boardNo = Integer.parseInt(request.getParameter("no"));
		// 2. 업무로직
		// a. 업로드파일 삭제 : java File api 파일제거
			
		//attachments 정보 가져오기
		Board board = boardService.getBoardContent(boardNo);
		List<Attachment> list = board.getAttachments();
		
		//파일삭제
		if(list != null) {
			for(Attachment attach : list) {
				String saveDirectory = getServletContext().getRealPath("/upload/board");
				String renamedFilename = attach.getRenamedFilename();
				File file = new File(saveDirectory,renamedFilename);
				if(file.exists()) {
					file.delete();
					System.out.println("파일삭제 성공!");
				}				
			}
		}
		// b. board레코드(행) 삭제 (attachment는 on delete cascade에 의해 자동으로 제거된다.)
		int result = boardService.deleteBoard(boardNo);
		String msg = "";
		String location = "";
		if(result > 0) {
			msg = "게시물 삭제 완료";
			location = request.getContextPath()+"/board/boardList";
		}
		else {
			msg = "게시물 삭제 실패: 관리자에 문의";
			location = request.getContextPath()+"/board/boardView";			
		}
		// 3. 응답처리 (redirect -> boardList.jsp)
		HttpSession session = request.getSession();
		session.setAttribute("msg", msg);
		response.sendRedirect(location);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
