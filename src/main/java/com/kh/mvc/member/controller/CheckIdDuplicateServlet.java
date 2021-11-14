package com.kh.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.member.model.vo.Member;
import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class CheckIdDuplicate
 */
@WebServlet("/member/checkIdDuplicate")
public class CheckIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력처리
		String memberId = request.getParameter(("memberId"));
		System.out.println("memberId = "+memberId);
		
		// 2. 업무로직
		Member member = memberService.selectOneMember(memberId);
		boolean available = (member==null);
		
		// 3. 응답처리
		request.setAttribute("available",available);
		request.getRequestDispatcher("/WEB-INF/views/member/checkIdDuplicate.jsp")
			.forward(request, response);

	}

}
