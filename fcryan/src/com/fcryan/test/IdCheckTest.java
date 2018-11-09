package com.fcryan.test;

import org.junit.Test;

import com.fcryan.dao.MemberDAO;

public class IdCheckTest {
	String userid = "sentilemon02";
	
	@Test
	public void testConfirmID() {
		MemberDAO mDao = MemberDAO.getInstance();
		
		mDao.confirmID(userid);
		
	}
}





