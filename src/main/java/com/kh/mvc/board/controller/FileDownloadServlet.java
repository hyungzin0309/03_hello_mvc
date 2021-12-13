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
		// input스트림에 파일정보 담음 (이진데이터 형태)
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(downFile));
		
//		ServletOutputStream sos = response.getOutputStream();
//		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		//output스트림과 response의 output스트림 연결
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		// 헤더정보 작성
		/**
		 * text/plain는 텍스트 파일을 위한 기본값입니다. 텍스트 파일은 인간이 읽을 수 있어야 하며 이진 데이터를 포함해서는 안됩니다.
		 * application/octet-stream는 다른 모든 경우를 위한 기본값입니다. 알려지지 않은 파일 타입은 이 타입을 사용해야 합니다. 브라우저들은 이런 파일들을 다룰 때, 사용자를 위험한 동작으로부터 보호하도록 개별적인 주의를 기울여야 합니다.
		 */
		// 원래는 jsp의 내용으로 톰캣이 대신 작성했지만 파일 정보를 넘겨줄 땐 직접 써야함
		response.setContentType("application/octet-stream"); // 이진데이터를 가리키는 MIME타입
		// 한글은 기본인코딩 iso-8859-1 처리
		String original = new String(attach.getOriginalFilename().getBytes("utf-8"),"iso-8859-1");
		System.out.println("[FileDownloadServlet] originalName = "+original);
		/**
		 * 일반적인 HTTP 응답에서 Content-Disposition 헤더는 컨텐츠가 브라우저에 inline 되어야 하는 웹페이지 자체이거나 웹페이지의 일부인지,
		 * 아니면 attachment로써 다운로드 되거나 로컬에 저장될 용도록 쓰이는 것인지를 알려주는 헤더입니다.
		 */
		response.setHeader("Content-Disposition","attachment; filename="+original);
	
		// 출력
		// input스트림에 담긴 파일내용을 읽고 output스트림에 전달
		int data = -1;
		// 이진파일을 읽는 기본 단위는 한 바이트
		while((data=bis.read()) != -1) {
			bos.write(data);
		}
		
		//자원반납(필수)
		bos.close();
		bis.close();
		
	}
}
