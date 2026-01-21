package com.messaging;

import com.entities.MonitoredDevice;
import com.repositories.MonitoredDeviceRepository;
import com.services.MonitoringService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

import java.util.Map;
import java.util.UUID;

@Component
public class DeviceSyncConsumer {

    @Autowired
    private MonitoredDeviceRepository deviceRepo;


    @RabbitListener(queues = "device-sync-queue")
    public void consumeDeviceSync(Map<String, Object> message) {
        try {
            // Log the message so you can see it in 'docker logs'
            System.out.println("Received sync message: " + message);

            if ("DEVICE_CREATED".equals(message.get("event"))) {
                MonitoredDevice device = new MonitoredDevice();

                // USE THE KEYS FROM THE PRODUCER: "deviceId" and "maxConsumption"
                device.setId(UUID.fromString(message.get("deviceId").toString()));
                device.setMaxHourlyEnergyConsumption(
                        Double.parseDouble(message.get("maxConsumption").toString())
                );

                deviceRepo.save(device);
                System.out.println("Synchronized new device: " + device.getId());
            }
        } catch (Exception e) {
            System.err.println("Sync Error: " + e.getMessage());
        }
    }
}