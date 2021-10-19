package com.example.standup;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VideoRepository extends JpaRepository<Video, String> {
    List<Video> findAllByComic(String comic);

    List<Video> findAllByOrderByViewCount();
}
