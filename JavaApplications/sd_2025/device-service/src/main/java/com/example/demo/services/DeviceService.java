package com.example.demo.services;

import com.example.demo.dtos.DeviceDTO;
import com.example.demo.entities.Device;
import com.example.demo.handlers.exceptions.model.ResourceNotFoundException;
import com.example.demo.repositories.DeviceRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class DeviceService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DeviceService.class);
    private final DeviceRepository deviceRepository;
    private final RabbitTemplate rabbitTemplate;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    public DeviceService(DeviceRepository deviceRepository, RabbitTemplate rabbitTemplate) {
        this.deviceRepository = deviceRepository;
        this.rabbitTemplate = rabbitTemplate;
    }

    public Device assignClientToDevice(UUID deviceId, UUID userId, String authorizationHeader) {
        // 1. Find the device in our own DB
        Device device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new RuntimeException("Device not found"));

        HttpHeaders headers = new HttpHeaders();
        // Attach the Admin's credentials (Basic or Bearer)
        headers.set("Authorization", authorizationHeader);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // 2. Validate the User exists by calling the User Service
        // This is the "Request-Reply" part of the assignment
        try {
            String USER_SERVICE_URL = "http://person-service:8080/people/";
            restTemplate.exchange(USER_SERVICE_URL + userId, HttpMethod.GET, entity, Object.class);
        } catch (HttpClientErrorException.NotFound e) {
            throw new RuntimeException("User with ID " + userId + " does not exist.");
        }

        // 3. Link them locally
        device.setPersonId(userId);
        return deviceRepository.save(device);
    }

    public List<DeviceDTO> findDevices() {
        List<Device> deviceList = deviceRepository.findAll();
        return deviceList.stream()
                .map(DeviceDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public DeviceDTO findDeviceById(UUID id) {
        Optional<Device> deviceOptional = deviceRepository.findById(id);
        if (deviceOptional.isEmpty()) {
            LOGGER.error("Device with id {} was not found in db", id);
            throw new ResourceNotFoundException(Device.class.getSimpleName() + " with id: " + id);
        }
        return DeviceDTO.fromEntity(deviceOptional.get());
    }

    public UUID insert(DeviceDTO deviceDTO) {
        Device device = DeviceDTO.toEntity(deviceDTO);
        device = deviceRepository.save(device);

        Map<String, Object> msg = new HashMap<>();
        msg.put("event", "DEVICE_CREATED");
        msg.put("deviceId", device.getId());
        msg.put("maxConsumption", device.getMaxHourlyEnergyConsumption());
        msg.put("personId", device.getPersonId());

        rabbitTemplate.convertAndSend("","device-sync-queue", msg);
        LOGGER.debug("Device with id {} was inserted in db", device.getId());
        return device.getId();
    }

    public Device delete(UUID id) {
        Optional<Device> deviceOptional = deviceRepository.findById(id);
        if (!deviceOptional.isPresent()) {
            LOGGER.error("Device with id {} was not found in db", id);
            throw new ResourceNotFoundException(Device.class.getSimpleName() + " with id: " + id);
        }
        Device device = deviceOptional.get();
        deviceRepository.delete(device);
        LOGGER.debug("Device with id {} was deleted from db", id);
        return device;
    }

    public Device update(DeviceDTO deviceDTO) {
        Optional<Device> deviceOptional = deviceRepository.findById(deviceDTO.getId());
        if (!deviceOptional.isPresent()) {
            LOGGER.error("Device with id {} was not found in db", deviceDTO.getId());
            throw new ResourceNotFoundException(Device.class.getSimpleName() + " with id: " + deviceDTO.getId());
        }

        Device deviceToUpdate = deviceOptional.get();
        deviceToUpdate.setModel(deviceDTO.getModel());
        deviceToUpdate.setManufacturer(deviceDTO.getManufacturer());
        deviceToUpdate.setPersonId(deviceDTO.getPersonId());

        deviceToUpdate = deviceRepository.save(deviceToUpdate);

        LOGGER.debug("Device with id {} was updated in db", deviceToUpdate.getId());
        return deviceToUpdate;
    }
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

}
