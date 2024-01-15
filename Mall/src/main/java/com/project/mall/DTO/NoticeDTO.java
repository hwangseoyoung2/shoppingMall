package com.project.mall.DTO;


import com.project.mall.entity.Notice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NoticeDTO {

	private Long id;
	private String title;
	private String content;
	
	public static Notice toNotice(final NoticeDTO dto) {
		return Notice.builder()
				.id(dto.getId())
				.title(dto.getTitle())
				.content(dto.getContent())
				.build();
	}
}
