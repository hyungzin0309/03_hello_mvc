package com.kh.mvc.member.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.common.filter.MvcUtils;
import com.kh.mvc.member.model.vo.Member;
import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * GET /mvc/member/memberEnroll
	 * 
	 * - 회원가입폼제공
	 * @throws IOException 
	 * @throws ServletException 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
			.forward(request, response);
	
	}

	/**
	 * POST /mvc/member/memberEnroll
	 * 
	 * - DB에 레코드 기록
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 0. 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		// 1. 사용자입력값처리
		String id = request.getParameter("memberId");
//		String pwd = (String)request.getParameter("password");
		String pwd = request.getParameter("password");
		String name = (String)request.getParameter("memberName");
		String gender = (String)request.getParameter("gender");
		
		String _birthday = (String)request.getParameter("birthday");
//		Date birthday = null;
//		if(!"".equals(from));
//			birthday=Date.valueOf(from);
		Date birthday = "".equals(_birthday) ?  null : Date.valueOf(_birthday);
			
		
		String email = (String)request.getParameter("email");
		String phone = (String)request.getParameter("phone");
		String address = (String)request.getParameter("address");
		String[] hobbies = request.getParameterValues("hobby");
		String hobby = hobbies != null? Arrays.toString(hobbies):"없음";
		
		Member member = new Member(id,pwd,name,MemberService.USER_ROLE,gender,birthday,email,phone,address,hobby,null);
		System.out.println(member);
		
		int result = memberService.enrollMember(member);
		
		// 2. 업무로직
		String msg = "";
		if(result ==1) msg = "회원가입 성공";
		else msg = "회원가입 실패";
		
		
		// 3. 응답처리
		HttpSession session = request.getSession();
		session.setAttribute("msg", msg);
		String location = request.getContextPath()+"/";
		response.sendRedirect(location);
	}
}
