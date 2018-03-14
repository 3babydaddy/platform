package com.tfkj.framework.system.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ckfinder.connector.ServletContextFactory;
import com.tfkj.business.web.constants.Constants;
import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.utils.Encodes;
import com.tfkj.framework.core.utils.FileUtils;
import com.tfkj.framework.core.utils.FreeMarkers;
import com.tfkj.framework.core.utils.StringUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

/**
 * @Description: freemarker模版相关方法
 * @author gaowei
 * @date 2017年4月5日
 */
public class WordTemplateUtil {

	/**
	 * @Title: CreateWord
	 * @Description: 生成word模板并下载
	 * @param @param dir 模版路径
	 * @param @param fileName 文件名称
	 * @param @param request
	 * @param @param response
	 * @param @param templateName 模版名称
	 * @param @param dataMap 数据绑定
	 * @param @throws Exception 参数
	 * @return void 返回类型
	 * @throws
	 */
	public static void CreateWord(String dir, String fileName, String templateName, HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap) throws Exception {

		File outFile = new File(fileName);
		Template template = null;
		Writer writer = null;
		Configuration configuration = FreeMarkers.buildConfiguration(dir);
		// configuration.setCacheStorage(new freemarker.cache.MruCacheStorage(20, 250));
		// configuration.setCacheStorage(new freemarker.cache.NullCacheStorage());
		configuration.setDefaultEncoding("UTF-8");
		// 设置异常处理
		configuration.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
		// 要装载的模板
		template = configuration.getTemplate(templateName);
		String renderTemplate = FreeMarkers.renderTemplate(template, dataMap);
		InputStream fin = null;
		ServletOutputStream out = null;
		try {
			writer = new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8");
			outFile.setReadOnly();
			outFile.setWritable(false);
			writer.write(renderTemplate);
			writer.flush();
			// 调用工具类WordGenerator的createDoc方法生成Word文档
			fin = new FileInputStream(outFile);
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + Encodes.urlEncode(fileName));
			out = response.getOutputStream();
			byte[] buffer = new byte[512]; // 缓冲区
			int bytesToRead = -1;
			// 通过循环将读入的Word文件的内容输出到浏览器中
			while ((bytesToRead = fin.read(buffer)) != -1) {
				out.write(buffer, 0, bytesToRead);
			}
		} finally {
			if (writer != null) {
				writer.close();
			}
			if (fin != null) {
				fin.close();
			}
			if (out != null) {
				out.close();
			}
			if (outFile != null) {
				outFile.delete(); // 删除临时文件
			}
		}
	}

	/**
	 * @Title: getTemplatePath
	 * @Description: 获得模版在项目下的路径
	 * @param @return
	 * @param @throws Throwable 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getTemplatePath() throws Throwable {

		String dir = "file:" + ServletContextFactory.getServletContext().getRealPath(File.separator);
		if (!dir.endsWith(File.separator)) {
			dir += File.separator;
		}
		dir += Constants.FREEMARKER_PATH;
		if (!dir.endsWith(File.separator)) {
			dir += File.separator;
		}
		return dir;
	}

	/**
	 * @Title: getPhotoPath
	 * @Description: 将数据库中的存储路径转化为绝对路径
	 * @param @param photo
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getPhotoPath(String photo) {

		if (StringUtils.isBlank(photo)) {
			return "";
		}
		try {
			// 上传文件基础虚拟路径
			String userfilesBaseUrl = Global.USERFILES_BASE_COPY_URL;
			String baseDir = photo.split(userfilesBaseUrl)[1];
			// 获取上传文件系统配置的根目录
			String userfilesBaseDir = Global.getUserfilesBaseDir();
			// 照片存储绝对路径
			String photoPath = userfilesBaseDir + userfilesBaseUrl + baseDir;
			photoPath = Encodes.urlDecode(FileUtils.path(photoPath));
			return photoPath;
		} catch ( Exception e ) {
			return "";
		}
	}

	/**
	 * @Title: getImageStr
	 * @Description: 获得图片base64码
	 * @param @param imgFile 图片绝对路径 ef:String imgFile = "d:/test.jpg";
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getImageStr(String imgFile) {

		if (StringUtils.isBlank(imgFile)) {
			return "";
		}
		File srcFile = new File(imgFile);
		// 判断源文件是否存在
		if (!srcFile.exists()) {
			return "";
		}
		// 判断源文件是否是合法的文件
		else if (!srcFile.isFile()) {
			return "";
		}
		InputStream in = null;
		byte[] data = null;
		try {
			in = new FileInputStream(imgFile);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch ( IOException e ) {
			return "";
		}
		String encodeBase64 = Encodes.encodeBase64(data);
		return encodeBase64;
	}
}
