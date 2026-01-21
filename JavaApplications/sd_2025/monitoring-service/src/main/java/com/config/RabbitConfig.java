package com.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.FanoutExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {

   // @Value("${replica.queue.name}")
    private String replicaQueueName = "sensor.queue";

    @Bean
    public Queue replicaIngestQueue() {
        // Each replica creates its own dedicated ingest queue
        return new Queue(replicaQueueName, true, false, false);
    }
    @Bean
    public Queue deviceSyncQueue() {
        return new Queue("device-sync-queue", true, false, false);
    }
}
