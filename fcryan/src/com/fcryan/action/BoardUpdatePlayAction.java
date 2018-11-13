package com.fcryan.action;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcryan.common.Constants;
import com.fcryan.dao.BoardDAO;
import com.fcryan.dto.BoardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardUpdatePlayAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "boardList.bizpoll";

		// 파일 업로드 처리
		File uploadDir = new File(Constants.UPLOAD_PATH);
		
		if(!uploadDir.exists()) {  
			uploadDir.mkdir();    
		}
		
		MultipartRequest multi = new MultipartRequest(request,               // request
				                                      Constants.UPLOAD_PATH, // 파일업로드 디렉토리
				                                      Constants.MAX_UPLOAD,  // 업로도 최대 용량
				                                      "UTF-8",               // 인코딩
				                                      new DefaultFileRenamePolicy()); // 파일이름중복정책

		int bno = Integer.parseInt(multi.getParameter("bno"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String writer = multi.getParameter("writer");
		String filename = " "; // (공백)
		int filesize = 0;
		String postfile = multi.getParameter("post-file-name");
//		System.out.println(bno + ", " + title + ", " + content + ", " + writer + ", " + postfile);
		
		// 파일먼저 삭제하고
		File file = new File(Constants.UPLOAD_PATH + postfile);
		file.delete();
		
		try {
			Enumeration files = multi.getFileNames();
			
			while(files.hasMoreElements()) {
				String file1 = (String)files.nextElement();
				filename = multi.getFilesystemName(file1); // 첨부파일의 파일이름
				File f1 = multi.getFile(file1);            // 첨부파일의 파일
				
				if(f1 != null) {
					filesize = (int)f1.length(); // 첨부파일의 파일 사이즈 저장
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(filename == null || filename.trim().equals("")) {
			filename = "-";
		}
//		System.out.println("현재 filename: "  + filename);
		
		
		BoardDAO bDao = BoardDAO.getInstance();
		BoardDTO bDto = new BoardDTO(bno, title, content, writer, filename, filesize);
		int result = bDao.boardUpdate(bDto);  
		
		ActionForward forward = new ActionForward();
		forward.setPath(url);
		forward.setRedirect(true);
		
		return forward;
	}

}
