package com.example.demo.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.FanoutExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.support.converter.JacksonJsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {
    @Bean
    public Queue deviceSyncQueue() {
        return new Queue("device-sync-queue", true); // Durable queue
    }
    @Bean
    public FanoutExchange exchange() {
        return new FanoutExchange("internal.exchange");
    }
    @Bean
    public Queue personQueue() {
        return new Queue("sync-person-queue", true); // Durable queue
    }
    @Bean
    public Binding binding(Queue deviceSyncQueue, FanoutExchange exchange) {
        return BindingBuilder.bind(deviceSyncQueue).to(exchange);
    }
    @Bean
    public MessageConverter jsonMessageConverter() {
        return new JacksonJsonMessageConverter();
    }
}
