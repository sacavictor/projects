package com.example.demo.config;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.support.converter.JacksonJsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {

    @Bean
    public Queue notificationQueue() {
        // This tells RabbitMQ: "Create a queue named 'notification.queue' if it doesn't exist"
        // true = durable (survives RabbitMQ restart)
        return new Queue("notification.queue", true);
    }

    // You likely need this for the chat reply queue as well
    @Bean
    public Queue chatReplyQueue() {
        return new Queue("chat.reply.queue", true);
    }

    @Bean
    public JacksonJsonMessageConverter jsonMessageConverter() {
        return new JacksonJsonMessageConverter();
    }
}