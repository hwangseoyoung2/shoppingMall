package com.project.mall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mall.entity.Notice;
import com.project.mall.repository.NoticeRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeService {

	@Autowired
	NoticeRepository noticeRepository;

	public Notice save(Notice notice) {
		return noticeRepository.save(notice);
	}
	
	public List<Notice> noticeAll() {
		return noticeRepository.findAll();
	}
	
	public Notice findById(Long id) {
		return noticeRepository.findById(id).orElse(null);
	}
	
	public void deleteById(Long id) {
		noticeRepository.deleteById(id);
	}
}
