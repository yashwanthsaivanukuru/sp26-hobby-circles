# HobbyCircles

**Team:** Pranav Bellie (Provider) · Yashwanth Vanukuru (Customer)  
**Course:** CSC 340 — Spring 2026  
**Repo:** https://github.com/yashwanthsaivanukuru/sp26-hobby-circles  
**Demo Branch:** main

---

## Project Summary

HobbyCircles is a web-based community platform that helps people discover and join hobby-based social groups in their city. The problem it solves is simple: finding specific local communities is currently scattered across dozens of social media platforms with no single structured hub. HobbyCircles fixes this by giving hobbyists one place to browse Circles, join groups, attend meetups, and leave reviews — and giving group leaders (Providers) a dedicated dashboard to create and manage their communities.

The system is implemented as a **Spring Boot MVC application** backed by a shared **PostgreSQL database hosted on Neon**. There is one combined app that serves both user roles through a single login/register entry point. Providers are routed to their dashboard after login; Hobbyists are routed to the circle explorer.

---

## How the Project is Compartmentalized

The repo is organized into three main areas:

```
sp26-hobby-circles/
├── mvc-app/mvc-app/          ← The main runnable Spring Boot app (run this for the demo)
│   ├── controller/           ← MVC controllers for both Provider and Hobbyist flows
│   ├── entity/               ← JPA entities mapping to the shared Neon PostgreSQL database
│   ├── repository/           ← Spring Data repositories
│   ├── service/              ← Business logic layer
│   └── resources/templates/  ← FreeMarker templates for all views
│
├── backend-api/              ← Yash's original REST API (reference only, not used for demo)
│
└── docs/                     ← SRS, UML diagram, test plan
```

**Pranav built:** the Provider side — `ProviderMvcController`, all entity/service/repository classes, REST controllers, and provider-facing templates (dashboard, circle form, event form, reviews, statistics).

**Yash built:** the Hobbyist side — `HobbyMvcController`, circle search/browse, join form, review submission, hobbyist dashboard, and related templates.

**Integrated together:** `AuthMvcController` (login/register), `UserRepository`, `MembershipRepository`, and `login.ftlh` tie both sides into one app using a shared session and shared database.

---

## How to Run the Project

### Prerequisites
- Java 17+
- Maven (or use the included `mvnw` wrapper)
- Internet connection (required for Neon PostgreSQL)

### Steps

```bash
# Clone the repo
git clone https://github.com/yashwanthsaivanukuru/sp26-hobby-circles.git
cd sp26-hobby-circles/mvc-app/mvc-app

# Run the app
./mvnw spring-boot:run
```

Open your browser to: **http://localhost:8080**

### Demo Login Credentials

| Role | Email | Password |
|------|-------|----------|
| Provider | pranav@hobbycircles.com | (see password_hash in Neon users table) |
| Hobbyist | yash@hobbycircles.com | demo123 |

---

## Key Routes

| Route | Description |
|-------|-------------|
| `GET /` | Login / Register page |
| `POST /auth/login` | Authenticate user, route by role |
| `POST /auth/register` | Create new account |
| `GET /search` | Browse and search all circles (Hobbyist) |
| `GET /join/{id}` | Join circle form |
| `GET /review/{circleId}` | Write a review |
| `GET /providers/{id}` | Provider dashboard |
| `GET /providers/{id}/circle` | Create / edit circle |
| `GET /providers/{id}/events/new` | Schedule a meetup |
| `GET /providers/{id}/reviews` | View and reply to reviews |
| `GET /providers/{id}/statistics` | View member statistics |