package com.project.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.Image;
import com.project.mall.entity.Item;

public interface ImageRepository extends JpaRepository<Image, Long> {
	
	    List<Image> findByItem(Item item);
	 
}
