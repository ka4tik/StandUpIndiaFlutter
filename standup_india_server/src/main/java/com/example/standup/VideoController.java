package com.example.standup;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.util.List;

@RestController
public class VideoController {

    @Autowired
    private VideoRepository videoRepository;

//    @PostConstruct
//    void addVideos() {
//        videoRepository.save(Video.builder().comic("Tanmay Bhat")
//                        .thumbnail("https://img.youtube.com/vi/4H5dtevdkEY/0.jpg")
//                .url("https://www.youtube.com/watch?v=4H5dtevdkEY").build());
//        videoRepository.save(Video.builder().comic("Tanmay Bhat")
//                .thumbnail("https://img.youtube.com/vi/uSpouJ2cKlM/0.jpg")
//                .url("https://www.youtube.com/watch?v=uSpouJ2cKlM").build());
//        videoRepository.save(Video.builder().comic("Tanmay Bhat")
//                .thumbnail("https://img.youtube.com/vi/pBp9GPbFdQk/0.jpg")
//                .url("https://www.youtube.com/watch?v=pBp9GPbFdQk").build());
//        videoRepository.save(Video.builder().comic("Zakhir Khan")
//                .thumbnail("https://img.youtube.com/vi/4H5dtevdkEY/0.jpg")
//                .thumbnail("https://img.youtube.com/vi/4H5dtevdkEY/0.jpg")
//                .url("https://www.youtube.com/watch?v=MLdXYEWTC1k").build());
//    }
    @GetMapping("/videos/{comic}")
    List<Video> getVideosForComic(@PathVariable String comic) {
       return videoRepository.findAllByComic(comic);
    }
}
