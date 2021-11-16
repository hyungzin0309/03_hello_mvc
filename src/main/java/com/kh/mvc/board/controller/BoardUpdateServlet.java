package com.kh.mvc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
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
import com.kh.mvc.common.MvcFileRenamePolicy;
import com.kh.mvc.common.filter.MvcUtils;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/board/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 사용자 입력값 처리
		int boardNo = Integer.parseInt(request.getParameter("no"));
		// 2. 입력값 처리
		Board board = boardService.getBoardContent(boardNo);
		// 3. 응답처리
		request.setAttribute("board", board);
		request.getRequestDispatcher("/WEB-INF/views/board/boardUpdate.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			
			// 서버에 파일 저장
			// 디렉토리, 인코딩방식, 리네임정책, request, 최대 포스팅 사이즈
			String saveDirectory = request.getServletContext().getRealPath("/upload/board");
			String encoding = "utf-8";
			int maxPostSize = 1080 * 1080 * 10; // 10MB (byte - MB * 10)
			FileRenamePolicy policy = new MvcFileRenamePolicy();

			
			// 파일저장
			MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding,
					policy);
			System.out.println("서버에 파일 저장 완료");
			
			// 사용자 입력값 처리
			Board board = new Board();
			board.setNo(Integer.parseInt(multipartRequest.getParameter("no")));
			board.setTitle(multipartRequest.getParameter("title"));
			board.setContent(multipartRequest.getParameter("content"));
			String[] delFiles = multipartRequest.getParameterValues("delFile");			

			// 1. 사용자입력처리
			// 디비에 저장할 정보들 정리하기 - 게시물번호, 제목, 내용, attachment


			// 2) 파일

			// 저장된 파일정보 -> Attachment객체 생성 -> List<Attachment>객체에 추가 -> Board객체에 추가
			Enumeration fileNames = multipartRequest.getFileNames(); // type이 file인 input의 name속성 전부 가져오기
			List<Attachment> attachments = new ArrayList<>();
			while (fileNames.hasMoreElements()) {
				String fileName = (String) fileNames.nextElement();
				System.out.println("[BoardUpdateServlet] fileName = " + fileName);
				File upFile = multipartRequest.getFile(fileName);
				if (upFile != null) {
					Attachment attach = MvcUtils.makeAttachment(multipartRequest, fileName);
					attach.setBoardNo(board.getNo());
					attachments.add(attach);
				}
			}
			if (!attachments.isEmpty())
				board.setAttachments(attachments);
//			File file1 = multipartRequest.getFile("upFile1");
//			File file2 = multipartRequest.getFile("upFile2");
//
//			if (file1 != null || file2 != null) {
//				List<Attachment> list = new ArrayList<>();
//				Attachment attach = null;
//				if (file1 != null) {
//					attach = MvcUtils.makeAttachment(multipartRequest, "upFile1");
//					attach.setBoardNo(board.getNo());
//					list.add(attach);
//				}
//				if (file2 != null) {
//					attach = MvcUtils.makeAttachment(multipartRequest, "upFile2");
//					attach.setBoardNo(board.getNo());
//					list.add(attach);
//				}
//				board.setAttachments(list);
//			}
			

			
			// DB수정
			int result = boardService.updateBoard(board);
			String msg = "";
			String location = "";
			if (result > 0) {
				msg = "수정 완료";
				location = request.getContextPath() + "/board/boardView?no=" + board.getNo();
			} else {
				msg = "수정 실패: 관리자에 문의";
				location = request.getContextPath() + "/board/boardUpdate?no=" + board.getNo();
			}
			
			// a. 기존첨부파일 삭제
			if(delFiles != null) {
				for(String temp : delFiles) {
					int delFileNo = Integer.parseInt(temp);
					Attachment attach = boardService.selectOneAttachment(delFileNo);
					
					//가. 첨부파일 삭제 (서버에서)
					String renamedFilename = attach.getRenamedFilename();
					File delFile = new File(saveDirectory, renamedFilename);
					boolean removed = delFile.delete();
					
					//나. DB 첨부파일 레코드 삭제
					result = boardService.deleteAttachment(delFileNo);
					
				}
			}

			// 3. 응답처리

			HttpSession session = request.getSession();
			session.setAttribute("msg", msg);
			response.sendRedirect(location);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
