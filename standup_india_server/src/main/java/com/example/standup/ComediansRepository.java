package com.example.standup;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ComediansRepository extends JpaRepository<Comedian, Long> {

    Comedian findByTitle(String title);

    List<Comedian> findAllByOrderByLovedRatioDesc();


}
