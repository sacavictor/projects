import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.MessageProperties;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Simulator {
    private static final String QUEUE_NAME = "sensor.queue";

    public static void main(String[] args) throws Exception {
        System.out.println("Starting Device Simulator...");

        // 1. Read Device ID from config file
        String deviceId = loadConfig("config.properties");
        if (deviceId == null) {
            System.err.println("Error: Could not read deviceId from config.properties");
            return;
        }
        System.out.println("Simulating data for Device ID: " + deviceId);

        // 2. Connect to RabbitMQ
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5672); // Default port
        factory.setUsername("guest"); // Default
        factory.setPassword("guest"); // Default

        try (Connection connection = factory.newConnection();
             Channel channel = connection.createChannel()) {

            // Ensure the queue exists before sending
            channel.queueDeclare(QUEUE_NAME, true, false, false, null);

            // 3. Simulation Loop
            double currentValue = 100.0; // random base load 

            while (true) {
                long timestamp = System.currentTimeMillis();

                // Construct JSON Payload
                String json = String.format("{\"timestamp\": %d, \"device_id\": \"%s\", \"measurement_value\": %.2f}",
                        timestamp, deviceId, currentValue);

                // Publish Message
                channel.basicPublish("", QUEUE_NAME, MessageProperties.TEXT_PLAIN, json.getBytes());
                System.out.println(" [x] Sent '" + json + "'");

                // Sleep for 1 second (simulating 10 minutes)
                Thread.sleep(1000);

                // Adjust value to simulate realistic fluctuation [cite: 159]
                currentValue += (Math.random() - 0.5) * 5;

                // Optional: Ensure value doesn't drop below zero
                if (currentValue < 0) currentValue = 0;
            }
        }
    }

    private static String loadConfig(String fileName) {
        Properties prop = new Properties();
        try (InputStream input = new FileInputStream(fileName)) {
            prop.load(input);
            return prop.getProperty("deviceId");
        } catch (IOException ex) {
            System.out.println("Config file not found, please create 'config.properties'");
            return null;
        }
    }
}