package com.kh.mvc.common.filter;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;

import com.kh.mvc.board.model.vo.Attachment;
import com.oreilly.servlet.MultipartRequest;

public class MvcUtils {

	
	/**
	 * 비밀번호 암호화 처리 메소드
	 * 
	 * 1. 암호화 처리 (MessageDigest)
	 *  
	 * 2. 암호화된 이진 배열을 문자열로 인코딩 처리 Base64Encoder
	 * 
	 */
	public static String getEncryptedPassword(String password) {
		
		// 1.암호화처리
		byte[] encrypted = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512"); // 암호화 처리 방식 설정?
			byte[] plain = password.getBytes("utf-8"); // 문자열을 바이트코드로 인코딩
			md.update(plain); // md객체에 원본문자열 설정
			encrypted = md.digest(); // 암호화처리
			
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(encrypted); // 읽을 수 없는 문자
		
		// 2.인코딩처리
		// 영문자, 숫자, + / 64개의 문자 사용 (=패딩문자도 사용)
		Encoder encoder = Base64.getEncoder();
		String encryptedPassword = encoder.encodeToString(encrypted); // 문자로 변환
		
		System.out.println(encryptedPassword);
		return encryptedPassword;
	}
	
	/**
	 * @param cPage
	 * @param numPerPage
	 * @param totalContent
	 * @param url
	 * @return
	 * 
	 * totalPage 전체 페이지
	 * pagebarSize 페이지바 크기 5
	 * pageNo
	 * pageStart - pageEnd
	 * 
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder(); 
		url = url + "?cPage="; // pageNo 추가전 상태
		
		final int pagebarSize = 5;
		// totalPage : 총 페이지 수
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		// 현재 페이지의 start 페이지 ex) 7페이지의 start페이지는 6페이지
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		// 현재 페이지의 end 페이지 ex) 7페이지의 end페이지는 10페이지
		int pageEnd = pageStart + pagebarSize - 1;
		// 토탈페이지가 pageEnd보다 작은 경우 pageEnd가 끝이 아니라, 토탈페이지가 끝이 되도록 함
		// ex) 12페이지의 pageEnd는 15이지만 실제로는 12페이지만 있는 경우 pageEnd에 12대입
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;

		// [이전]
		if(pageNo == 1) { // 스타트 페이지가 1인 경우 아무 prev없음
			// cPage = 1, 2, 3, 4, 5
		}
		else {
			pagebar.append("<a href='" + url + (pageNo - 1) + "'>prev</a>\n");
		}
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				//클릭이 되지 않도록 span태그로 처리함
				pagebar.append("<span class='cPage'>" + cPage + "</span>\n");
			}
			else {
				pagebar.append("<a href='" + url + pageNo + "'>" + pageNo + "</a>\n");
			}
			
			pageNo++;
		}
		
		
		// [다음]
		if(pageNo > totalPage) {
			// 사용하는 페이지넘버가 토탈페이지를 넘긴 경우 next메뉴바가 나타나지 않도록 함
			// ex)총 사용 페이지가 12페이지까지만 있는 경우, 위의 while문에서 pageNo++에 의해
			// 13인 상태에서 반복문이 끝나므로 pageNo(13)가 totalPage(12)를 초과하게 됨.
		}
		else {
			pagebar.append("<a href='" + url + pageNo + "'>next</a>\n");
		}
		
		return pagebar.toString();
	}

	public static Attachment makeAttachment(MultipartRequest multipartRequest, String name) {
		Attachment attach = new Attachment();
		String originalFilename = multipartRequest.getOriginalFileName(name);
		String renamedFilename = multipartRequest.getFilesystemName(name);
		attach.setOriginalFilename(originalFilename);
		attach.setRenamedFilename(renamedFilename);
		return attach;
	}

}
