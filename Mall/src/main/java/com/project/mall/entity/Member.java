package com.project.mall.entity;


import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "member")
public class Member {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(length = 20)
	private String memberId;
	
	@Column(length = 20)
	private String password;
	
	@Column(length = 10)
	private String name;
	
	@Column(length = 20)
	private String phone;
	
	@Column(length = 30)
	private String email;
	
	@Column(length = 30)
	private String address;
	
	@Column(length = 30)
	private String detailAddress;
	
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<CartItem> cartItems = new ArrayList<>();

    @Builder
    public Member(String memberId, String password, String name, String phone, String email, String address) {
    	this.memberId = memberId;
    	this.password = password;
    	this.name = name;
    	this.phone = phone;
    	this.email = email;
    	this.address = address;
    }
    

}
