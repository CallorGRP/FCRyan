package com.fcryan.action;

import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcryan.common.Constants;

public class BoardDownloadAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "";
		
		String filename = request.getParameter("file");
		System.out.println("파일이름: " + filename);
		
		String path = Constants.UPLOAD_PATH + filename;
		byte b[] = new byte[4096];
		
		FileInputStream fis = new FileInputStream(path);
		
		String mimeType = request.getServletContext().getMimeType(path);
		if(mimeType == null) {
			mimeType = "application/octet-stream; charset=utf-8";
		}
		
		filename = new String(filename.getBytes("utf-8"), "8859_1");
		
		response.setHeader("content-Disposition", "attachment);filename=" + filename);
		
		ServletOutputStream out = response.getOutputStream();
		
		int numRead;
		while(true) {
			numRead = fis.read(b, 0, b.length);
			if(numRead == -1) break;
			out.write(b, 0, numRead);
		}
		
		out.flush();
		out.close();
		fis.close();
		return null;
		
	}

}
