package com.project.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.project.mall.entity.Item;

public interface ItemRepository extends JpaRepository<Item, Long> {
	
	@Query("SELECT i FROM Item i LEFT JOIN FETCH i.images WHERE i.id = :id")
    Item findByIdWithImages(@Param("id") Long id);
	
	List<Item> findByMainCategory(String MainCategory);
	
	List<Item> findByTitleContaining(String keyword);

	
}
