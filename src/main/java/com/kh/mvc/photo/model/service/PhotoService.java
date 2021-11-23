package com.kh.mvc.photo.model.service;

import java.sql.Connection;
import java.util.List;

import static com.kh.mvc.common.JdbcTemplate.*;
import com.kh.mvc.photo.model.dao.PhotoDao;
import com.kh.mvc.photo.model.vo.Photo;

public class PhotoService {
	private PhotoDao photoDao = new PhotoDao();

	public int selectTotalContent() {
		Connection conn = getConnection();
		int count = photoDao.selectTotalContent(conn);
		close(conn);
		return count;
	}

	public List<Photo> selectPhotoPage(int start, int end) {
		Connection conn = getConnection();
		List<Photo> list = photoDao.selectPhotoPage(conn,start,end);
		close(conn);
		return list;
	}
}
