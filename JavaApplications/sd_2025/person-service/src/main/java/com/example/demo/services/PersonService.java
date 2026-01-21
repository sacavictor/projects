package com.example.demo.services;


import com.example.demo.dtos.PersonDTO;
import com.example.demo.dtos.PersonDetailsDTO;
import com.example.demo.dtos.builders.PersonBuilder;
import com.example.demo.entities.Person;
import com.example.demo.handlers.exceptions.model.ResourceNotFoundException;
import com.example.demo.repositories.PersonRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.HttpClientErrorException;


import java.util.*;
import java.util.stream.Collectors;

@Service
public class PersonService {
    private static final Logger LOGGER = LoggerFactory.getLogger(PersonService.class);
    private final PersonRepository personRepository;
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    public PersonService(PersonRepository personRepository, RabbitTemplate rabbitTemplate) {
        this.personRepository = personRepository;
        this.rabbitTemplate = rabbitTemplate;
    }

    public List<PersonDTO> findPersons() {
        List<Person> personList = personRepository.findAll();
        return personList.stream()
                .map(PersonBuilder::toPersonDTO)
                .collect(Collectors.toList());
    }

    public PersonDetailsDTO findPersonById(UUID id) {
        Optional<Person> prosumerOptional = personRepository.findById(id);
        if (!prosumerOptional.isPresent()) {
            LOGGER.error("Person with id {} was not found in db", id);
            throw new ResourceNotFoundException(Person.class.getSimpleName() + " with id: " + id);
        }
        return PersonBuilder.toPersonDetailsDTO(prosumerOptional.get());
    }

    public UUID insert(PersonDetailsDTO personDTO) {
        Person person = PersonBuilder.toEntity(personDTO);
        person = personRepository.save(person);

        Map<String, Object> message = new HashMap<>();
        message.put("event", "PERSON_CREATED");
        message.put("personId", person.getId());

        rabbitTemplate.convertAndSend("person-exchange", "", message);
        LOGGER.debug("Person with id {} was inserted in db", person.getId());
        return person.getId();
    }

    public Person delete(UUID id) {
        Optional<Person> personOptional = personRepository.findById(id);
        if (!personOptional.isPresent()) {
            LOGGER.error("Person with id {} was not found in db", id);
            throw new ResourceNotFoundException(Person.class.getSimpleName() + " with id: " + id);
        }
        Person person = personOptional.get();
        personRepository.delete(person);
        LOGGER.debug("Person with id {} was deleted from db", id);
        return person;
    }


    public Person update(PersonDTO personDTO) {
        Optional<Person> personOptional = personRepository.findById(personDTO.getId());
        if (!personOptional.isPresent()) {
            LOGGER.error("Person with id {} was not found in db", personDTO.getId());
            throw new ResourceNotFoundException(Person.class.getSimpleName() + " with id: " + personDTO.getId());
        }
        Person personToUpdate = personOptional.get();
        personToUpdate.setName(personDTO.getName());
        personToUpdate.setAge(personDTO.getAge());
        personToUpdate = personRepository.save(personToUpdate);
        LOGGER.debug("Person with id {} was updated in db", personToUpdate.getId());
        return personToUpdate;
    }

}
