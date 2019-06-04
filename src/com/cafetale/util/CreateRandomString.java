package com.cafetale.util;

import java.util.UUID;

public class CreateRandomString {
	public static String createRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
