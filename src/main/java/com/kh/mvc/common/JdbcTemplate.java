package com.kh.mvc.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 
 * static 자원을 사용하는 jdbc 공용클래스
 *
 */
public class JdbcTemplate {
	
	private static String driverClass;
	private static String url; // 접속프로토콜@url:port:sid
	private static String user;
	private static String password;
	
	static {
		// resources/datasource.properties 내용 불러오기
		//final String datasourceConfigPath = "datasource.properties";
		
		// build-path의 절대경로 가져오기
		// / -> /src/main/sebapp/WEB-INF/classes/
		// JdbcTemplate.class 파일로부터 properties파일의 경로를 물어 가져오기
		final String datasourceConfigPath = JdbcTemplate.class.getResource("/datasource.properties").getPath();
		System.out.println(datasourceConfigPath);
		
		Properties prop = new Properties();
		try {
			//prop객체에 파일 정보 담기
			prop.load(new FileReader(datasourceConfigPath));
			//각 클래스 변수에 prop객체 내의 diverClass, url, user, passwrod정보 담기
			driverClass = prop.getProperty("driverClass");
			url = prop.getProperty("url");
			user = prop.getProperty("user");
			password = prop.getProperty("password");
		} catch (IOException e) {
			e.printStackTrace();
		};
		
		try {
			// 1. driver class 등록 : 프로그램 실행시 최초 1회만 처리
			Class.forName(driverClass);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() {
		// 2. Connection객체 생성(autoCommit false처리)
		Connection conn = null;
		try {
			//드라이버 매니저객체에 url,user,password 정보를 전달하여 DB에 연결
			conn = DriverManager.getConnection(url, user, password);
			conn.setAutoCommit(false); // 오토커밋 false처리
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	// commit 예외처리
	public static void commit(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void rollback(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//자원반납 예외처리(오버로딩 처리)
	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}

	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null && !pstmt.isClosed())
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed())
				rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	
}
