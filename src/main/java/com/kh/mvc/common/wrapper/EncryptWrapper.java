package com.kh.mvc.common.wrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.kh.mvc.common.filter.MvcUtils;

/**
 * HttpServletRequest 인터페이스
 * HttpServletRequestWrapper 자식클래스
 * ExcryptWrapper
 *
 */
public class EncryptWrapper extends HttpServletRequestWrapper{

	/**
	 * HttpServletRequestWrapper에 기본생성자가 존재하지 않으므로
	 * 명시적으로 파라미터생성자 호출해야 한다.
	 */
	public EncryptWrapper(HttpServletRequest request) {
		super(request); //최상위 부모 ServletRequestWrapper의 필드 ServletRequest객체 request변수에 request대입
	}

	@Override
	// 자식클래스인 wrapper의 getParameter를 호출하게 됨
	public String getParameter(String name) {
		switch(name) {
		case "newPassword":
		case "oldPassword":
		case "password":
			return MvcUtils.getEncryptedPassword(super.getParameter(name));
		default : 
			return super.getParameter(name);
		}
		
	}
	
	
	

}
