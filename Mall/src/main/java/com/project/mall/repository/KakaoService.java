package com.project.mall.repository;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface KakaoService {
	
	public String getToken(String code) throws Exception;
	public ArrayList<Object> getUserInfo(String access_token)throws Exception;

}
