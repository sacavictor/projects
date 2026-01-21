package com.services;
import jakarta.persistence.*;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.repositories.HourlyConsumptionRepository;
import com.repositories.MonitoredDeviceRepository;
import com.entities.HourlyConsumption;
import com.entities.MonitoredDevice;
import com.dtos.SensorRecordDTO;
import org.springframework.web.client.RestTemplate;

@Service
public class MonitoringService {

    @Autowired
    private HourlyConsumptionRepository repo;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private MonitoredDeviceRepository deviceRepo; // To get max limit


    public void processMeasurement(SensorRecordDTO data) {
        // 1. Validate Device (Optional but recommended)
        MonitoredDevice device = deviceRepo.findById(data.getDeviceId()).orElse(null);
        if (device == null) {
            System.out.println("Received data for unknown device: " + data.getDeviceId());
            return; // Or create a default placeholder
        }

        // 2. Normalize Timestamp to the Hour (milliseconds)
        long hourMillis = (data.getTimestamp() / 3600000) * 3600000;

        // 3. Find or Create
        HourlyConsumption record = repo.findByDeviceIdAndTimestamp(data.getDeviceId(), hourMillis);
        if (record == null) {
            record = new HourlyConsumption();
        }

        if (record.getId() == null) {
            record.setDeviceId(data.getDeviceId());
            record.setTimestamp(hourMillis);
            record.setTotalConsumption(0.0);
        }

        // 4. Aggregate (Summing the 10-min delta)
        record.setTotalConsumption(record.getTotalConsumption() + data.getMeasurementValue());
        repo.save(record);

        // 5. Check Limit
        if (record.getTotalConsumption() > device.getMaxHourlyEnergyConsumption()) {
            String alertMessage = "Alert: Sensor " + data.getDeviceId() +
                    " exceeded limit with value: " + data.getMeasurementValue();

            // This sends the message to your WebSocket Microservice
            rabbitTemplate.convertAndSend("notification.queue", alertMessage);
        }
    }
}