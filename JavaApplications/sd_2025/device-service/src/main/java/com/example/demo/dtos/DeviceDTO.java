package com.example.demo.dtos;

import com.example.demo.entities.Device;

import java.util.UUID;

public class DeviceDTO {
    private UUID id;
    private UUID personId;

    public UUID getPersonId() {
        return personId;
    }

    public void setPersonId(UUID personId) {
        this.personId = personId;
    }

    private String model;

    private String manufacturer;
    private Double maxHourlyEnergyConsumption;

    public DeviceDTO() {}


    public DeviceDTO(UUID id, String model, String manufacturer, UUID personId, Double maxHourlyEnergyConsumption) {
        this.id = id;
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

    public Double getMaxHourlyEnergyConsumption() {
        return maxHourlyEnergyConsumption;
    }

    public void setMaxHourlyEnergyConsumption(Double maxHourlyEnergyConsumption) {
        this.maxHourlyEnergyConsumption = maxHourlyEnergyConsumption;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public static DeviceDTO fromEntity(Device device) {
        return new DeviceDTO(device.getId(), device.getModel(), device.getManufacturer(), device.getPersonId(), device.getMaxHourlyEnergyConsumption());
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
