package com.example.demo.controllers;

import com.example.demo.dtos.DeviceDTO;
import com.example.demo.entities.Device;
import com.example.demo.services.DeviceService;
import jakarta.validation.Valid;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/devices")
@Validated
public class DeviceController {

    private final DeviceService deviceService;

    public DeviceController(DeviceService deviceService) {
        this.deviceService = deviceService;
    }

    // GET /devices
    @GetMapping
    public ResponseEntity<List<DeviceDTO>> getDevices() {
        return ResponseEntity.ok(deviceService.findDevices());
    }

    // POST /devices
    @PostMapping
    public ResponseEntity<Void> create(@Valid @RequestBody DeviceDTO device) {
        UUID id = deviceService.insert(device);

        URI location = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(id)
                .toUri();
        return ResponseEntity.created(location).build(); // 201 + Location header
    }

    // GET /devices/{id}
    @GetMapping("/{id}")
    public ResponseEntity<DeviceDTO> getDevice(@PathVariable UUID id) {
        return ResponseEntity.ok(deviceService.findDeviceById(id));
    }

    // This is called by the People microservice

    // DELETE /devices/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        deviceService.delete(id);
        return ResponseEntity.noContent().build(); // 204
    }

    @PatchMapping("/{deviceId}/assign/{userId}")
    public ResponseEntity<Device> assignDevice(@PathVariable UUID deviceId, @PathVariable UUID userId, @RequestHeader("Authorization") String authorizationHeader) {
        return ResponseEntity.ok(deviceService.assignClientToDevice(deviceId, userId, authorizationHeader));
    }
}
