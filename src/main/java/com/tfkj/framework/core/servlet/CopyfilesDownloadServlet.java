package com.tfkj.framework.core.servlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.UriUtils;

import com.tfkj.framework.core.config.Global;

/**
 * 查看CK上传的图片
 * @author ThinkGem
 * @version 2014-06-25
 */
public class CopyfilesDownloadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());

	public void fileOutputStream(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		String filepath = req.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_COPY_URL);
		if(index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_COPY_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_COPY_URL + filepath);
		try {
			String filename=java.net.URLEncoder.encode(filepath.substring(filepath.lastIndexOf("/")+1,filepath.length()), "UTF-8");
			filename=filename.replaceAll("\\+", "%20");
			resp.setHeader("Content-Disposition", "attachment; filename=" + filename);  
			resp.setContentType("application/octet-stream; charset=utf-8");  
	        FileInputStream fis = new FileInputStream(file);  
	        @SuppressWarnings("resource")
			BufferedInputStream bis = new BufferedInputStream(fis);  
	        byte[] bytes = new byte[bis.available()];  
	        OutputStream os = resp.getOutputStream();  
	        bis.read(bytes);  
	        os.write(bytes); 
			return;
		} catch (FileNotFoundException e) {
			req.setAttribute("exception", new FileNotFoundException("请求的文件不存在"));
			req.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStream(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStream(req, resp);
	}
}
