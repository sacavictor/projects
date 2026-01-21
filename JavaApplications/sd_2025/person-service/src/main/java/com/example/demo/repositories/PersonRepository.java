package com.example.demo.repositories;

import com.example.demo.entities.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@EnableJpaRepositories("com.example.demo.repositories")
@Repository
public interface PersonRepository extends JpaRepository<Person, UUID> {


    Person findByName(String name);

    @Query(value = "SELECT p " +
            "FROM Person p " +
            "WHERE p.name = :name ")
    Optional<Person> findSeniorsByName(@Param("name") String name);

}
