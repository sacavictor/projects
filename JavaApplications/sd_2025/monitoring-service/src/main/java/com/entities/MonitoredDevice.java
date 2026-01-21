package com.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.sql.Time;
import java.util.UUID;

@Entity
@Table(name = "measurements")
public class MonitoredDevice implements Serializable {
    @Id
    private UUID id;

    private Double maxHourlyEnergyConsumption;

    private UUID userId;

    public MonitoredDevice() {
    }
    public MonitoredDevice(UUID id, Double maxHourlyEnergyConsumption, UUID userId) {
        this.id = id;
        this.maxHourlyEnergyConsumption = maxHourlyEnergyConsumption;
        this.userId = userId;
    }

    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public Double getMaxHourlyEnergyConsumption() {
        return maxHourlyEnergyConsumption;
    }
    public void setMaxHourlyEnergyConsumption(Double maxHourlyEnergyConsumption) {
        this.maxHourlyEnergyConsumption = maxHourlyEnergyConsumption;
    }
    public UUID getUserId() {
        return userId;
    }
    public void setUserId(UUID userId) {
        this.userId = userId;
    }

}
