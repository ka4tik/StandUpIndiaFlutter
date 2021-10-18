package com.example.standup;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@org.springframework.cloud.openfeign.FeignClient(name = "youtube", url = "https://www.googleapis.com")
public interface YoutubeApi {

    @GetMapping("/youtube/v3/videos?id={id}&key=AIzaSyBPzQ45CVDlpumB-U_3hzLoc3-xh-txPZ4%20&part=snippet,contentDetails,statistics,status")
    Root getDetails(@PathVariable("id") String id);

}
