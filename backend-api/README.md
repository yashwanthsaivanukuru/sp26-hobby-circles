This is the README file for the backend API. Use this file to provide information about the API, its setup, and usage instructions.

# HobbyCircles - Backend API Documentation

**Version:** 1.0  
**Last Updated:** March 23, 2026  
**Base URL:** `http://localhost:8080/api`

---

## Table of Contents

1. [Overview](#1-overview)
2. [User Roles](#2-user-roles)
3. [UML Class Diagram](#3-uml-class-diagram)
4. [API Endpoints](#4-api-endpoints)
   - [Provider Management](#provider-management)
   - [Circle Management](#circle-management)
   - [Event Management](#event-management)
   - [Review Management](#review-management)
5. [Use Case Mapping](#5-use-case-mapping)

---

## 1. Overview
The HobbyCircles Backend API provides a RESTful interface for managing:

- **User Accounts**: Hobbyist and Provider roles
- **Circles**: Hobby group profiles created and managed by providers
- **Events**: Meetups and activities posted within circles
- **Reviews**: Hobbyist feedback on circles with provider reply support

---

## 2. User Roles

| Role | Description | Primary Responsibilities |
|------|-------------|-------------------------|
| **HOBBYIST** | Consumer of hobby circles | Browse circles, join groups, RSVP events, write reviews |
| **PROVIDER** | Creator of hobby circles | Create/manage circles, post events, view members, reply to reviews |

---

## 3. UML Class Diagram
![UML Class Diagram](../docs/uml-class.png)
---

## 4. API Endpoints

### Provider Management

#### Create Provider
**Endpoint:** `POST /api/providers`  
**Use Case:** Create provider profile  
```http
POST /api/providers
Content-Type: application/json

{
  "email": "pranav@hobbycircles.com",
  "passwordHash": "password123",
  "status": "ACTIVE",
  "role": "PROVIDER",
  "bio": "I love organizing hiking groups!"
}
```

**Response:**
```json
{
  "userId": 1,
  "email": "pranav@hobbycircles.com",
  "status": "ACTIVE",
  "role": "PROVIDER",
  "bio": "I love organizing hiking groups!",
  "createdAt": "2026-03-23T16:49:14.912225",
  "updatedAt": "2026-03-23T16:49:14.912225"
}
```
**Status Code:** `201 Created`

---

#### Get All Providers
**Endpoint:** `GET /api/providers`  
```http
GET /api/providers
```
**Status Code:** `200 OK`

---

#### Get Provider by ID
**Endpoint:** `GET /api/providers/{id}`  
```http
GET /api/providers/1
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Provider by Email
**Endpoint:** `GET /api/providers/email/{email}`  
```http
GET /api/providers/email/pranav@hobbycircles.com
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Update Provider
**Endpoint:** `PUT /api/providers/{id}`  
**Use Case:** Modify provider profile  
```http
PUT /api/providers/1
Content-Type: application/json

{
  "bio": "Organizer of outdoor adventure groups!",
  "status": "ACTIVE"
}
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Provider
**Endpoint:** `DELETE /api/providers/{id}`  
```http
DELETE /api/providers/1
```
**Status Code:** `204 No Content`

---

### Circle Management

#### Create Circle
**Endpoint:** `POST /api/circles`  
**Use Case:** Create a new hobby circle  
```http
POST /api/circles
Content-Type: application/json

{
  "name": "Austin Hikers",
  "city": "Austin",
  "description": "A group for people who love hiking around Austin!",
  "category": "Outdoors",
  "provider": {
    "userId": 1
  }
}
```

**Response:**
```json
{
  "circleId": 1,
  "name": "Austin Hikers",
  "city": "Austin",
  "description": "A group for people who love hiking around Austin!",
  "category": "Outdoors",
  "provider": { "userId": 1 },
  "createdAt": "2026-03-23T17:03:34.264248",
  "updatedAt": "2026-03-23T17:03:34.264248"
}
```
**Status Code:** `201 Created`

---

#### Get All Circles
**Endpoint:** `GET /api/circles`  
```http
GET /api/circles
```
**Status Code:** `200 OK`

---

#### Get Circle by ID
**Endpoint:** `GET /api/circles/{id}`  
```http
GET /api/circles/1
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Circle by Provider
**Endpoint:** `GET /api/circles/provider/{providerId}`  
**Use Case:** View customer statistics — see your own circle  
```http
GET /api/circles/provider/1
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Circles by City
**Endpoint:** `GET /api/circles/city/{city}`  
```http
GET /api/circles/city/Austin
```
**Status Code:** `200 OK`

---

#### Get Circles by Category
**Endpoint:** `GET /api/circles/category/{category}`  
```http
GET /api/circles/category/Outdoors
```
**Status Code:** `200 OK`

---

#### Update Circle
**Endpoint:** `PUT /api/circles/{id}`  
**Use Case:** Modify circle details  
```http
PUT /api/circles/1
Content-Type: application/json

{
  "name": "Austin Hikers Club",
  "city": "Austin",
  "description": "The best hiking group in Austin!",
  "category": "Outdoors"
}
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Circle
**Endpoint:** `DELETE /api/circles/{id}`  
```http
DELETE /api/circles/1
```
**Status Code:** `204 No Content`

---

### Event Management

#### Create Event
**Endpoint:** `POST /api/events`  
**Use Case:** Create a new meetup/event  
```http
POST /api/events
Content-Type: application/json

{
  "title": "Saturday Morning Hike",
  "description": "Meet at the trailhead for a 5 mile hike!",
  "location": "Barton Creek Greenbelt, Austin",
  "eventDate": "2026-04-05T09:00:00",
  "status": "UPCOMING",
  "circle": {
    "circleId": 1
  }
}
```

**Response:**
```json
{
  "eventId": 1,
  "title": "Saturday Morning Hike",
  "location": "Barton Creek Greenbelt, Austin",
  "eventDate": "2026-04-05T09:00:00",
  "status": "UPCOMING",
  "createdAt": "2026-03-23T17:10:33.728581",
  "updatedAt": "2026-03-23T17:10:33.728581"
}
```
**Status Code:** `201 Created`

---

#### Get All Events
**Endpoint:** `GET /api/events`  
```http
GET /api/events
```
**Status Code:** `200 OK`

---

#### Get Event by ID
**Endpoint:** `GET /api/events/{id}`  
```http
GET /api/events/1
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Get Events by Circle
**Endpoint:** `GET /api/events/circle/{circleId}`  
**Use Case:** View all events for a circle  
```http
GET /api/events/circle/1
```
**Status Code:** `200 OK`

---

#### Update Event
**Endpoint:** `PUT /api/events/{id}`  
```http
PUT /api/events/1
Content-Type: application/json

{
  "title": "Sunday Morning Hike",
  "location": "Barton Creek Greenbelt, Austin",
  "eventDate": "2026-04-06T09:00:00",
  "status": "UPCOMING"
}
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Event
**Endpoint:** `DELETE /api/events/{id}`  
```http
DELETE /api/events/1
```
**Status Code:** `204 No Content`

---

### Review Management

#### Create Review
**Endpoint:** `POST /api/reviews`  
**Use Case:** Hobbyist writes a review  
```http
POST /api/reviews
Content-Type: application/json

{
  "rating": 5,
  "comment": "Amazing group, super welcoming and well organized!",
  "membership": {
    "membershipId": 1
  }
}
```
**Status Code:** `201 Created`

---

#### Get All Reviews
**Endpoint:** `GET /api/reviews`  
```http
GET /api/reviews
```
**Status Code:** `200 OK`

---

#### Get Reviews by Circle
**Endpoint:** `GET /api/reviews/circle/{circleId}`  
**Use Case:** Provider views reviews for their circle  
```http
GET /api/reviews/circle/1
```
**Status Code:** `200 OK`

---

#### Reply to / Update Review
**Endpoint:** `PUT /api/reviews/{id}`  
**Use Case:** Provider replies to a review  
```http
PUT /api/reviews/1
Content-Type: application/json

{
  "replyText": "Thank you so much, hope to see you on the next hike!"
}
```
**Status Code:** `200 OK` or `404 Not Found`

---

#### Delete Review
**Endpoint:** `DELETE /api/reviews/{id}`  
```http
DELETE /api/reviews/1
```
**Status Code:** `204 No Content`

---

## 5. Use Case Mapping

### Provider Use Cases

| Use Case        | Description               | Related Endpoints         |
|-----------------|-------------              |-------------------|
| **US-PROV-001** | Create provider profile   | `POST /api/providers` |
| **US-PROV-002** | Modify provider profile   | `PUT /api/providers/{id}` |
| **US-PROV-003** | Create a circle           | `POST /api/circles` |
| **US-PROV-004** | Update circle details     | `PUT /api/circles/{id}` |
| **US-PROV-005** | Remove a circle           | `DELETE /api/circles/{id}` |
| **US-PROV-006** | Create an event/meetup    | `POST /api/events` |
| **US-PROV-007** | Update an event           | `PUT /api/events/{id}` |
| **US-PROV-008** | View circle members/stats | `GET /api/circles/provider/{providerId}` |
| **US-PROV-009** | View reviews for circle   | `GET /api/reviews/circle/{circleId}` |
| **US-PROV-010** | Reply to a review         | `PUT /api/reviews/{id}` |