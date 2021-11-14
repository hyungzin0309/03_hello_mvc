package com.kh.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberViewServlet
 */
@WebServlet("/member/memberView")
public class MemberViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /*
     * GET방식 : 요청 전후로 Data의 변경이 없는 경우.(데이터 조회 등)
     * 
     * POST방식 : 요청 전후로 Data의 변경이 있는 경우. (등록/수정/삭제)
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 업무로직
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println("-------MemberViewServlet-------");
		// 2. view단 jsp위임
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberView.jsp")
			.forward(request,response);
		
		
	
	}

}
