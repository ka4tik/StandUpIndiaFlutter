package com.example.standup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.util.List;

@RestController("/")
public class ComicsController {

//    @PostConstruct
//    void addComics() {
//        comediansRepository.save(Comedian.builder().id(1).title("Tanmay Bhat")
//                .posterPath("https://upload.wikimedia.org/wikipedia/commons/d/df/Tanmay_Bhat.png").build());
//        comediansRepository.save(Comedian.builder().id(2).title("Zakhir Khan")
//                .posterPath("https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Zakir_khan_2.jpg/1920px-Zakir_khan_2.jpg").build());
//    }
    @Autowired
    private ComediansRepository comediansRepository;
    @GetMapping("/")
    public List<Comedian> getComedians() {
        return comediansRepository.findAll();
    }
}
