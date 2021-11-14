package com.kh.mvc.board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Attachment;

/**
 * Servlet implementation class FileDownloadServlet
 */
@WebServlet("/board/fileDownload")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService boardService = new BoardService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력처리
		int no = Integer.parseInt(request.getParameter("no"));
		// 2. 업무처리
		// a. 디비에서 attachment정보 가져오기
		Attachment attach = boardService.selectOneAttachment(no);
		System.out.println("[FileDownloadServlet] attach = " + attach);
		
		// b. 파일다운로드 - 응답메세지에 파일출력
		// 파일입력스트림
		String saveDirectory = getServletContext().getRealPath("/upload/board"); // 파일디렉토리정보
		File downFile = new File(saveDirectory, attach.getRenamedFilename()); // 파일객체에 파일 담음 (파일디렉토리, 파일이름(renamed) 사용)
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(downFile));
		
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		// 헤더정보 작성
		// 원래는 jsp의 내용으로 톰캣이 대신 작성했지만 파일 정보를 넘겨줄 땐 직접 써야함
		response.setContentType("application/octet-stream"); // 이진데이터를 가리키는 MIME타입
		// 한글은 기본인코딩 iso-8859-1 처리
		String original = new String(attach.getOriginalFilename().getBytes("utf-8"),"iso-8859-1");
		System.out.println("[FileDownloadServlet] originalName = "+original);
		response.setHeader("Content-Disposition","attachment; filename="+original);
	
		// 출력
		int data = -1;
		while((data=bis.read()) != -1) {
			bos.write(data);
		}
		
		//자원반납(필수)
		bos.close();
		bis.close();
		
	}
}
