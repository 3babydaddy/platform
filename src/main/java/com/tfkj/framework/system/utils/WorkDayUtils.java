package com.tfkj.framework.system.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.tfkj.framework.core.utils.SpringContextHolder;
import com.tfkj.framework.system.dao.HolidayDao;
import com.tfkj.framework.system.entity.Holiday;

public class WorkDayUtils {

	private static HolidayDao holidayDao = SpringContextHolder.getBean(HolidayDao.class);

	/**
	 * 获取两个日期间工作日天数 加入了法定节假日和调休
	 *
	 * @param beginDay
	 * @param endDay
	 * @return -1表示endDay比beginDay小； 100表示无穷大，避免不必要的循环
	 */
	public static int getWorkingDay(Date beginDay, Date endDay) {

		if (beginDay == null || endDay == null) {
			return -1;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar1 = Calendar.getInstance();
		Calendar calendar2 = Calendar.getInstance();
		calendar1.setTimeInMillis(beginDay.getTime());
		calendar2.setTimeInMillis(endDay.getTime());
		int gzr = -1;
		if (calendar1.before(calendar2)) {
			gzr = 0;
			while (calendar1.compareTo(calendar2) <= 0) {
				if (calendar1.get(Calendar.DAY_OF_WEEK) == 1 || calendar1.get(Calendar.DAY_OF_WEEK) == 7) {
					// 调休
					List<Holiday> list = holidayDao.isExchangeDayList(sdf.format(calendar1.getTime()));
					if (list.size() > 0) {
						gzr++;
					}
				} else {
					// 节假日
					List<Holiday> list = holidayDao.isHolidayList(sdf.format(calendar1.getTime()));
					if (list.size() == 0) {
						gzr++;
					}
				}
				if (gzr >= 100) {
					gzr = 100;
					break;
				}
				calendar1.add(Calendar.DAY_OF_MONTH, 1);
			}
		}
		return gzr;
	}
	// public static boolean isWorkDay(Date date) {
	//
	// if (date == null) {
	// return false;
	// }
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// Calendar calendar = Calendar.getInstance();
	// calendar.setTimeInMillis(date.getTime());
	// if (calendar.get(Calendar.DAY_OF_WEEK) == 1 || calendar.get(Calendar.DAY_OF_WEEK) == 7) {
	// return false;
	// }
	// // 调休
	// List<Holiday> exchangeDayList = holidayDao.isExchangeDayList(sdf.format(calendar.getTime()));
	// boolean exchangeDayListContains = Arrays.asList(exchangeDayList).contains(date);
	// if (exchangeDayListContains) {
	// return false;
	// }
	// // 节假日
	// List<Holiday> holidayList = holidayDao.isHolidayList(sdf.format(calendar.getTime()));
	// boolean holidayListContains = Arrays.asList(holidayList).contains(date);
	// if (holidayListContains) {
	// return false;
	// }
	// return true;
	// }
}
