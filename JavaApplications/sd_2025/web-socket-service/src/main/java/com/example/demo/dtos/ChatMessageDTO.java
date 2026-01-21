package com.example.demo.dtos;

public class ChatMessageDTO {
    private String senderId;
    private String content;

    // Getters, Setters, Constructors
    public ChatMessageDTO(String senderId, String content) {
        this.senderId = senderId;
        this.content = content;
    }

    public ChatMessageDTO() {}

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
