package com.kh.mvc.photo.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static com.kh.mvc.common.JdbcTemplate.*;
import com.kh.mvc.photo.model.vo.Photo;

public class PhotoDao {
	
	private Properties prop = new Properties();
	public PhotoDao(){
		//properties 파일 디렉토리 불러오기
		String directory = PhotoDao.class.getResource("/photo-query.properties").getPath();
		System.out.println("photo-query.properties = "+directory);
		
		//prop에 파일정보 넣기
		try {
			prop.load(new FileReader(directory));
			System.out.println("prop = " + prop);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	public int selectTotalContent(Connection conn) {
		int count = 0;
		String sql = prop.getProperty("selectTotalContent");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				count = rset.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}


	public List<Photo> selectPhotoPage(Connection conn, int start, int end) {
		List<Photo> list = new ArrayList<>();
		String sql = prop.getProperty("selectPhotoPage");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Photo photo = new Photo();
				photo.setNo(rset.getInt("no"));
				photo.setWriter(rset.getString("writer"));
				photo.setContent(rset.getString("content"));
				photo.setOriginalFilename(rset.getString("original_filename"));
				photo.setRenamedFilename(rset.getString("renamed_filename"));
				photo.setRegDate(rset.getDate("reg_date"));
				photo.setReadCount(rset.getInt("read_count"));
				list.add(photo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		return list;
	}

}
