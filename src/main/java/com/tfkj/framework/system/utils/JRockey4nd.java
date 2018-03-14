package com.tfkj.framework.system.utils;

import FTsafe.Rockey4nd;

public class JRockey4nd {

	private static int checkRockey = 0;

	private int checkErrorFlag = ConstantsRockey.ROCKEY_NO_ERROR;

	public int getCheckErrorFlag() {

		return (this.checkErrorFlag);
	}

	private String DoConvertString(byte[] byteArray) {

		String result = "";
		int Hiw, Low;
		for (int i = 0; i < 6; i++) {
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

	public boolean checkRokey4nd(String zuigaodanwei) {

		if (checkRockey == 1) {
			return true;
		}
		short[] handle = new short[1];
		int[] lp1 = new int[1];
		int[] lp2 = new int[2];
		short[] p1 = new short[1];
		short[] p2 = new short[1];
		short[] p3 = new short[1];
		short[] p4 = new short[1];
		byte[] buffer = new byte[1024];
		short retval;
		short[] rc = new short[4];
		int[] suijishu = new int[1];
		Rockey4nd rockey = new Rockey4nd();
		p1[0] = 0x3bef;
		p2[0] = 0x0f43;
		p3[0] = 0;
		p4[0] = 0;
		retval = rockey.Rockey4nd(rockey.RY_FIND, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_NOKEY;
			return false;
		}
		// System.out.println("Find Rock:"+lp1[0]);
		retval = rockey.Rockey4nd(rockey.RY_OPEN, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_OPEN;
			return false;
		}
		p1[0] = 0;
		p2[0] = 12;
		retval = rockey.Rockey4nd(rockey.RY_READ, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_BUFFERREAD;
			return false;
		}
		String topdcode = DoConvertString(buffer);
		if (!topdcode.equals(zuigaodanwei)) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_DANWEI;
			return false;
		}
		retval = rockey.Rockey4nd(rockey.RY_RANDOM, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_RANDOM;
			return false;
		}
		suijishu[0] = p1[0];
		lp2[0] = suijishu[0];
		retval = rockey.Rockey4nd(rockey.RY_SEED, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_SEED;
			return false;
		}
		// System.out.println("Seed: "+p1[0]+","+p2[0]+","+p3[0]+","+p4[0]);
		rc[0] = p1[0];
		rc[1] = p2[0];
		rc[2] = p3[0];
		rc[3] = p4[0];
		rc[0] -= 1;
		rc[1] *= 2;
		rc[2] += 3;
		rc[3] += 4;
		rc[0] += rc[1];
		rc[0] *= rc[2];
		rc[0] -= rc[3];
		lp1[0] = 0;
		lp2[0] = suijishu[0];
		p1[0] = 1;
		p2[0] = 2;
		p3[0] = 3;
		p4[0] = 4;
		retval = rockey.Rockey4nd(rockey.RY_CALCULATE2, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CACULATE2;
			return false;
		}
		// System.out.println("Calculate Input: p1=1, p2=2, p3=3, p4=4");
		// System.out.println("Result = "+rc[0]+","+rc[1]+","+rc[2]+","+rc[3]);
		// System.out.println("Caculate result: p1="+p1[0]+",p2="+p2[0]+",p3="+p3[0]+",p4="+p4[0]);
		if (!(rc[0] == p1[0] && rc[1] == p2[0] && rc[2] == p3[0] && rc[3] == p4[0])) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CACULATE2CHECK;
			return false;
		}
		/*
		 * lp1[0] = 0x88888888; retval =
		 * rockey.Rockey4nd(rockey.RY_WRITE_USERID,
		 * handle,lp1,lp2,p1,p2,p3,p4,buffer); if(retval!=rockey.ERR_SUCCESS) {
		 * System.out.println("Write UserId failed!"); return false; }
		 * System.out.println("Write User ID: "+lp1[0]);
		 */
		lp1[0] = 0;
		retval = rockey.Rockey4nd(rockey.RY_READ_USERID, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_USERIDREAD;
			return false;
		}
		// System.out.println("Read User ID: "+lp1[0]);
		/*
		 * p1[0]=7; p2[0]=0x2121; p3[0]=0; retval =
		 * rockey.Rockey4nd(rockey.RY_SET_MODULE
		 * ,handle,lp1,lp2,p1,p2,p3,p4,buffer); if(retval!=rockey.ERR_SUCCESS) {
		 * System.out.println("Set module failed!"); return false; }
		 * System.out.println
		 * ("Set module 7,pass="+p2[0]+",Decreasement not allowed!");
		 */
		p1[0] = 0;
		retval = rockey.Rockey4nd(rockey.RY_CHECK_MODULE, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CHECKMODULE;
			return false;
		}
		// System.out.print("Check module 7:");
		if (p2[0] == 0) {
			// System.out.println("Allow!");
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_MODULE0;
			return false;
		}
		// else System.out.println("Not Allow!");
		// if(p3[0]!=0)System.out.println("Allow decresement!");
		// else System.out.println("Decrsement not allowed!");
		/*
		 * p1[0]=0; buffer[0]='H';buffer[1]='=';buffer[2]='H';
		 * buffer[3]='^';buffer[4]='H';buffer[5]=',';
		 * buffer[6]='A';buffer[7]='=';buffer[8]='A';
		 * buffer[9]='*';buffer[10]='2';buffer[11]='3';
		 * buffer[12]=',';buffer[13]='F';buffer[14]='=';
		 * buffer[15]='B';buffer[16]='*';buffer[17]='1';
		 * buffer[18]='7';buffer[19]=',';buffer[20]='A';
		 * buffer[21]='=';buffer[22]='A';buffer[23]='+';
		 * buffer[24]='F';buffer[25]=',';buffer[26]='A';
		 * buffer[27]='=';buffer[28]='A';buffer[29]='+';
		 * buffer[30]='G';buffer[31]=',';buffer[32]='A';
		 * buffer[33]='=';buffer[34]='A';buffer[35]='<';
		 * buffer[36]='C';buffer[37]=',';buffer[38]='A';
		 * buffer[39]='=';buffer[40]='A';buffer[41]='^';
		 * buffer[42]='D';buffer[43]=',';buffer[44]='B';
		 * buffer[45]='=';buffer[46]='B';buffer[47]='^';
		 * buffer[48]='B';buffer[49]=',';buffer[50]='C';
		 * buffer[51]='=';buffer[52]='C';buffer[53]='^';
		 * buffer[54]='C';buffer[55]=',';buffer[56]='D';
		 * buffer[57]='=';buffer[58]='D';buffer[59]='^'; buffer[60]='D';
		 * retval=rockey.Rockey4nd(rockey.RY_WRITE_ARITHMETIC,handle,lp1,lp2,p1,p2
		 * ,p3,p4,buffer); if(retval!=rockey.ERR_SUCCESS) {
		 * System.out.println("write arithmetic failed!"); return false; }
		 * System.out.println("Write Arithmetic 1,Succeed!");
		 */
		lp1[0] = 8;
		lp2[0] = 0;
		p1[0] = 5;
		p2[0] = 2;
		p3[0] = 3;
		p4[0] = 1;
		retval = rockey.Rockey4nd(rockey.RY_CALCULATE1, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CACULATE1;
			return false;
		}
		// System.out.println("Calculate Output: p1="+p1[0]+",p2="+p2[0]+",p3="+p3[0]+",p4="+p4[0]);
		if (p1[0] != 0x438C) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CACULATE1CHECK;
			return false;
		}
		retval = rockey.Rockey4nd(rockey.RY_CLOSE, handle, lp1, lp2, p1, p2, p3, p4, buffer);
		if (retval != rockey.ERR_SUCCESS) {
			checkErrorFlag = ConstantsRockey.ROCKEY_ERROR_CLOSE;
			return false;
		}
		checkRockey = 1;
		return true;
	}
}
