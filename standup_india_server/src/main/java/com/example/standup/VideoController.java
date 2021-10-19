package com.example.standup;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class VideoController {

    @Autowired
    private VideoRepository videoRepository;

    @Autowired
    private ComediansRepository comediansRepository;

    @Autowired
    private YoutubeApi youtubeApi;
    @PostConstruct
    void post() {

        Map<String, Integer> likesCounts = new HashMap<>();
        Map<String, Integer> dislikesCounts = new HashMap<>();
        Map<String, Integer> viewCounts = new HashMap<>();

        videoRepository.findAll().forEach(video -> {
            String id = video.getUrl().split("v=")[1];

            Root details = youtubeApi.getDetails(id);
            likesCounts.putIfAbsent(video.getComic(), 0);
            int likes = Integer.parseInt(details.getItems().get(0).getStatistics().getLikeCount());
            likesCounts.put(video.getComic(), likesCounts.get(video.getComic()) +  likes);

            int dislikes = Integer.parseInt(details.getItems().get(0).getStatistics().getDislikeCount());
            dislikesCounts.putIfAbsent(video.getComic(), 0);
            dislikesCounts.put(video.getComic(), dislikesCounts.get(video.getComic()) +  dislikes);

            viewCounts.putIfAbsent(video.getComic(), 0);
            int viewCount = Integer.parseInt(details.getItems().get(0).getStatistics().getViewCount());
            viewCounts.put(video.getComic(), viewCounts.get(video.getComic()) +  viewCount);

            video.setLikes(likes);
            video.setDislikes(dislikes);
            video.setViewCount(viewCount);
            video.setLovedRatio(likes/dislikes);
            videoRepository.save(video);

        });

        likesCounts.keySet().forEach(comic -> {
            Comedian comics = comediansRepository.findByTitle(comic);
            if (comics != null) {
                comics.setLikes(likesCounts.get(comic));
                comics.setDislikes(dislikesCounts.get(comic));
                comics.setViewCount(viewCounts.get(comic));
                comics.setLovedRatio((double) (likesCounts.get(comic) / dislikesCounts.get(comic)));
                comediansRepository.save(comics);
            }
        });
        videoRepository.findAll().forEach(video -> {

            if (video.getTitle() == null ) {
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

    @GetMapping("/videos")
    List<Video> getVideosByViews() {
        return videoRepository.findAllByOrderByViewCount();
    }
}
