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
@Table(catalog = "comedians")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Comedian {
    @Id
    private int id;
    private String title;
    private String posterPath;
}
