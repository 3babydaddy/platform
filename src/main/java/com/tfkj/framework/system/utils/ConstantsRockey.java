package com.tfkj.framework.system.utils;

public final class ConstantsRockey {

	public static final int ROCKEY_NO_ERROR = 1000;

	// 没有加密锁
	public static final int ROCKEY_ERROR_NOKEY = 1001;

	// 打开锁失败
	public static final int ROCKEY_ERROR_OPEN = 1002;

	// 用户内存读取失败
	public static final int ROCKEY_ERROR_BUFFERREAD = 1003;

	// 种子码返回失败
	public static final int ROCKEY_ERROR_SEED = 1004;

	// 用户ID读取失败
	public static final int ROCKEY_ERROR_USERIDREAD = 1005;

	// 检查模块失败
	public static final int ROCKEY_ERROR_CHECKMODULE = 1006;

	// 生成随机数失败
	public static final int ROCKEY_ERROR_RANDOM = 1007;

	// 计算方式1失败
	public static final int ROCKEY_ERROR_CACULATE1 = 1008;

	// 计算方式2失败
	public static final int ROCKEY_ERROR_CACULATE2 = 1009;

	// 计算方式3失败
	public static final int ROCKEY_ERROR_CACULATE3 = 1010;

	// 关闭锁失败
	public static final int ROCKEY_ERROR_CLOSE = 1011;

	// 服务器单位不符
	public static final int ROCKEY_ERROR_DANWEI = 2001;

	// 模块无效
	public static final int ROCKEY_ERROR_MODULE0 = 2002;

	// 计算方式1结果错误
	public static final int ROCKEY_ERROR_CACULATE1CHECK = 2003;

	// 计算方式2结果错误
	public static final int ROCKEY_ERROR_CACULATE2CHECK = 2004;
}
