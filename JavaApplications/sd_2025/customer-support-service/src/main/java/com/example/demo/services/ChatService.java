package com.example.demo.services;

import com.example.demo.dtos.ChatMessageDTO;
import com.example.demo.config.RabbitConfig; // Ensure you import your config
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


@Service
public class ChatService {

    @Autowired
    private RabbitTemplate rabbitTemplate;
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public void processMessage(ChatMessageDTO userMessage) {
        String replyContent;
        String text = userMessage.getContent().toLowerCase();

        if (text.contains("login") || text.contains("password")) {
            replyContent = "To reset your password, please contact not_a_scam@truthful.cg.";
        } else if (text.contains("hello") || text.contains("hi")) {
            replyContent = "Hello! How can I help you with your energy account today?";
        }else if (text.contains("consumption") && (text.contains("doesn't work")) || text.contains("not working")) {
            replyContent = "To report a problem about the viewing of your consumption data, please email not_a_scam@truthful.cg.";
        }else if (text.contains("consumption") && text.contains("view")) {
            replyContent = "To view your energy consumption data, please log in to your account dashboard and navigate to the device you want to monitor, then press 'View Energy'.";
        }else if (text.contains("add") && text.contains("device")) {
            replyContent = "To add a device to your account, please log in to your dashboard, go to 'Devices', and click on 'Add Device'. Follow the prompts to complete the setup.";
        }else if (text.contains("device")) {
            replyContent = "If there are problems with your device, please ensure it is properly connected to the network and powered on. For further assistance, contact not_a_scam@truthful.cg";
        }else if (text.contains("person") && text.contains("add")) {
            replyContent = "To add a person to your account, please log in to your dashboard, go to 'Add person' and follow the prompts.";
        }else if(text.contains("person")) {
            replyContent = "If there are issues regarding account persons, please ensure the email addresses are correct. For further assistance, contact not_a_scam@truthful.cg";
        }else if (text.contains("limit")) {
            replyContent = "To change your energy consumption limits, please log in to your dashboard, and re-enter the desired limits under the 'Device Settings' section.";
        }else if (text.contains("admin")) {
            replyContent = callLLMApi(userMessage.getContent());
        }
        else {
            replyContent = callLLMApi(userMessage.getContent());
        }

        ChatMessageDTO response = new ChatMessageDTO("System", replyContent);

        rabbitTemplate.convertAndSend("", "chat.reply.queue", response);
    }

    @Value("${spring.ai.google.genai.api-key}")
    private String apiKey;

    private String callLLMApi(String prompt) {
        try {
            // 1. Create the Root Object
            ObjectNode requestBody = objectMapper.createObjectNode();

            // 2. Create "contents" (Replaces "messages")
            ArrayNode contents = requestBody.putArray("contents");
            ObjectNode userTurn = contents.addObject();
            userTurn.put("role", "user");
            ArrayNode parts = userTurn.putArray("parts");
            parts.addObject().put("text", prompt);

            // 3. Create "generationConfig" (Replaces top-level "max_tokens", etc.)
            ObjectNode generationConfig = requestBody.putObject("generationConfig");
            generationConfig.put("maxOutputTokens", 500); // Note the name change
            generationConfig.put("temperature", 0.7);

            // 4. Build the URL with the API Key
            String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey;

            // 5. Send the Request
            // Note: No need for Bearer Auth header if key is in URL
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entity = new HttpEntity<>(requestBody.toString(), headers);

            ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

            // 6. Parse the Native Response
            JsonNode responseJson = objectMapper.readTree(response.getBody());
            return responseJson.get("candidates").get(0).get("content").get("parts").get(0).get("text").asText();

        } catch (Exception e) {
            e.printStackTrace();
            return "I'm having trouble connecting to the Gemini service right now.";
        }
    }
}