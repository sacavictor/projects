package com.controllers;

import com.entities.HourlyConsumption;
import com.repositories.HourlyConsumptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/monitoring")
public class MonitoringController {

    @Autowired
    private HourlyConsumptionRepository repo;

    // GET /monitoring/history?deviceId=1
    @GetMapping("/history")
    public ResponseEntity<List<HourlyConsumption>> getHistory(@RequestParam UUID deviceId, @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        // In a real app, you would verify the JWT user owns this deviceId here
        long startOfDay = date.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
        long endOfDay = startOfDay + (24 * 60 * 60 * 1000) - 1;

        List<HourlyConsumption> data = repo.findAllByDeviceIdAndTimestampBetween(deviceId, startOfDay, endOfDay);

        // You must return a ResponseEntity object
        return ResponseEntity.ok(data);
    }
}
