package com.example.demo.controllers;

import com.example.demo.dtos.DeviceDTO;
import com.example.demo.dtos.PersonDTO;
import com.example.demo.dtos.PersonDetailsDTO;
import com.example.demo.entities.Person;
import com.example.demo.services.PersonService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/people")
@Validated
public class PersonController {

    private final PersonService personService;

    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<PersonDetailsDTO> getPerson(@PathVariable UUID id) {
        return ResponseEntity.ok(personService.findPersonById(id));
    }

    @GetMapping
    public ResponseEntity<List<PersonDTO>> getPeople() {
        return ResponseEntity.ok(personService.findPersons());
    }

    @PostMapping
    public ResponseEntity<UUID> create(@Valid @RequestBody PersonDetailsDTO person) {
        UUID id = personService.insert(person);
        URI location = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(id)
                .toUri();
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .contentType(MediaType.APPLICATION_JSON)
                .body(id); // 201 + Location header
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {

        // 1. Delete person from People microservice
        personService.delete(id);

        return ResponseEntity.noContent().build();
    }

}
