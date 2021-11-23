package com.kh.mvc.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.common.filter.MvcUtils;
import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class BoardListServlet
 */
@WebServlet("/board/boardList")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		// 1. 사용자입력값
		
		// 2. 업무로직
		
		// 2.a 컨텐츠 부분
		String url = request.getRequestURI();
		
		int cPage = 1; // 현재 페이지 기본값
		final int numPerPage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
			//cPage가 널인 경우 예외처리(아무일도 일어나지 않았던 것)
		}catch(Exception e) {
			
		}
		int startNum = (cPage-1)*numPerPage+1; // 해당페이지 시작 게시글 번호
		int endNum = cPage*numPerPage; // 해당 페이지 끝 게시글 번호
		Map<String, Object> param = new HashMap<>();
		param.put("startNum", startNum);
		param.put("endNum", endNum);
		List<Board> list = boardService.selectAllContent(param);
		
		// 2.b 페이지바 부분
		int totalContent = boardService.selectTotalContentCount();
		String pagebar = MvcUtils.getPagebar(cPage,numPerPage,totalContent,url);
				
		
		// 3. 응답처리
		request.setAttribute("list",list);
		request.setAttribute("pagebar",pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp")
			.forward(request,response);
		}catch(Exception e) {
			e.printStackTrace();
			throw e; //was에게 예외처리 던짐 -> web.xml에서 지정한 에러처리페이지로 이동
		}
	}

}
