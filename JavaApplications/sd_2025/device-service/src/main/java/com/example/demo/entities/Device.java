package com.example.demo.entities;

import com.example.demo.dtos.DeviceDTO;
import jakarta.persistence.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UuidGenerator;
import org.hibernate.type.SqlTypes;

import java.util.UUID;

@Entity
public class Device {
    @Id
    @GeneratedValue
    @UuidGenerator
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID id;
    @Column(name = "model", nullable = false)
    private String model;
    @Column(name = "manufacturer", nullable = false)
    private String manufacturer;
    @Column(name = "person_id", nullable = true)
    private UUID personId;
    @Column(name = "max_hourly_energy_consumption", nullable = false)
    private Double maxHourlyEnergyConsumption;

    public Device() {
    }
    public Device(String model, String manufacturer, UUID personId, Double maxHourlyEnergyConsumption) {
        this.model = model;
        this.manufacturer = manufacturer;
        this.personId = personId;
        this.maxHourlyEnergyConsumption = maxHourlyEnergyConsumption;
    }

    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        this.model = model;
    }
    public String getManufacturer() {
        return manufacturer;
    }
    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }
    public UUID getPersonId() { return personId; }
    public void setPersonId(UUID personId) { this.personId = personId; }
    public static DeviceDTO fromEntity(Device device) {
        return new DeviceDTO(device.getId(), device.getModel(), device.getManufacturer(), device.getPersonId(), device.getMaxHourlyEnergyConsumption());
    }

    public Double getMaxHourlyEnergyConsumption() {
        return maxHourlyEnergyConsumption;
    }

    public void setMaxHourlyEnergyConsumption(Double maxHourlyEnergyConsumption) {
        this.maxHourlyEnergyConsumption = maxHourlyEnergyConsumption;
    }

    public static Device toEntity(DeviceDTO dto) {
        Device device = new Device();
        device.setId(dto.getId());
        device.setModel(dto.getModel());
        device.setManufacturer(dto.getManufacturer());
        device.setPersonId(dto.getPersonId());
        device.setMaxHourlyEnergyConsumption(dto.getMaxHourlyEnergyConsumption());
        return device;
    }
}
