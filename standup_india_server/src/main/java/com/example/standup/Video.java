package com.example.standup;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(catalog = "videos")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Video {
    @Id
    private String url;
    private String comic;
    private String thumbnail;
    private String title;
}
