package com.example.demo.services;

import com.example.demo.dtos.ChatMessageDTO;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
public class RabbitListenerService {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @RabbitListener(queues = "notification.queue")
    public void handleNotification(String message) {
        System.out.println("Pushing alert to websocket: " + message);
        messagingTemplate.convertAndSend("/topic/alerts", message);
    }

    @RabbitListener(queues = "chat.reply.queue")
    public void handleChatReply(ChatMessageDTO message) {
        messagingTemplate.convertAndSend("/topic/chat", message);
    }
}