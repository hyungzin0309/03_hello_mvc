package com.kh.mvc.member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.common.filter.MvcUtils;
import com.kh.mvc.member.model.vo.Member;
import com.kh.mvc.member.service.MemberService;

@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// 0. 인코딩처리
		request.setCharacterEncoding("utf-8");
		System.out.println("---------submit성공---------");
		// 1. 사용자 입력값 처리
		String memberId = request.getParameter("memberId");
		String memberName = request.getParameter("memberName");
		String _birthday = request.getParameter("birthday");
		Date birthday = null;
		if(!_birthday.equals("")){
			birthday = Date.valueOf(_birthday);
		}
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String[] hobbies = request.getParameterValues("hobby");
		String hobby = null;
		if(hobbies!=null) {
			hobby = String.join(",", hobbies);
		}
		
		Member member = new Member(memberId,null,memberName,MemberService.USER_ROLE,gender,birthday,email,phone,address,hobby,null);
		
		int result = memberService.memberUpdate(member);
		
		// 2. 업무로직
		String msg = (result >= 1)? "정보수정 성공!":"정보수정 실패";
		if(result >0 ) {
			Member updateMember = memberService.selectOneMember(memberId);
			session.setAttribute("loginMember",updateMember);			
		}
		
		// 3. 응답처리(url에 요청정보 남지 않게 하기)
		session.setAttribute("msg",msg);
		response.sendRedirect(request.getContextPath()+"/member/memberView");	
	}
}
