package com.kh.mvc.photo.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.photo.model.service.PhotoService;

/**
 * Servlet implementation class PhotoListServlet
 */
@WebServlet("/photo/photoList")
public class PhotoListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private PhotoService photoService = new PhotoService();  
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 2. 업무로직
		final int numPerPage = 5;
		int totalContent = photoService.selectTotalContent();
		
		int totalPage = (int)Math.ceil((double)totalContent / numPerPage);
		System.out.println(totalPage);
		
		// 3. 응답처리
		request.setAttribute("totalPage", totalPage);
		request
			.getRequestDispatcher("/WEB-INF/views/photo/photoList.jsp")
			.forward(request,response);
	}

}
