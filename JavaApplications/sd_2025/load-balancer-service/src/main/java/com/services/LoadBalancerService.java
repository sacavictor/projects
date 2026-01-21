package com.services;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.dtos.SensorRecordDTO;
import tools.jackson.databind.ObjectMapper;

@Service
public class LoadBalancerService {
    @Value("${TOTAL_REPLICAS:1}")
    private int totalReplicas;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void routeMessage(String messageJson) {
        // Use Jackson to convert String -> Object

        ObjectMapper mapper = new ObjectMapper();
        SensorRecordDTO data = mapper.readValue(messageJson, SensorRecordDTO.class);

        int targetSlot = (Math.abs(data.getDeviceId().hashCode()) % totalReplicas) + 1;
        String targetQueue = "ingest.queue." + targetSlot;

        rabbitTemplate.convertAndSend(targetQueue, data);
        System.out.println("Routed Device " + data.getDeviceId() + " to " + targetQueue);
    }
}