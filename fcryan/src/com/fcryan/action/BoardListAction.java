package com.fcryan.action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcryan.dao.BoardDAO;
import com.fcryan.dto.BoardDTO;
import com.fcryan.dto.CriteriaDTO;
import com.fcryan.dto.PageMakerDTO;

public class BoardListAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String url = "board/boardlist.jsp";
		
		CriteriaDTO criDto = new CriteriaDTO();
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
//		System.out.println("페이지번호: " + page);
		criDto.setPage(page);
		
		String flag = null;
		String keyword = null;
		if(request.getParameter("keyword") != null) {
			flag = request.getParameter("flag");
			keyword = request.getParameter("keyword");
			criDto.setFlag(flag);
			criDto.setKeyword(keyword);
			System.out.println(page + ", " + flag + ", " + keyword);
			request.setAttribute("flag", flag);
			request.setAttribute("keyword", keyword);
		}
		
		
		
		BoardDAO bDao = BoardDAO.getInstance();
		// 게시글 목록(정보들) 출력
		List<BoardDTO> boardList = bDao.boardListAll(criDto);
		request.setAttribute("boardList", boardList);
		
		// 현재날짜 출력
		Date today = new Date();
		request.setAttribute("today", today);	
		
		
		
		PageMakerDTO pageMaker = new PageMakerDTO();
		pageMaker.setCriDto(criDto);
		int totalCount = bDao.totalCount(criDto);
		pageMaker.setTotalCount(totalCount);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("pageMaker", pageMaker);
		
		
//		System.out.println("================================");
//		System.out.println(pageMaker.toString());
		
		ActionForward forward = new ActionForward();
		forward.setPath(url);
		forward.setRedirect(false);
		
		return forward;
	}

}






