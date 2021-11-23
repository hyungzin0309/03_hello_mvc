package com.kh.mvc.photo.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.mvc.photo.model.service.PhotoService;
import com.kh.mvc.photo.model.vo.Photo;

/**
 * Servlet implementation class PhotoPageServlet
 */
@WebServlet("/photo/page")
public class PhotoPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private PhotoService photoService = new PhotoService();   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자입력값처리
		int cPage = Integer.parseInt(request.getParameter("cPage"));
		final int numPerPage = 5;
		int start = (cPage - 1) * numPerPage + 1;
		int end = cPage * numPerPage;
		
		// 2. 업무로직
		List<Photo> list = photoService.selectPhotoPage(start,end);
		System.out.println("[photoPageServlet] list = "+list);
		
		
		// 3. json문자열 응답메세지 출력
//		Gson gson = new Gson(); // json 문자열로 변환 위한 Gson객체
//		String jsonStr = gson.toJson(list);  // json 문자열로 변환
//		response.getWriter().append(jsonStr); // 응답메세지 작성
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list,response.getWriter()); // 변환과 응답메세지 작성을 한번에
		
	}

}
