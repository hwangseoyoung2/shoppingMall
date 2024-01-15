package com.project.mall.DTO;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.project.mall.entity.Question;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDTO {

	private Long id;
	
	private String content;
	
	private String category;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    @Builder.Default
    private LocalDate createdDate = LocalDate.now();


	public static Question toQuestionDTO(final QuestionDTO dto) {
		return Question.builder()
				.id(dto.getId())
				.content(dto.getContent())
				.createdDate(dto.getCreatedDate())
				.category(dto.getCategory())
				.build();
	}
}
