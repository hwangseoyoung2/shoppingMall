package com.project.mall.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.mall.entity.CartItem;
import com.project.mall.entity.KakaoUser;
import com.project.mall.repository.KakaoService;
import com.project.mall.repository.KakaoUserRepository;

@Service
public class KakaoServiceImpl implements KakaoService {

	@Autowired
	KakaoUserRepository kakaoUserRepository;

	@Override
	public String getToken(String code) throws Exception {
		String access_Token = "";
		final String requestUrl = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(requestUrl);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=f4a713fc2af3367631b01a92f5b6cc9d");
			sb.append("&redirect_uri=http://localhost:8080/kakaoLogin");
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(result);
			access_Token = jsonNode.get("access_token").asText();

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}

	public ArrayList<Object> getUserInfo(String access_token) throws Exception {
		ArrayList<Object> list = new ArrayList<Object>();

		final String requestUrl = "https://kapi.kakao.com/v2/user/me";
		try {

			URL url = new URL(requestUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "Bearer " + access_token);

			BufferedReader bf = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = "";
			String result = "";

			while ((line = bf.readLine()) != null) {
				result += line;
			}
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String nickName = properties.getAsJsonObject().get("nickname").getAsString();
			
			//선택항목 미동의 시 null값 허용
			String email = kakao_account.has("email") ? kakao_account.get("email").getAsString() : "";
			String gender = kakao_account.has("gender") ? kakao_account.get("gender").getAsString() : "";
			String birthday = kakao_account.has("birthday") ? kakao_account.get("birthday").getAsString() : "";
			
			list.add(nickName);
			list.add(nickName);
			list.add(email);
			list.add(birthday);

			// DB 저장
			List<CartItem> cartItems = new ArrayList<>();
			KakaoUser kakaouser = new KakaoUser(nickName, nickName, email, gender, birthday, cartItems);
			kakaoUserRepository.save(kakaouser);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return list;
	}
	
    public KakaoUser convertToKakaoUser(ArrayList<Object> kakaoUserInfo) {
        KakaoUser kakaoUser = new KakaoUser();
        kakaoUser.setUserId((String) kakaoUserInfo.get(0)); //아이디
        kakaoUser.setName((String) kakaoUserInfo.get(1)); // 이름
        kakaoUser.setEmail((String) kakaoUserInfo.get(2));    // 이메일
        kakaoUser.setBirth((String) kakaoUserInfo.get(3)); // 생일
        return kakaoUser;
    }
	
	//로그아웃
	public void unlink(String access_token) {
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);

			int responseCode = conn.getResponseCode();

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Page<KakaoUser> findAllKakaoMember(int page){
		Pageable pageable = PageRequest.of(page, 10);
		return kakaoUserRepository.findAll(pageable);
	}
	
	public Page<KakaoUser> findByName(String keyword, int page) {
		Pageable pageable = PageRequest.of(page, 10);
		return kakaoUserRepository.findByNameContaining(keyword, pageable);
	}
}
