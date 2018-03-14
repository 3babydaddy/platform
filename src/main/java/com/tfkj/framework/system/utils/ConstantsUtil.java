package com.tfkj.framework.system.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.UriUtils;

import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.utils.FileUtils;
import com.tfkj.framework.core.utils.SpringContextHolder;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.Servlets;
import com.tfkj.framework.system.dao.DictDao;
import com.tfkj.framework.system.security.SystemAuthorizingRealm.Principal;

/**
 * @Description: 业务处理公用方法
 * @author gaowei
 * @date 2017年3月7日
 */
public class ConstantsUtil {

	private static DictDao dictDao = SpringContextHolder.getBean(DictDao.class);

	/**
	 * @Title: trim
	 * @Description: 清除空白符
	 * @param @param str
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String trim(String str) {

		return str.replaceAll("\\s*", "");
	}

	/**
	 * @Title: getArraySortByValue
	 * @Description: 获得指定元素在数组的排序
	 * @param @param array
	 * @param @param value
	 * @param @return 参数
	 * @return int 返回类型 如果元素在数组不存在返回-1
	 * @throws
	 */
	public static int getArraySortByValue(Integer[] array, Integer value) {

		Arrays.sort(array);
		for (int i = 0; i < array.length; i++) {
			if (array[i] == value) {
				return i + 1;
			}
		}
		return -1;// 当if条件不成立时，默认返回一个负数值-1
	}

	/**
	 * @Title: compareVersion
	 * @Description: 比较版本号的大小
	 * @param @param exportSysVersion 导出系统版本
	 * @param @param importSysVersion 导入系统版本
	 * @return int 前者大则返回 1,后者大返回 -1,相等则返回 0
	 */
	public static int compareVersion(String exportSysVersion,
			String importSysVersion) {

		// 参数判断
		if (StringUtils.isBlank(exportSysVersion)
				|| StringUtils.isBlank(importSysVersion)) {
			throw new RuntimeException("compareVersion error:illegal params.");
		}
		// 统一转为大写后比较
		String[] versionArray1 = exportSysVersion.toUpperCase().split("\\.");// 注意此处为正则匹配，不能用"."；
		String[] versionArray2 = importSysVersion.toUpperCase().split("\\.");
		int idx = 0;
		int minLength = Math.min(versionArray1.length, versionArray2.length);// 取最小长度值
		int diff = 0;
		while (idx < minLength
				&& (diff = versionArray1[idx].length()
						- versionArray2[idx].length()) == 0// 先比较长度
				&& (diff = versionArray1[idx].compareTo(versionArray2[idx])) == 0) {// 再比较字符
			++idx;
		}
		// 如果已经分出大小，则直接返回，如果未分出大小，则再比较位数，有子版本的为大；
		diff = (diff != 0) ? diff : versionArray1.length - versionArray2.length;
		if (diff > 0) {
			return 1;
		}
		if (diff < 0) {
			return -1;
		}
		return diff;
	}

	/**
	 * @Title: CopyObject
	 * @Description: 类间赋值
	 * @param @param source
	 * @param @param dest
	 * @param @throws Exception 参数
	 * @return void 返回类型
	 * @throws
	 */
	public static void CopyObject(Object source, Object dest) throws Exception {

		// 获取属性
		BeanInfo sourceBean = Introspector.getBeanInfo(source.getClass(),
				Object.class);
		PropertyDescriptor[] sourceProperty = sourceBean
				.getPropertyDescriptors();
		BeanInfo destBean = Introspector.getBeanInfo(dest.getClass(),
				Object.class);
		PropertyDescriptor[] destProperty = destBean.getPropertyDescriptors();
		try {
			for (PropertyDescriptor element : sourceProperty) {
				for (PropertyDescriptor element2 : destProperty) {
					if (element.getName().equals(element2.getName())
							&& element.getPropertyType() == element2
									.getPropertyType()) {
						// 调用source的getter方法和dest的setter方法
						element2.getWriteMethod().invoke(dest,
								element.getReadMethod().invoke(source));
						break;
					}
				}
			}
		} catch (Exception e) {
			throw new Exception("属性复制失败:" + e.getMessage());
		}
	}

	/**
	 * 根据属性名获取属性值
	 */
	public static Object getFieldValueByName(String fieldName, Object o) {

		try {
			String firstLetter = fieldName.substring(0, 1).toUpperCase();
			String getter = "get" + firstLetter + fieldName.substring(1);
			Method method = o.getClass().getMethod(getter, new Class[] {});
			Object value = method.invoke(o, new Object[] {});
			return value;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获取属性名数组
	 */
	public static String[] getFiledName(Object o) {

		Field[] fields = o.getClass().getDeclaredFields();
		String[] fieldNames = new String[fields.length];
		for (int i = 0; i < fields.length; i++) {
			fieldNames[i] = fields[i].getName();
		}
		return fieldNames;
	}

	/**
	 * 获取对象的所有属性值，返回一个Map
	 */
	public static Map<String, Object> getFiledValues(Object o) {

		Map<String, Object> map = new HashMap<String, Object>(16);
		String[] fieldNames = getFiledName(o);
		for (String fieldName : fieldNames) {
			if ("serialVersionUID".equals(fieldName)) {
				continue;
			}
			map.put(fieldName, getFieldValueByName(fieldName, o));
		}
		return map;
	}

	/**
	 * @Title: jsonEscape
	 * @Description: 将json串中的特殊字符转义
	 * @param @param jsonStr
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String jsonEscape(String jsonStr) {

		if (StringUtils.isBlank(jsonStr)) {
			return "";
		}
		jsonStr = jsonStr.replace("&gt;", ">");
		jsonStr = jsonStr.replace("&lt;", "<");
		jsonStr = jsonStr.replace("&nbsp;", " ");
		jsonStr = jsonStr.replace("&quot;", "\"");
		jsonStr = jsonStr.replace("&#39;", "\'");
		jsonStr = jsonStr.replace("\\\\", "\\");// 对斜线的转义
		jsonStr = jsonStr.replace("\\n", "\n");
		jsonStr = jsonStr.replace("\\r", "\r");
		jsonStr = jsonStr.replace("%3B", ";");
		jsonStr = jsonStr.replace("%2C", ",");
		return jsonStr;
	}

	/**
	 * 处理转义字符
	 * 
	 * @param str
	 * @return
	 */
	public static String transform(String str) {

		if (StringUtils.isBlank(str)) {
			return "";
		}
		str = str.replaceAll("&", "");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		// str = str.replaceAll(" ", "&nbsp;");
		str = str.replaceAll("quot;", "\"");
		str = str.replaceAll("ldquo;", "\"");
		str = str.replaceAll("rdquo;", "\"");
		// str = str.replaceAll("\n", "\\n");
		// str = str.replaceAll("\r", "\\r");
		// str = str.replaceAll(";", "%3B");
		// str = str.replaceAll(",", "%2C");
		return str;
	}

	/**
	 * SERVICE层操作是否成功
	 */
	public final static String SERVICE_SUCCESS = "1";// 成功

	public final static String SERVICE_FAIL = "0";// 失败

	/**
	 * @throws ParseException
	 * @Title: getDateFormat
	 * @Description: 格式化浏览器传回时间
	 * @param @param time
	 * @param @return 参数
	 * @return String 返回类型
	 * @throws
	 */
	public static String getDateFormat(String time) throws ParseException {

		String sDate = "";
		if (StringUtils.isBlank(time)) {
			return sDate;
		}
		SimpleDateFormat sdf1 = new SimpleDateFormat(
				"EEE MMM dd HH:mm:ss Z yyyy", Locale.UK);
		Date date = sdf1.parse(time);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sDate = sdf.format(date);
		return sDate;
	}

	/**
	 * @Title: stringToDate
	 * @Description: 字符串转成日期 格式为yyyy-MM-dd
	 * @param @param str
	 * @param @return
	 * @param @throws ParseException 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public static Date stringToDate(String str) throws ParseException {

		if (StringUtils.isBlank(str)) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(str);
		return date;
	}

	/**
	 * 获取两个日期之间的年数
	 * 
	 * @param before
	 * @param after
	 * @return 当传入参数为空时得 -1
	 * @throws ParseException
	 */
	public static int getYearsOfTwoDate(Date before, Date after) {

		if (before == null || after == null) {
			return -1;
		}
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(after);
		int yearNow = cal1.get(Calendar.YEAR);
		int monthNow = cal1.get(Calendar.MONTH) + 1;
		int dayOfMonthNow = cal1.get(Calendar.DAY_OF_MONTH);
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(before);
		int yearBirth = cal2.get(Calendar.YEAR);
		int monthBirth = cal2.get(Calendar.MONTH) + 1;
		int dayOfMonthBirth = cal2.get(Calendar.DAY_OF_MONTH);
		int age = yearNow - yearBirth;
		if (monthNow <= monthBirth) {
			if (monthNow == monthBirth) {
				// monthNow==monthBirth
				if (dayOfMonthNow < dayOfMonthBirth) {
					age--;
				}
			} else {
				// monthNow>monthBirth
				age--;
			}
		}
		return age;
	}

	/**
	 * 得到日期字符串 默认格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
	 */
	public static String dateToString(Date date, Object... pattern) {

		if (date == null) {
			return "";
		}
		String formatDate = "";
		if (pattern != null && pattern.length > 0) {
			formatDate = DateFormatUtils.format(date, pattern[0].toString());
		} else {
			formatDate = DateFormatUtils.format(date, "yyyy-MM-dd");
		}
		return formatDate;
	}

	/**
	 * @throws ParseException
	 * @Title: countMonth
	 * @Description: 计算两个时间相隔月份-讨论决定时间 与 任原职级时间 之间相差的月份
	 * @param @param dateQ 讨论决定时间
	 * @param @param dateH 任原职级时间
	 * @param @return 参数
	 * @return int 返回类型
	 * @throws
	 */
	public static int countMonth(Date dateQ, Date dateH) throws ParseException {

		if (dateQ == null || dateH == null) {
			return 0;
		}
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(dateQ);
		c2.setTime(dateH);
		if (c1.getTimeInMillis() < c2.getTimeInMillis()) {
			return 0;
		}
		int year1 = c1.get(Calendar.YEAR);
		int year2 = c2.get(Calendar.YEAR);
		int month1 = c1.get(Calendar.MONTH);
		int month2 = c2.get(Calendar.MONTH);
		int day1 = c1.get(Calendar.DAY_OF_MONTH);
		int day2 = c2.get(Calendar.DAY_OF_MONTH);
		// 获取年的差值 假设 d1 = 2015-8-16 d2 = 2011-9-30
		int yearInterval = year1 - year2;
		// 如果 d1的 月-日 小于 d2的 月-日 那么 yearInterval-- 这样就得到了相差的年数
		if (month1 < month2 || month1 == month2 && day1 < day2) {
			yearInterval--;
		}
		// 获取月数差值
		int monthInterval = (month1 + 12) - month2;
		if (day1 < day2) {
			monthInterval--;
		}
		monthInterval %= 12;
		return yearInterval * 12 + monthInterval;
	}

	/**
	 * 复制文件
	 * 
	 * @param fileType
	 * @param inputFile
	 * @param id
	 *            数据ID
	 * @param model
	 *            所属模块
	 * @return
	 */
	@Transactional(readOnly = false)
	public static String copyFile(String fileType, String inputFile, String id,
			String model) {

		// Principal principal = UserUtils.getPrincipal();
		if (!UserUtils.getSubject().isAuthenticated()) {
			return "";
		}
		String copyRealFile = null;
		if ("image".equals(fileType)) {
			copyRealFile = Global.getUserfilesBaseDir()
					+ Global.USERFILES_BASE_COPY_URL + "/" + fileType;
		} else if ("file".equals(fileType)) {
			copyRealFile = Global.getUserfilesBaseDir()
					+ Global.USERFILES_BASE_COPY_URL + "/" + fileType;
		} else {
			copyRealFile = Global.getUserfilesBaseDir()
					+ Global.USERFILES_BASE_COPY_URL + "/" + "other";
		}
		File file = new File(FileUtils.path(copyRealFile));
		try {
			inputFile = UriUtils.decode(FileUtils.path(inputFile), "UTF-8");
			// 取消路径前后“/”
			String flagBack = inputFile.substring(inputFile.length() - 1,
					inputFile.length());
			String flagFont = "";
			int indexOf = inputFile.indexOf(Servlets.getRequest()
					.getContextPath());
			if (indexOf >= 0) {
				flagFont = inputFile.substring(0, inputFile.indexOf(Servlets
						.getRequest().getContextPath()));
			}
			while ("/".equals(flagBack)) {
				inputFile = inputFile.substring(0, inputFile.length() - 1);
				flagBack = inputFile.substring(inputFile.length() - 1,
						inputFile.length());
			}
			inputFile = inputFile.substring(flagFont.length(),
					inputFile.length());
			String font = inputFile.substring(0, 1);
			while ("/".equals(font)) {
				inputFile = inputFile.substring(1, inputFile.length());
				font = inputFile.substring(0, 1);
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String outFile = "";
		int lastIndexOf = inputFile.lastIndexOf("/");
		int indexOf = inputFile.indexOf("/");
		if (lastIndexOf > 0 && indexOf > 0) {
			outFile = copyRealFile
					+ "/"
					+ model
					+ "/"
					+ id
					+ "/"
					+ inputFile.substring(inputFile.lastIndexOf("/"),
							inputFile.length());
			inputFile = Global.getUserfilesBaseDir()
					+ inputFile.substring(inputFile.indexOf("/"),
							inputFile.length());
		}
		if (file.exists()) {
			String filepath = null;
			try {
				filepath = UriUtils.decode(FileUtils.path(inputFile), "UTF-8");
				Boolean flag = FileUtils.copyFileCover(filepath,
						FileUtils.path(outFile), true);
				if (flag) {
					return Servlets.getRequest().getContextPath()
							+ outFile.substring(outFile
									.indexOf(Global.USERFILES_BASE_COPY_URL),
									outFile.length());
				} else {
					return SERVICE_FAIL;
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return SERVICE_FAIL;
			}
		} else {
			Boolean flag = FileUtils.createDirectory(FileUtils
					.path(copyRealFile));
			if (flag) {
				String filepath = null;
				try {
					filepath = UriUtils.decode(FileUtils.path(inputFile),
							"UTF-8");
					Boolean cflag = FileUtils.copyFileCover(filepath,
							FileUtils.path(outFile), true);
					if (cflag) {
						return Servlets.getRequest().getContextPath()
								+ outFile
										.substring(
												outFile.indexOf(Global.USERFILES_BASE_COPY_URL),
												outFile.length());
					} else {
						return SERVICE_FAIL;
					}
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					return SERVICE_FAIL;
				}
			} else {
				return SERVICE_FAIL;
			}
		}
	}
}
