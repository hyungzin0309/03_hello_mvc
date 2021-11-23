package com.kh.mvc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Attachment;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.common.MvcFileRenamePolicy;
import com.kh.mvc.common.filter.MvcUtils;
import com.kh.mvc.member.controller.MemberViewServlet;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class BoardEnrollServlet
 */
@WebServlet("/board/boardEnroll")
public class BoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {// 1. 사용자 입력 처리
			
			// A. server computer에 사용자 업로드파일 저장
			// cos.jar : 파일 업로드 기능 구현 오픈소스 라이브러리
			// 서버 어떤 디렉토리에 파일을 저장할 것인지
			String saveDirectory = getServletContext().getRealPath("/upload/board");
			System.out.println("[BoardEnrollServlet] saveDirectory = "+saveDirectory);
			
			// 첨부파일 최대 용량
			int maxPostSize = 1024*1024*10; // 10MB
			// 인코딩방식
			String encoding = "utf-8";
			
			// 파일명 재지정 정책객체 : 
			// DefaultFileRenamePolicy 동일한 이름의 파일은 numbering을 통해 overwrite을 방지(기본형)
			// FileRenamePolicy policy = new DefaultFileRenamePolicy();
			FileRenamePolicy policy = new MvcFileRenamePolicy(); // 내가 만든 rename메소드가 담긴 클래스 (FileRenamePolicy을 구현하는 클래스임)
			
			// 객체생성하는 순간 서버에 사용자 파일이 저장되며 정책에 따라 renamed된 이름도 발급됨
			// multipartRequest객체에 policy객체 넘겨주면 알아서 policy내의 메소드 사용해서 renamed파일이름 생성하여 객체 내에 저장
			MultipartRequest multipartRequest = new MultipartRequest(request,saveDirectory,maxPostSize,encoding,policy);
			
			// B. DB에 파일정보 저장
			// MultipartRequest 객체 생성하는 경우, 기존 request가 아닌 MultipartRequest객체에서 값을 가져와야 한다.
			// (약속)
			String writer = multipartRequest.getParameter("writer");
			String title = multipartRequest.getParameter("title");
			String content = multipartRequest.getParameter("content");
			
//			Map<String, Object> param = new HashMap<>();
//			param.put("writer", writer);
//			param.put("title", title);
//			param.put("content", content);
			Board board = new Board();
			board.setWriter(writer);
			board.setTitle(title);
			board.setContent(content);
			
			// 저장된 파일정보 -> Attachment객체 생성 -> List<Attachment>객체에 추가 -> Board객체에 추가
			// request가 아니라 multipartRequest객체에서 파일 받아옴
			File upFile1= multipartRequest.getFile("upFile1");
			File upFile2= multipartRequest.getFile("upFile2");
			if(upFile1 != null || upFile2 != null) {
				//파일이 있다면 리스트에 담아 board의 객체변수로 넘겨줌
				List<Attachment> attachments = new ArrayList<>();
				
				// 현재 fk인 boardNo필드값은 비어있다.
				if(upFile1 != null) {
					Attachment attach1 = MvcUtils.makeAttachment(multipartRequest, "upFile1");
					attachments.add(attach1);
				}
				if(upFile2 != null) {
					Attachment attach2 = MvcUtils.makeAttachment(multipartRequest, "upFile2");
					attachments.add(attach2);
				}
				board.setAttachments(attachments); // 첨부파일 리스트를 board객체에 저장
				System.out.println("[BoardEnrollServlet] attachment = "+attachments);
			}
			
			
			// 2. 업무로직
			int result = boardService.insertBoard(board);
			
			HttpSession session = request.getSession();
			String msg = (result>0) ? "게시글 등록 완료" : "게시글 등록 실패 : 관리자에게 문의하세요.";
			session.setAttribute("msg",msg);
			
			response.sendRedirect(request.getContextPath()+"/board/boardView?no="+board.getNo());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

}
