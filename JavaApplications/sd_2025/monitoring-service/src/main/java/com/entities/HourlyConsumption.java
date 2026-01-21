package com.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "hourly_consumptions")
public class HourlyConsumption implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "device_id", nullable = false)
    private UUID deviceId;

    @Column(nullable = false)
    private Long timestamp;

    @Column(name = "total_consumption")
    private Double totalConsumption;
    public HourlyConsumption() {
    }
    public HourlyConsumption(UUID deviceId, Long timestamp, Double totalConsumption) {
        this.deviceId = deviceId;
        this.timestamp = timestamp;
        this.totalConsumption = totalConsumption;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public UUID getDeviceId() {
        return deviceId;
    }
    public void setDeviceId(UUID deviceId) {
        this.deviceId = deviceId;
    }
    public Long getTimestamp() {
        return timestamp;
    }
    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }
    public Double getTotalConsumption() {
        return totalConsumption;
    }
    public void setTotalConsumption(Double totalConsumption) {
        this.totalConsumption = totalConsumption;
    }

}
