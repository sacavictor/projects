package com.example.demo.messaging;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.UUID;

@Component
public class DeviceSyncListener {
    @RabbitListener(queues = "sync-person-queue")
    public void receiveMessage(Map<String, Object> message) {
        if ("PERSON_CREATED".equals(message.get("event"))) {
            UUID personId =  message.get("personId") != null ? UUID.fromString(message.get("personId").toString()) : null;
            // Store userId in a local "ValidUsers" table or generic logic
            System.out.println("Device Service synced user: " + personId);
        }
    }
}