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

    @Autowired
    private YoutubeApi youtubeApi;
    @PostConstruct
    void post() {

        videoRepository.findAll().forEach(video -> {

            if (video.getTitle() == null || true) {
                String id = video.getUrl().split("v=")[1];
                Root details = youtubeApi.getDetails(id);
                String title = details.getItems().get(0).getSnippet().getTitle();
                video.setThumbnail("https://img.youtube.com/vi/" + id + "/0.jpg");
                video.setTitle(title);
                videoRepository.save(video);
                int a = 1;
            }
        });


    }
    @GetMapping("/videos/{comic}")
    List<Video> getVideosForComic(@PathVariable String comic) {
       return videoRepository.findAllByComic(comic);
    }
}
