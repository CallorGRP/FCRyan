package com.fcryan.action;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.collections.SynchronizedStack;

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

		String sBno = multi.getParameter("bno");
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String writer = multi.getParameter("writer");
		String filename = " "; // (공백)
		int filesize = 0;
		String nowFileName = multi.getParameter("now-file-name");
		String nowFileSize = multi.getParameter("now-file-size");
		
		
		// 과거 filename과 filesize 불러오기		
		BoardDAO bDao = BoardDAO.getInstance();
		BoardDTO bDto = bDao.boardDetailView(sBno);
		String pfilename = bDto.getFilename();
		String pfilesize = String.valueOf(bDto.getFilesize());
		System.out.println("과거 첨부파일: " + pfilename + ", " + pfilesize);
		System.out.println("현재 첨부파일: " + nowFileName + ", " + nowFileSize);
		
		int flag = 0;
		if(nowFileName.equals(pfilename) && (nowFileSize.equals(pfilesize) || nowFileSize.equals(""))) {
			// 파일이름이 같으면서, 
			// 사이즈가 같거나,
			// 또는 사이즈가 0이면
			// 파일 지우지 않음, filename과 filesize도 수정 하면 안됨
			flag = 1;
		} else {
			File file = new File(Constants.UPLOAD_PATH + pfilename);
			file.delete();
		}	
		
		try {
			Enumeration files = multi.getFileNames();
			
			while(files.hasMoreElements()) {
				String file1 = (String)files.nextElement();
				filename = multi.getFilesystemName(file1); // 첨부파일의 파일이름
				System.out.println("파일이름 왜 안바뀜: " + filename);
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
		if(flag == 1) {
			filename = "no";
		}
		
		int bno = Integer.parseInt(sBno);
		bDto = new BoardDTO(bno, title, content, writer, filename, filesize);
		bDao.boardUpdate(bDto);  
		
		ActionForward forward = new ActionForward();
		forward.setPath(url);
		forward.setRedirect(true);
		
		return forward;
	}

}
