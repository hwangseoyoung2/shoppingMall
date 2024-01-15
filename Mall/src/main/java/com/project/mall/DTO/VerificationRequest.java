package com.project.mall.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class VerificationRequest {
	private String email;
	private String userVerificationCode;
}
