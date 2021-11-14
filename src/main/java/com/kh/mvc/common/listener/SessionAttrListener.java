package com.kh.mvc.common.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import com.kh.mvc.member.model.vo.Member;

/**
 * Application Lifecycle Listener implementation class SessionAttrListener
 *
 */
@WebListener // web.xml에 따로 등록 안해줘도 됨
public class SessionAttrListener implements HttpSessionAttributeListener {
	
    /**
     * Default constructor. 
     */
    public SessionAttrListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionAttributeListener#attributeAdded(HttpSessionBindingEvent)
     */
    public void attributeAdded(HttpSessionBindingEvent se)  { 
//    	HttpSession session = se.getSession();
//    	Member loginMember = (Member) session.getAttribute("loginMember");
    	String name = se.getName();
    	Object value = se.getValue();
    	System.out.println("attributeAdded : "+name+" = "+value);
    	if(value instanceof Member) {
    		Member loginMember = (Member) value;
    		System.out.println(loginMember.getMemberName() + "님이 로그인하셨습니다.");
    	}
    }

	/**
     * @see HttpSessionAttributeListener#attributeRemoved(HttpSessionBindingEvent)
     */
    public void attributeRemoved(HttpSessionBindingEvent se)  { 
    	String name = se.getName();
    	Object value = se.getValue();
    	System.out.println("attributeRemoved : "+name+" = "+value);
    }

	/**
     * @see HttpSessionAttributeListener#attributeReplaced(HttpSessionBindingEvent)
     */
    public void attributeReplaced(HttpSessionBindingEvent se)  { 
         // TODO Auto-generated method stub
    }
	
}
