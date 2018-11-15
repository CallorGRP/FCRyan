package com.fcryan.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcryan.dao.ReplyDAO;

public class ReplyDeleteAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String rno = request.getParameter("rno");
//		System.out.println(rno);
		
		ReplyDAO rDao = ReplyDAO.getInstance();
		rDao.replyDelete(rno);
		
		return null;
	}

}
