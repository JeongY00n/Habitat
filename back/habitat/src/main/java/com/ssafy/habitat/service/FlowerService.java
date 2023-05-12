package com.ssafy.habitat.service;

import com.ssafy.habitat.entity.Flower;
import com.ssafy.habitat.exception.CustomException;
import com.ssafy.habitat.exception.ErrorCode;
import com.ssafy.habitat.repository.FlowerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FlowerService {

    private FlowerRepository flowerRepository;

    @Autowired
    public FlowerService(FlowerRepository flowerRepository) {
        this.flowerRepository = flowerRepository;
    }

    public void addFlower(Flower flower) {
        flowerRepository.save(flower);
    }

    @Cacheable(value = "Flower", key = "#flowerKey", cacheManager = "cacheManager")
    public Flower getFlower(int flowerKey) {
        Flower findFlower = flowerRepository.findById(flowerKey).orElseThrow(()->new CustomException(ErrorCode.FLOWER_NOT_FOUND));
        return findFlower;
    }

    public List<Flower> getFlowerList() {
        List<Flower> flowerList = flowerRepository.findAll();
        return flowerList;
    }
}
