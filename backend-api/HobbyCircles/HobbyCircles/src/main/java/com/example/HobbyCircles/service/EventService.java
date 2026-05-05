package com.example.HobbyCircles.service;

import com.example.HobbyCircles.entity.Event;
import com.example.HobbyCircles.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    public Event createEvent(Event event) {
        return eventRepository.save(event);
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public Optional<Event> getEventById(Long id) {
        return eventRepository.findById(id);
    }

    public List<Event> getEventsByCircleId(Long circleId) {
        return eventRepository.findByCircleId(circleId);
    }

    public Event updateEvent(Long id, Event eventDetails) {
        return eventRepository.findById(id).map(event -> {
            if (eventDetails.getTitle() != null)
                event.setTitle(eventDetails.getTitle());
            if (eventDetails.getDescription() != null)
                event.setDescription(eventDetails.getDescription());
            if (eventDetails.getLocation() != null)
                event.setLocation(eventDetails.getLocation());
            if (eventDetails.getEventDate() != null)
                event.setEventDate(eventDetails.getEventDate());
            if (eventDetails.getStatus() != null)
                event.setStatus(eventDetails.getStatus());
            return eventRepository.save(event);
        }).orElseThrow(() -> new RuntimeException("Event not found"));
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }
}