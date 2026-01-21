package com.messaging;

import com.dtos.SensorRecordDTO;
import com.services.MonitoringService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

@Component
public class SensorDataConsumer {

    @Autowired
    private MonitoringService monitoringService;

    @RabbitListener(queues = "sensor.queue")
    public void consumeSensorData(String messageJson) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            SensorRecordDTO data = mapper.readValue(messageJson, SensorRecordDTO.class);

            monitoringService.processMeasurement(data);

        } catch (Exception e) {
            System.err.println("Error processing message: " + e.getMessage());
        }
    }
}