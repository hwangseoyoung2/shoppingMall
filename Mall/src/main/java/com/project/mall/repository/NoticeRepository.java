package com.project.mall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.mall.entity.Notice;

public interface NoticeRepository extends JpaRepository<Notice, Long> {

}
