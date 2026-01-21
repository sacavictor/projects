package com.example.demo.dtos;

import java.util.UUID;

public class DeviceDTO {
    private UUID id;
    private String model;
    private String manufacturer;
    private UUID personId;
    private String personName;

    public UUID getPersonId() {
        return personId;
    }

    public void setPersonId(UUID personId) {
        this.personId = personId;
    }

    public DeviceDTO() {}

    public DeviceDTO(UUID id, String model, String manufacturer, UUID personId, String personName) {
        this.id = id;
        this.model = model;
        this.manufacturer = manufacturer;
        this.personId = personId;
        this.personName = personName;
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

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }
}
