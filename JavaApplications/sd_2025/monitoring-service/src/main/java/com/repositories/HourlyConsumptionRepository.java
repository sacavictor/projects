package com.repositories;

import com.entities.HourlyConsumption;
import org.hibernate.annotations.processing.SQL;
import org.jspecify.annotations.Nullable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface HourlyConsumptionRepository extends JpaRepository<HourlyConsumption, Long> {

    HourlyConsumption findByTimestamp(Long timestamp);

    //@SQL("SELECT hc FROM HourlyConsumption hc WHERE hc.deviceId = ?1 AND hc.timestamp = ?2")
    @Nullable HourlyConsumption findByDeviceIdAndTimestamp(UUID deviceId, Long timestamp);

    @Nullable List<HourlyConsumption> findByDeviceId(UUID deviceId);

    List<HourlyConsumption> findAllByDeviceIdAndTimestampBetween(UUID deviceId, long startOfDay, long endOfDay);
}
