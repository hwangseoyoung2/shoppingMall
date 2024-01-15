package com.project.mall.DTO;

import com.project.mall.entity.Member;

import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class memberDTO {

	private Long id;
	private String memberId;
	private String password;
	private String name;
	private String phone;
	private String email;
	private String address;
	
	public static Member toMemberDTO(final memberDTO dto) {
		return Member.builder()
				.id(dto.getId())
				.memberId(dto.getMemberId())
				.password(dto.getPassword())
				.name(dto.getName())
				.phone(dto.getPhone())
				.email(dto.getEmail())
				.address(dto.getAddress())
				.build();
	}
}
