package com.ssafy.habitat.repository;

import com.ssafy.habitat.entity.Planting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlantingRepository extends JpaRepository<Planting, Integer> {
}
