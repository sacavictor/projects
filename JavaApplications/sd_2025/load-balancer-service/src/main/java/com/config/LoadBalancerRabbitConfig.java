package com.config;

import com.rabbitmq.client.ConnectionFactory;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class LoadBalancerRabbitConfig {

/*    public static final String SENSOR_QUEUE = "sensor.queue";

    @Bean
    public Queue sensorQueue() {
        // name, durable, exclusive, autoDelete
        return new Queue(SENSOR_QUEUE, true, false, false);
    }*/

    // This Bean tells Spring to automatically create the queues on the broker
}