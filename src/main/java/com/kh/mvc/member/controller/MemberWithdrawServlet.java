package com.kh.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class MemberWithdrawServlet
 */
@WebServlet("/member/memberWithdraw")
public class MemberWithdrawServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 1. 업무로직
			
			// 로그인중인 회원정보
			String memberId = request.getParameter("memberId");
			
			// 회원삭제처리(디비)
			int result = memberService.memberWithdraw(memberId);
			
		// 2. 응답처리
			String msg = "";
			String location = "";
			// 세션속성삭제 및 응답처리
			if(result > 0) {
				session.removeAttribute("loginMember");
				msg = "회원 탈퇴 성공";
				location = request.getContextPath()+"/";
			}
			else {
				msg = "회원 탈퇴 실패 : 관리자에게 문의하세요";
				location = request.getContextPath()+"/member/memberView";
			}
			System.out.println("location@MemberWithdrawServlet : "+request.getContextPath());
			
			session.setAttribute("msg", msg);
			response.sendRedirect(location);
	}
}
