package com.project.mall.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.mall.DTO.ItemDTO;
import com.project.mall.entity.Image;
import com.project.mall.entity.Item;
import com.project.mall.repository.ImageRepository;
import com.project.mall.repository.ItemRepository;

@Service
public class ItemService {

	@Autowired
	ItemRepository itemRepository;

	@Autowired
	ImageRepository imageRepository;

	@Autowired
	ImageService imageService;

	// 게시글 저장
	public void saveItemWithImages(Item item, List<MultipartFile> imageFiles) throws Exception {
		itemRepository.save(item);

		List<Image> images = new ArrayList<>();

		for (MultipartFile imageFile : imageFiles) {
			Image image = imageService.saveImage(imageFile, item);

			if (image != null) {
				images.add(image);
			}
		}
		item.setImages(images);
	}

	// 게시글 전체
	public List<ItemDTO> allListWithImages() {
		List<Item> items = itemRepository.findAll();
		List<ItemDTO> itemDTOs = new ArrayList<>();

		for (Item item : items) {
			List<Image> images = imageRepository.findByItem(item);

			ItemDTO itemDTO = ItemDTO.builder().id(item.getId()).title(item.getTitle()).content(item.getContent())
					.mainCategory(item.getMainCategory()).price(item.getPrice())
					.images(images) // 이미지 리스트 설정
					.build();

			itemDTOs.add(itemDTO);
		}

		return itemDTOs;
	}

	// 게시글 하나
	public ItemDTO selectOne(Long id) {
		Item item = itemRepository.findByIdWithImages(id);

		List<Image> images = imageRepository.findByItem(item);

		return ItemDTO.builder().id(item.getId()).title(item.getTitle()).content(item.getContent())
				.mainCategory(item.getMainCategory()).price(item.getPrice())
				.images(images).build();
	}

	@Transactional
	public void updateItem(ItemDTO itemDTO, MultipartFile[] imageFiles) throws IOException {
		try {
			// 기존 Item 가져오기
			Item item = itemRepository.findByIdWithImages(itemDTO.getId());

			// 새로운 이미지 추가 작업
			for (int i = 0; i < imageFiles.length; i++) {
				MultipartFile file = imageFiles[i];
				if (!file.isEmpty()) {
					// 이미지 파일 저장 경로 설정
					String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
					UUID uuid = UUID.randomUUID();
					String fileName = uuid + "_" + file.getOriginalFilename();
					File saveFile = new File(projectPath, fileName);
					file.transferTo(saveFile);

					Image image = new Image();
					image.setFileName(fileName);
					image.setFilePath("/resources/static/files/" + fileName);
					image.setItem(item);

					imageRepository.save(image);
				}
			}
			
			// 기존 이미지를 삭제하기 위한 작업
			List<Image> existingImages = item.getImages();
			for (Image existingImage : existingImages) {
				String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
				File imageFile = new File(projectPath + "\\" + existingImage.getFileName());

				try {
					if (imageFile.exists()) {
						imageFile.delete();
					}
				} catch (Exception e) {
					System.err.println("Error while deleting image or entity: " + e.getMessage());
				}
			}
			imageRepository.deleteAll(existingImages);
			existingImages.clear();

			// Item 엔티티 수정
			BeanUtils.copyProperties(itemDTO, item, "id", "images");
			itemRepository.save(item);

		} catch (Exception e) {
			System.err.println("Error during update: " + e.getMessage());
		}
	}

	// 게시글 삭제
	public void Delete(Long id) {
		itemRepository.deleteById(id);
	}

	public Item findById(Long id) {
		return itemRepository.findById(id).orElseThrow(() -> new RuntimeException("Item not found with id: " + id));
	}
	
	public Item getById(Long id) {
		return itemRepository.getById(id);
	}
	
	public List<Item> MainCategory(String MainCategory){
		return itemRepository.findByMainCategory(MainCategory);
	}
	
	public List<Item> findByTitle(String keyword){
		return itemRepository.findByTitleContaining(keyword);
	}
	
	public List<Item> findAll(){
		return itemRepository.findAll();
	}
	
	public void updateItemWithoutImages(ItemDTO itemDTO) {
	    // 기존 Item 가져오기
	    Item item = itemRepository.findByIdWithImages(itemDTO.getId());

	    // itemDTO로부터 필요한 정보만 복사 (id, images 제외)
	    BeanUtils.copyProperties(itemDTO, item, "id", "images");
	    itemRepository.save(item);
	}
	
}
