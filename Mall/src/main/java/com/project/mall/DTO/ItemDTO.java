	package com.project.mall.DTO;
	
	import java.util.List;
	
	import com.project.mall.entity.Image;
	import com.project.mall.entity.Item;
	
	import lombok.AllArgsConstructor;
	import lombok.Builder;
	import lombok.Data;
	import lombok.NoArgsConstructor;
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	public class ItemDTO {
	
		private Long id;
		private String title;
		private String content;
		private String mainCategory;
		private Long price;
		private List<Image> images;
		
		public static Item toItemDTO(final ItemDTO dto) {
			return Item.builder()
					.id(dto.getId())
					.title(dto.getTitle())
					.content(dto.getContent())
					.mainCategory(dto.getMainCategory())
					.images(dto.getImages())
					.price(dto.getPrice())
					.build();
		}
	}
