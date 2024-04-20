package com.ssafy.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

@Component
public class DBUtil {

	public void close(AutoCloseable... closeables) {
		for (AutoCloseable c : closeables) {
			if (c != null) {
				try {
					c.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	public static String getHashValue(String pwd) {
		
		// 솔트 이부분은 실제 숨겨야 하는 내용
		String salt = "ssafy11th";

		
		String result = "";
		try {
			// 1. SHA256 알고리즘 객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-256");

			// 2. 비밀번호와 salt 합친 문자열에 SHA 256 적용
			md.update((pwd + salt).getBytes());
			byte[] pwdsalt = md.digest();

			// 3. byte To String (10진수의 문자열로 변경)
			StringBuffer sb = new StringBuffer();
			for (byte b : pwdsalt) {
				sb.append(String.format("%02x", b));
			}

			result = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;
		
		
	}

}
