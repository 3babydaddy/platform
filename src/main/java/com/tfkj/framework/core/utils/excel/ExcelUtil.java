package com.tfkj.framework.core.utils.excel;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.ckfinder.connector.ServletContextFactory;
import com.tfkj.business.web.constants.Constants;

import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import net.sf.jxls.transformer.XLSTransformer;

public class ExcelUtil {

	/**
	 * @Title: getTemplatePath
	 * @Description: 获得模版在项目下的路径
	 * @param @return
	 * @param @throws Throwable 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getTemplatePath(String templateName) throws Throwable {

		String dir = ServletContextFactory.getServletContext().getRealPath(File.separator);
		if (!dir.endsWith(File.separator)) {
			dir += File.separator;
		}
		dir += Constants.FREEMARKER_PATH_Excel + File.separator + templateName;
		if (!dir.endsWith(File.separator)) {
			dir += File.separator;
		}
		return dir;
	}

	/**
	 * 根据模板生成Excel文件.
	 *
	 * @param templateFileName
	 *            模板文件.
	 * @param list
	 *            模板中存放的数据.
	 * @param resultFileName
	 *            生成的文件.
	 */
	public static void createExcel(String templateFileName, Map<String, Object> beanParams, String resultFileName) throws Exception {

		// 创建XLSTransformer对象
		XLSTransformer transformer = new XLSTransformer();
		// 生成Excel文件
		transformer.transformXLS(templateFileName, beanParams, resultFileName);
	}

	// 把集合插入到excel
	/**
	 * @param string
	 *            规定列数序
	 * @param list
	 *            数据集合
	 * @param RowStart
	 *            起始行
	 * @param RowEnd
	 *            结束行
	 * @param colStart
	 *            起始列
	 */
	public static void List2Excel(String path, String[] string, List<Map> list, int RowStart, int colStart, String defaultstr) {

		try {
			jxl.Workbook wb = null; // 创建一个workbook对象
			try {
				InputStream is = new FileInputStream(path); // 创建一个文件流，读入Excel文件
				wb = Workbook.getWorkbook(is); // 将文件流写入到workbook对象
			} catch ( BiffException e ) {
				
				e.printStackTrace();
			} catch ( IOException e ) {
				
				e.printStackTrace();
			}
			// jxl.Workbook 对象是只读的，所以如果要修改Excel，需要创建一个可读的副本，副本指向原Excel文件（即下面的new
			// File(excelpath)）
			WritableWorkbook wbe = Workbook.createWorkbook(new File(path), wb);// 创建workbook的副本
			WritableSheet sheet = wbe.getSheet(0); // 获取第一个sheet
			for (int i = colStart; i < colStart + string.length; i++) {
				for (int j = RowStart; j < RowStart + list.size(); j++) {
					Map map = list.get(j - RowStart);
					sheet.getWritableCell(i, j);
					// CellFormat cf = cell.getCellFormat();//获取第一个单元格的格式
					String value = map.get(string[i - colStart]) != null ? map.get(string[i - colStart]).toString() : null;
					if (value == null) {
						value = defaultstr;
					}
					Label lbl = new Label(i, j, value);// 将第一个单元格的值改为“修改後的值”
					// lbl.setCellFormat(cf);//将修改后的单元格的格式设定成跟原来一样
					sheet.addCell(lbl);// 将改过的单元格保存到sheet
				}
			}
			wbe.write();// 将修改保存到workbook --》一定要保存
			wbe.close();// 关闭workbook，释放内存 ---》一定要释放内存
		} catch ( IOException e ) {
			
			e.printStackTrace();
		} catch ( WriteException e ) {
			
			e.printStackTrace();
		}
	}

	/**
	 * 生成多sheet页excel
	 *
	 * @param path
	 * @param templateFileName
	 * @param resultFileName
	 * @param sheetValue
	 * @param sheetName
	 * @throws Exception
	 */
	public static void createExcelMoreSheet(String templateFileName, String resultFileName, List objects, List<String> sheetName) throws Exception {

		InputStream is = new BufferedInputStream(new FileInputStream(templateFileName));
		XLSTransformer transformer = new XLSTransformer();
		HSSFWorkbook resultWorkBook = (HSSFWorkbook) transformer.transformMultipleSheetsList(is, objects, sheetName, "", new HashMap(16), 0);
		OutputStream os = new BufferedOutputStream(new FileOutputStream(resultFileName));
		resultWorkBook.write(os);
	}
}
