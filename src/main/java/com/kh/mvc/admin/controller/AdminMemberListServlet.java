package com.kh.mvc.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.common.filter.MvcUtils;
import com.kh.mvc.member.model.vo.Member;
import com.kh.mvc.member.service.MemberService;

/**
 * Servlet implementation class AdminMemberListServlet
 */
@WebServlet("/admin/memberList")
public class AdminMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	/**
	 * sql 
	 * select * from member order by enroll_date desc
	 * 
	 * paging recipe
	 * 1. content section
	 * 	- cPage 현재 페이지
	 * 	- numPerPage 한 페이지당 게시물 수
	 * 	- startNum, endNum 
	 * 
	 * 
	 * 2. pagebar section
	 * 	- totalContent 총 게시물 수
	 * 	- totalPage 총 페이지 수
	 *  - pagebarSize 표시할 페이지 수
	 *  - pageNo 증감변수
	 *  - pageStart | pageEnd
	 *  - url
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.사용자입력값
		final int numPerPage = 10; // 페이지당 게시물 수
		int cPage = 1; // 현재페이지
		try {
			// 인수값이 null인 경우 cPage값에 변화 x
			cPage = Integer.parseInt(request.getParameter("cPage")); // cPage : 현재페이지
		}catch(NumberFormatException e) {}
		
		int startNum = (cPage-1)*numPerPage+1; // 각 페이지의 첫 게시글 번호 ex)cPage값이 3으로 전달되면 그 페이지의 첫 게시글은 21번 게시
		int endNum = cPage*numPerPage; // 각 페이지의 마지막 게시글 번호
		
		Map<String, Object> param = new HashMap<>();
		param.put("startNum", startNum);
		param.put("endNum", endNum);
		
		// 2.업무로직
		
		// 2-a. content영역
		List<Member> list = memberService.selectAllMember(param); //Map에 저장된 번호에 해당되는 게시글들만 불러옴
		System.out.println("list@servlet = " + list);
		
		// 2-b. pageBar영역
		int totalContent = memberService.selectTotalMemberCount();
		String url = request.getRequestURI(); // /mvc/admin/memberList
		System.out.println("totalContent@servlet = "+totalContent);
		System.out.println("url@servlet = "+url);
		
		/*
		 * pagebar : 페이지바를 나타내는 html을 그대로 가지고 있는 문자열
		 * 
		 * MvcUtils.getPagebar(cPage, numPerPage, totalContent, url)
		 * - cPage, numPerPage, totalContent에 따라 적절한 페이지바 html을 생성해주는 메소드
		 */
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
		System.out.println("pagebar@servlet = "+pagebar);
		
		// 3.view단처리
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/admin/memberList.jsp")
			.forward(request, response);
	}
}
