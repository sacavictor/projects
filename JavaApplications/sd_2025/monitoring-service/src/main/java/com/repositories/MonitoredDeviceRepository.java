package com.repositories;

import com.entities.MonitoredDevice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface MonitoredDeviceRepository extends JpaRepository<MonitoredDevice, UUID> {
}
