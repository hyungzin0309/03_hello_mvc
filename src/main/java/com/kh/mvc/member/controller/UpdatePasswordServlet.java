package com.kh.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.member.model.vo.Member;
import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class UpdatePasswordServlet
 */
@WebServlet("/member/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
       
	/**
	 * 비밀번호 변경 페이지 접근 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp")
			.forward(request,response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력 처리
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		System.out.println("old@UpdatePassword = "+oldPassword);
		System.out.println("new@UpdatePassword = "+newPassword);
		// 2. 업무로직
		/**
		 * 주의할 점?
		 * 1. 기존의 비밀번호를 어디서 가져올 것인지? (디비까지 가지 말고 session내 loginMember속성으로 처리?)
		 * 2. 비밀번호가 바뀌면 session의 loginMember정보를 다시 바꿔줘야 함
		 * 3. 
		 *
		 */
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println("loginMember@UpdatePassword = "+loginMember);
//		Member updateMember = memberService.selectOneMember(loginMember.getMemberid());
		Member updateMember = null;
		try {
			updateMember = (Member)loginMember.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		updateMember.setPassword(newPassword);
		System.out.println("updateMember@UpdatePassword = "+updateMember);
		
		int result = 0;
		String msg = "";
		
		// 기존 비밀번호 일치
		System.out.println("loginMember.getPassword()@UpdatePassword = "+loginMember);
		if(oldPassword.equals(loginMember.getPassword())){
			result = memberService.updatePassword(updateMember);
			msg = (result >=1) ? "비밀번호 변경 완료" : "비밀번호 변경 실패 : 관리자에게 문의하세요";
			//session의 로그인 정보 바꾸기
			session.setAttribute("loginMember", updateMember);
		}
		else {
			msg = "비밀번호가 일치하지 않습니다.";
		}
		
		// 3. 응답처리
		session.setAttribute("msg", msg);
//		response.sendRedirect("/WEB-INF/views/member/updatePassword.jsp");
		response.sendRedirect(request.getContextPath()+"/member/memberView");
	}
}
