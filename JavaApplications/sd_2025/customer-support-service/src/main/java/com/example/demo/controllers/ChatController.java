package com.example.demo.controllers;

import com.example.demo.dtos.ChatMessageDTO;
import com.example.demo.services.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/chat")
//@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ChatController {
    @Autowired
    private ChatService chatService;

    // React calls this: POST /chat/send
    @PostMapping("/send")
    public ResponseEntity<String> sendMessage(@RequestBody ChatMessageDTO message) {
        chatService.processMessage(message);
        return ResponseEntity.ok("Message processed");
    }
}