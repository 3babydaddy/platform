package com.tfkj.framework.system.utils;

import epas1kndjni.CHash;
import epas1kndjni.IHash;

public class LoginModelUtil {

	// 公钥
	private String publicKey = "ePass_StaffEmpSupSys_091203";

	// 随机数
	private String randomString = null;

	// 客户端返回的密文
	private String ciphertext = null;

	// 权限检查的错误标识
	private int checkErrorFlag = LoginKeyConstants.LOGIN_NO_ERR;

	// 设定公钥
	public void setPublicKey(String publicKey) {

		this.publicKey = publicKey;
	}

	// 设定随机数，将从前台返回的随机数保留下来
	public void setRandomString(String randStr) {

		this.randomString = randStr;
	}

	// 设置客户端（页面）返回的密文
	public void setCiphertext(String pCiphertext) {

		this.ciphertext = pCiphertext;
	}

	// 取得权限检查的错误标识
	public int getCheckErrorFlag() {

		return (this.checkErrorFlag);
	}

	public boolean CheckAuthorityWithEPass() {

		try {
			String serverCiphertext = this.HashCiphertext();
			String clientCiphertext = this.ciphertext;
			// System.out.println(serverCiphertext);
			// System.out.println(clientCiphertext);
			if (serverCiphertext.equals(clientCiphertext)) {
				checkErrorFlag = LoginKeyConstants.LOGIN_NO_ERR;
				return true;
			} else {
				checkErrorFlag = LoginKeyConstants.LOGIN_ERR_WRONG_EPASS_KEY;
				return false;
			}
		} catch ( Exception e ) {
			checkErrorFlag = LoginKeyConstants.LOGIN_ERR_WRONG_EPASS_KEY;
			return false;
		}
	}

	public boolean CheckAuthorityWithUrnAndPwd(String pUsername, String pPassword) {

		// ***************** Dummy test code *****************
		if (!pUsername.equals("user01")) {
			System.out.println("**********" + pUsername + "**********");
			checkErrorFlag = LoginKeyConstants.LOGIN_ERR_WRONG_USER_NAME;
			return false;
		} else {
			if (!pPassword.equals("12345")) {
				checkErrorFlag = LoginKeyConstants.LOGIN_ERR_WRONG_PASSWORD;
				return false;
			} else {
				checkErrorFlag = LoginKeyConstants.LOGIN_NO_ERR;
				return true;
			}
		}
		// ***************** Dummy test code *****************
	}

	private String HashCiphertext() {

		String ciphertext = null;
		if ((randomString != null) && (randomString.length() > 0)) {
			byte[] publicKeyByteArray = null;
			publicKeyByteArray = publicKey.getBytes();
			int publicKeyByteArrayLength = publicKeyByteArray.length;
			byte[] randomStringByteArray = null;
			randomStringByteArray = randomString.getBytes();
			int randomStringByteArrayLength = randomStringByteArray.length;
			byte[] key1 = new byte[16];
			byte[] key2 = new byte[16];
			byte[] tDig = new byte[16];
			// System.out.println(publicKey);
			// System.out.println(randomString);
			// System.out.println(publicKeyByteArrayLength);
			// System.out.println(randomStringByteArrayLength);
			IHash hash = new CHash();
			hash.MD5_HMAC(randomStringByteArray, randomStringByteArrayLength, publicKeyByteArray, publicKeyByteArrayLength, key1, key2, tDig);
			ciphertext = DoConvertString(tDig);
		} else {
			ciphertext = null;
		}
		return ciphertext;
	}

	private String DoConvertString(byte[] byteArray) {

		String result = "";
		int Hiw, Low;
		for (int i = 0; i < 16; i++) {
			Hiw = Low = byteArray[i];
			Low &= 0xF;
			Hiw >>= 4;
			Hiw &= 0xF;
			result = result + Hex(Hiw) + Hex(Low);
		}
		return result;
	}

	private char Hex(int bin) {

		char retval;
		if (bin >= 0 && bin <= 9) {
			retval = (char) ('0' + bin);
		} else if (bin >= 10 && bin <= 15) {
			retval = (char) ('A' + bin - 10);
		} else {
			retval = '0';
		}
		return retval;
	}
}
