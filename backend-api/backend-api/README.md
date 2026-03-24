# Hobby Circles - Backend API Documentation

**Version:** 1.0  
**Last Updated:** March 24, 2026  
**Base URL:** `http://localhost:8080/api`

---

## Table of Contents

1. [Overview](#1-overview)
2. [User Roles](#2-user-roles)
3. [UML Class Diagram](#3-uml-class-diagram)
4. [API Endpoints](#4-api-endpoints)
   - [Hobbyist Management](#hobbyist-management)
   - [Circle Management](#circle-management)
   - [Membership Management](#membership-management)
   - [Review Management](#review-management)
   - [System Admin Management](#system-admin-management)
   - [Audit Logs](#audit-logs)
5. [Use Case Mapping](#5-use-case-mapping)

---

## 1. Overview
The Hobby Circles Backend API provides a RESTful interface for managing: 

- **User Accounts**: Hobbyist, Circle Lead, and SysAdmin roles.
- **Hobby Circles**: Interest-based communities and group profiles.
- **Memberships**: Management of user enrollment in specific circles.
- **Reviews**: Community feedback on group activities and leadership.
- **Audit Logs**: Administrative tracking of moderation and system changes.

---

## 2. User Roles
The API supports three primary user roles:

| Role | Description | Primary Responsibilities |
|------|-------------|-------------------------|
| **HOBBYIST** | Community member | Browse circles, join groups, write reviews |
| **CIRCLE_LEAD** | Group organizer | Create/manage circles, update schedules, reply to reviews |
| **SYS_ADMIN** | Platform administrator | Manage access, moderate content, view system logs |

---

## 3. UML Class Diagram
![UML Class Diagram](./docs/uml-diagram.png)

---

## 4. API Endpoints
**Note:** Users are created through role-specific endpoints (`/hobbyists`, `/admins`), not through a generic `/users` endpoint. This ensures proper role assignment and role-specific attributes.

### Hobbyist Management

#### Create Hobbyist
**Endpoint:** `POST /hobbyists`  
**Use Case:** US-HOB-001 (Register as Hobbyist)  
**Description:** Create a new hobbyist account with profile information.

```http
POST /hobbyists
Content-Type: application/json

{
  "email": "student@uncg.edu",
  "passwordHash": "hashed_password",
  "status": "ACTIVE",
  "role": "HOBBYIST",
  "name": "Alex Smith",
  "interests": ["Coding", "Hiking"]
}

Response:

{
  "userId": 1,
  "email": "student@uncg.edu",
  "status": "ACTIVE",
  "role": "HOBBYIST",
  "name": "Alex Smith",
  "memberships": [],
  "createdAt": "2026-03-24T10:30:00",
  "updatedAt": "2026-03-24T10:30:00"
}

Status Code: 201 Created

Get Hobbyist by ID
Endpoint: GET /hobbyists/{id}

Use Case: Profile view

Description: Retrieve specific hobbyist by ID.

GET /hobbyists/1

Status Code: 200 OK or 404 Not Found
Circle Management
Create Circle
Endpoint: POST /circles

Use Case: US-LEAD-001 (Create Hobby Circle)

Description: Create a new interest group.

POST /circles
Content-Type: application/json

{
  "lead": { "userId": 2 },
  "name": "Greensboro Java Devs",
  "category": "Technology",
  "location": "Greensboro, NC",
  "description": "A circle for local students to practice backend development."
}

Response:

{
  "circleId": 10,
  "name": "Greensboro Java Devs",
  "category": "Technology",
  "status": "ACTIVE",
  "createdAt": "2026-03-24T11:00:00"
}

Status Code: 201 Created

Get All Circles
Endpoint: GET /circles

Use Case: US-HOB-002 (Browse Hobby Circles)

Description: Retrieve all interest groups.

Query Parameters:

category (Optional): Filter by hobby category

location (Optional): Filter by city

GET /circles?category=Technology

Status Code: 200 OK

Membership Management
Join a Circle
Endpoint: POST /memberships

Use Case: US-HOB-003 (Join Circle)

Description: Enroll a hobbyist into a specific circle.
POST /memberships
Content-Type: application/json

{
  "hobbyist": { "userId": 1 },
  "circle": { "circleId": 10 },
  "joinDate": "2026-03-24",
  "status": "ACTIVE"
}

Status Code: 201 Created

Review Management
Create Review
Endpoint: POST /reviews

Use Case: US-HOB-004 (Write a Review)

Description: Submit a rating and comment for a circle participation.

POST /reviews
Content-Type: application/json

{
  "membership": { "membershipId": 101 },
  "rating": 5,
  "comment": "Incredible group! Very helpful for my course projects."
}

Status Code: 201 Created

Audit Logs
Create Audit Log
Endpoint: POST /audit-logs

Use Case: US-ADMIN-001 (Log Administrative Actions)

Description: Log a moderation action (usually automated).

POST /audit-logs
Content-Type: application/json

{
  "admin": { "userId": 3 },
  "action": "SUSPENDED_CIRCLE",
  "entityType": "CIRCLE",
  "entityId": 12,
  "reason": "Inappropriate content"
}

Status Code: 201 Created

### 5. Use Case Mapping

The Hobby Circles API is designed to support the following SRS use cases for Hobbyists, Circle Leads, and System Administrators.

#### Hobbyist Use Cases
| Use Case | Description | Related Endpoints |
|:---|:---|:---|
| **US-HOB-001** | Register & manage hobbyist profile | `POST /hobbyists`, `PUT /hobbyists/{id}` |
| **US-HOB-002** | Browse & discover hobby circles | `GET /circles`, `GET /circles/{id}`, `GET /circles/search` |
| **US-HOB-003** | Join a specific hobby circle | `POST /memberships` |
| **US-HOB-004** | Manage active memberships (leave/pause) | `PUT /memberships/{id}`, `DELETE /memberships/{id}` |
| **US-HOB-005** | Write a review for a circle | `POST /reviews` |
| **US-HOB-006** | Read reviews from other members | `GET /reviews`, `GET /reviews/circle/{circleId}` |

#### Circle Lead Use Cases
| Use Case | Description | Related Endpoints |
|:---|:---|:---|
| **US-LEAD-001** | Register & manage circle lead profile | `POST /hobbyists` (with LEAD role) |
| **US-LEAD-002** | Create a new hobby circle offering | `POST /circles` |
| **US-LEAD-003** | Update circle details & meeting schedules | `PUT /circles/{id}` |
| **US-LEAD-004** | View member engagement metrics | `GET /memberships/circle/{circleId}` |
| **US-LEAD-005** | Reply to hobbyist reviews | `PUT /reviews/{id}` |

#### SysAdmin Use Cases
| Use Case | Description | Related Endpoints |
|:---|:---|:---|
| **US-ADMIN-001** | Manage user access (warn/suspend/ban) | `PUT /hobbyists/{id}`, `POST /audit-logs` |
| **US-ADMIN-002** | Moderate hobby circles (suspend/remove) | `PUT /circles/{id}`, `POST /audit-logs` |
| **US-ADMIN-003** | Moderate community reviews | `DELETE /reviews/{id}`, `POST /audit-logs` |
| **US-ADMIN-004** | View platform usage & activity logs | `GET /audit-logs`, `GET /audit-logs/entity-type/{type}` |