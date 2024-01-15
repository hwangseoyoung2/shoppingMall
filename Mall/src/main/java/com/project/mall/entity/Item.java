package com.project.mall.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "item")
public class Item {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String title;
	
	@Column
	private String content;
	
	@Column
	private String mainCategory;

	@Column
	private Long price;
	
	@ToString.Exclude
	@OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<Image> images = new ArrayList<>();
	
    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<CartItem> cartItems = new ArrayList<>();
    
    @OneToMany(mappedBy = "item")
    private List<Question> questions;

    public Item(Long id, String title, String content, String mainCategory, String subCategory, Long price) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.mainCategory = mainCategory;
        this.price = price;
        this.images = new ArrayList<>();
    }
    
    public void removeImage(Image image) {
        if (images != null) {
            images.remove(image);
            image.setItem(null); // 이미지와의 연관 관계 해제
        }
    }

}
