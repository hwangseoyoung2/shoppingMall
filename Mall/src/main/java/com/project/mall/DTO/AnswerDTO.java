package com.project.mall.DTO;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.project.mall.entity.Answer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AnswerDTO {

	private Long id;
	
	private String content;
	
	private Long questionId;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Builder.Default
	private LocalDate createdDate = LocalDate.now();
	
	public static Answer toAnswerDTO(final AnswerDTO dto ) {
		return Answer.builder()
				.id(dto.getId())
				.content(dto.getContent())
				.createdDate(dto.getCreatedDate())
				.build();
	}
}
