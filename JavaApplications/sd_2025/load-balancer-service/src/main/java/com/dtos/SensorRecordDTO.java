package com.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.UUID;

public class SensorRecordDTO {
    private Long timestamp;
    @JsonProperty("device_id")
    private UUID deviceId;
    @JsonProperty("measurement_value")// Matches simulator JSON snake_case
    private Double measurementValue;

    public SensorRecordDTO() {
    }

    public SensorRecordDTO(Long timestamp, UUID deviceId, Double measurementValue) {
        this.timestamp = timestamp;
        this.deviceId = deviceId;
        this.measurementValue = measurementValue;
    }
    public Long getTimestamp() {
        return timestamp;
    }
    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }
    public UUID getDeviceId() {
        return deviceId;
    }
    public void setDeviceId(UUID deviceId) {
        this.deviceId = deviceId;
    }
    public Double getMeasurementValue() {
        return measurementValue;
    }
    public void setMeasurementValue(Double measurementValue) {
        this.measurementValue = measurementValue;
    }

}
