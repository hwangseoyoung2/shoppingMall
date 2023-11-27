package com.project.mall.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "kakaoUser")
public class KakaoUser {

	@Id
	private String userId;
	private String name;
	private String email;
	private String gender;
	private String birth;
	
	@OneToMany(mappedBy = "kakaoUser", cascade = CascadeType.ALL)
	private List<CartItem> cartItems = new ArrayList<>();
	
}	
