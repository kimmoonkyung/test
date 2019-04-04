package com.mkcompany.dto;

/**
 * @author mk
 *
 */
public class MemberVo {

	private int memNo; // 사원번호
	private String kor_Name; // 한글이름
	private String eng_Name; // 영문이름
	private String chn_Name; // 한문이름
	private String jumin_noF; // 주민앞
	private String jumin_noB; // 주민뒷자리
	private String image; // 사진
	private String birth1; // 출생년도
	private String birth2; // 출생 월
	private String birth3; // 출생 일
	private String sol_flag; // 양력/음력
	private String sex; // 성별
	private String marry_flag; // 기혼 / 미혼
	private String work_year; // 년차
	private String payment_type; // 급여지급유형 (월급 / 주급)
	private String desire_dept; // 희망직무 (SI / SM)
	private String job_type; // 입사유형 (정규직 / 계약직)
	private String address; // 주소
	private String phone1; // 연락처앞
	private String phone2; // 연락처중간
	private String phone3; // 연락처뒤
	private String email; // 이메일
	private String tech_lev; // 기술등급 (초 / 중 / 고급)
	private String liquor; // 주량

	public MemberVo() {}

	public MemberVo(int memNo, String kor_Name, String eng_Name, String chn_Name, String jumin_noF, String jumin_noB,
			String image, String birth1, String birth2, String birth3, String sol_flag, String sex, String marry_flag,
			String work_year, String payment_type, String desire_dept, String job_type, String address, String phone1,
			String phone2, String phone3, String email, String tech_lev, String liquor) {
		super();
		this.memNo = memNo;
		this.kor_Name = kor_Name;
		this.eng_Name = eng_Name;
		this.chn_Name = chn_Name;
		this.jumin_noF = jumin_noF;
		this.jumin_noB = jumin_noB;
		this.image = image;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.birth3 = birth3;
		this.sol_flag = sol_flag;
		this.sex = sex;
		this.marry_flag = marry_flag;
		this.work_year = work_year;
		this.payment_type = payment_type;
		this.desire_dept = desire_dept;
		this.job_type = job_type;
		this.address = address;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.email = email;
		this.tech_lev = tech_lev;
		this.liquor = liquor;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public String getKor_Name() {
		return kor_Name;
	}

	public void setKor_Name(String kor_Name) {
		this.kor_Name = kor_Name;
	}

	public String getEng_Name() {
		return eng_Name;
	}

	public void setEng_Name(String eng_Name) {
		this.eng_Name = eng_Name;
	}

	public String getChn_Name() {
		return chn_Name;
	}

	public void setChn_Name(String chn_Name) {
		this.chn_Name = chn_Name;
	}

	public String getJumin_noF() {
		return jumin_noF;
	}

	public void setJumin_noF(String jumin_noF) {
		this.jumin_noF = jumin_noF;
	}

	public String getJumin_noB() {
		return jumin_noB;
	}

	public void setJumin_noB(String jumin_noB) {
		this.jumin_noB = jumin_noB;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getBirth1() {
		return birth1;
	}

	public void setBirth1(String birth1) {
		this.birth1 = birth1;
	}

	public String getBirth2() {
		return birth2;
	}

	public void setBirth2(String birth2) {
		this.birth2 = birth2;
	}

	public String getBirth3() {
		return birth3;
	}

	public void setBirth3(String birth3) {
		this.birth3 = birth3;
	}

	public String getSol_flag() {
		return sol_flag;
	}

	public void setSol_flag(String sol_flag) {
		this.sol_flag = sol_flag;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getMarry_flag() {
		return marry_flag;
	}

	public void setMarry_flag(String marry_flag) {
		this.marry_flag = marry_flag;
	}

	public String getWork_year() {
		return work_year;
	}

	public void setWork_year(String work_year) {
		this.work_year = work_year;
	}

	public String getPayment_type() {
		return payment_type;
	}

	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}

	public String getDesire_dept() {
		return desire_dept;
	}

	public void setDesire_dept(String desire_dept) {
		this.desire_dept = desire_dept;
	}

	public String getJob_type() {
		return job_type;
	}

	public void setJob_type(String job_type) {
		this.job_type = job_type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTech_lev() {
		return tech_lev;
	}

	public void setTech_lev(String tech_lev) {
		this.tech_lev = tech_lev;
	}

	public String getLiquor() {
		return liquor;
	}

	public void setLiquor(String liquor) {
		this.liquor = liquor;
	}

	@Override
	public String toString() {
		return "MemberVo [memNo=" + memNo + ", kor_Name=" + kor_Name + ", eng_Name=" + eng_Name + ", chn_Name="
				+ chn_Name + ", jumin_noF=" + jumin_noF + ", jumin_noB=" + jumin_noB + ", image=" + image + ", birth1="
				+ birth1 + ", birth2=" + birth2 + ", birth3=" + birth3 + ", sol_flag=" + sol_flag + ", sex=" + sex
				+ ", marry_flag=" + marry_flag + ", work_year=" + work_year + ", payment_type=" + payment_type
				+ ", desire_dept=" + desire_dept + ", job_type=" + job_type + ", address=" + address + ", phone1="
				+ phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + ", email=" + email + ", tech_lev=" + tech_lev
				+ ", liquor=" + liquor + "]";
	}

}
