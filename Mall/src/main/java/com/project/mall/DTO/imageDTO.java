package com.project.mall.DTO;

import com.project.mall.entity.Image;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class imageDTO {

	private Long id;
	private String fileName;
	private String filePath;
	
	public static Image toImageDTO(final imageDTO dto) {
		return Image.builder()
				.id(dto.getId())
				.fileName(dto.getFileName())
				.filePath(dto.getFilePath())
				.build();
	}
}
