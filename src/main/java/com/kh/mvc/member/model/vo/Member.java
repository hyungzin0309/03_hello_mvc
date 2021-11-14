package com.kh.mvc.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/*
 * VO클래스
 * -Serializable인터페이스 구현(세션관리시 객체단위로 입출력 가능해야 한다.)
 */
public class Member implements Serializable, HttpSessionBindingListener, Cloneable {
	private static final long serialVersionUID=1L;
	
	private String memberid;
	private String password;
	private String memberName;
	private String memberRole;
	private String gender;
	private Date birthday;
	private String email;
	private String phone;
	private String address;
	private String hobby;
	private Date enrollDate;
	
	public Member() {
		super();
	}

	public Member(String memberid, String password, String memberName, String memberRole, String gender, Date birthday,
			String email, String phone, String address, String hobby, Date enrollDate) {
		super();
		this.memberid = memberid;
		this.password = password;
		this.memberName = memberName;
		this.memberRole = memberRole;
		this.gender = gender;
		this.birthday = birthday;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
		this.enrollDate = enrollDate;
	}
	public Member(String memberid, String password, String memberName, String gender, Date birthday,
			String email, String phone, String address, String hobby) {
		super();
		this.memberid = memberid;
		this.password = password;
		this.memberName = memberName;
		this.gender = gender;
		this.birthday = birthday;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString() {
		return "Member [memberid=" + memberid + ", password=" + password + ", memberName=" + memberName
				+ ", memberRole=" + memberRole + ", gender=" + gender + ", birthday=" + birthday + ", email=" + email
				+ ", phone=" + phone + ", address=" + address + ", hobby=" + hobby + ", enrollDate=" + enrollDate + "]";
	}

	
	/*
	 *  Member객체가 session.setAttribute 된 경우
	 */
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		System.out.println("valueBound : " + memberName + "님이 로그인했습니다.");
	}

	/*
	 *  Member객체가 session.removeAttribute 된 경우
	 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		System.out.println("valueBound : " + ((Member)event.getValue()).getMemberName() + "님이 로그아웃했습니다.");
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
	
	
	
	
}
