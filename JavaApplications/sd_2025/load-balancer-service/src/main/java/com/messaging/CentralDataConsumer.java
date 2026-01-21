package com.messaging;

import com.dtos.SensorRecordDTO;
import com.services.LoadBalancerService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

@Component
public class CentralDataConsumer {

    @Autowired
    private LoadBalancerService loadBalancerService;

   /* @RabbitListener(queues = "sensor.queue")
    public void consumeFromCentralQueue(String messageJson) {
        try {

            // Now pass the object to the service
            loadBalancerService.routeMessage(messageJson);

        } catch (Exception e) {
            System.err.println("Failed to parse JSON: " + e.getMessage());
        }
    }*/
}