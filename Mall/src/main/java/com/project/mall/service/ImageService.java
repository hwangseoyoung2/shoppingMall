package com.project.mall.service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.mall.entity.Image;
import com.project.mall.entity.Item;
import com.project.mall.repository.ImageRepository;

@Service
public class ImageService {

	@Autowired
	ImageRepository imageRepository;

	public Image saveImage(MultipartFile file, Item item) throws Exception {
	    if (!file.isEmpty()) {
	        String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
	        UUID uuid = UUID.randomUUID();
	        String fileName = uuid + "_" + file.getOriginalFilename();
	        File saveFile = new File(projectPath, fileName);
	        file.transferTo(saveFile);

	        Image image = new Image();
	        image.setFileName(fileName);
	        image.setFilePath("/resources/static/files/" + fileName);
	        image.setItem(item);

	        return imageRepository.save(image);
	    }
	    return null;
	}

}
