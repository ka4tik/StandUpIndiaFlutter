package com.example.standup;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneOffset;
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

//    @PostConstruct
    void post() {

        Map<String, Integer> likesCounts = new HashMap<>();
        Map<String, Integer> commentsCount = new HashMap<>();
        Map<String, Integer> viewCounts = new HashMap<>();

        videoRepository.findAll().forEach(video -> {
            String id = video.getUrl().split("v=")[1];

            Root details = youtubeApi.getDetails(id);

            try {
                likesCounts.putIfAbsent(video.getComic(), 0);
                int likes = Integer.parseInt(details.getItems().get(0).getStatistics().getLikeCount());
                likesCounts.put(video.getComic(), likesCounts.get(video.getComic()) + likes);
                video.setLikes(likes);

            }
            catch (Exception e) {
//                e.printStackTrace();
                return;
            }



            try {
                int commentCount = Integer.parseInt(details.getItems().get(0).getStatistics().getCommentCount());
                commentsCount.putIfAbsent(video.getComic(), 0);
                video.setCommentsCount(commentCount);

            } catch (Exception e) {
//                e.printStackTrace();
                return;
            }
//            dislikesCounts.put(video.getComic(), dislikesCounts.get(video.getComic()) + dislikes);

            try {
                viewCounts.putIfAbsent(video.getComic(), 0);
                int viewCount = Integer.parseInt(details.getItems().get(0).getStatistics().getViewCount());
                viewCounts.put(video.getComic(), viewCounts.get(video.getComic()) + viewCount);

                String publishedDate = details.getItems().get(0).getSnippet().getPublishedAt();
                long publishTime = LocalDate.parse(publishedDate.substring(0, 10)).toEpochSecond(LocalTime.MIDNIGHT, ZoneOffset.UTC);
                video.setViewCount(viewCount);
//            video.setLovedRatio(likes / dislikes);
                video.setPublishedTime(publishTime);
                videoRepository.save(video);
            } catch (Exception e){
//                e.printStackTrace();
            }

        });

        likesCounts.keySet().forEach(comic -> {
            Comedian comics = comediansRepository.findByTitle(comic);
            if (comics != null) {
                comics.setLikes(likesCounts.get(comic));
                comics.setCommentsCount(commentsCount.get(comic));
                comics.setViewCount(viewCounts.get(comic));
//                comics.setLovedRatio((double) (likesCounts.get(comic) / dislikesCounts.get(comic)));
                comediansRepository.save(comics);
            }
        });
        videoRepository.findAll().forEach(video -> {

            if (video.getTitle() == null) {
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

    @GetMapping("/videosByViews")
    List<Video> getVideosByViews() {
        return videoRepository.findAllByOrderByViewCountDesc();
    }

    @GetMapping("/videosByLikedCount")
    List<Video> getVideosByLikedCount() {
        return videoRepository.findAllByOrderByLovedRatioDesc();
    }

    @GetMapping("/videosByPublishedTime")
    List<Video> getVideosByPublishedTime() {
        return videoRepository.findAllByOrderByPublishedTimeDesc();
    }
}
