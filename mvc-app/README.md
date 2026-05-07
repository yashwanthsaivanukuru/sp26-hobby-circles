# HobbyCircles — MVC App

This is the main runnable Spring Boot application for the HobbyCircles demo. It serves both the Provider and Hobbyist interfaces through a single unified app on port 8080.

---

## Architecture

The app follows the standard Spring Boot MVC pattern:

- **Controllers** handle HTTP requests and return FreeMarker template names or redirects
- **Services** contain business logic and call repositories
- **Repositories** are Spring Data JPA interfaces that query the Neon PostgreSQL database
- **Entities** are JPA-annotated classes that map to database tables
- **Templates** are `.ftlh` FreeMarker files that render the HTML views

---

## Use Case to MVC Implementation Mapping

### Authentication (Both Roles)

| Use Case | Controller | Method | Template |
|----------|------------|--------|----------|
| Show login/register page | `AuthMvcController` | `GET /` | `login.ftlh` |
| Login as Provider | `AuthMvcController` | `POST /auth/login` | redirects to `/providers/{id}` |
| Login as Hobbyist | `AuthMvcController` | `POST /auth/login` | redirects to `/search` |
| Register new account | `AuthMvcController` | `POST /auth/register` | redirects by role |
| Logout | `AuthMvcController` | `GET /auth/logout` | redirects to `/` |

---

### Provider Use Cases (Pranav)

| Use Case | Controller | Method | Template |
|----------|------------|--------|----------|
| US-PROV-001: View provider dashboard | `ProviderMvcController` | `GET /providers/{id}` | `provider-dashboard.ftlh` |
| US-PROV-002: Create / edit circle | `ProviderMvcController` | `GET /providers/{id}/circle` | `provider-circle-form.ftlh` |
| US-PROV-002: Save circle | `ProviderMvcController` | `POST /providers/{id}/circle` | redirects to dashboard |
| US-PROV-003: Show schedule event form | `ProviderMvcController` | `GET /providers/{id}/events/new` | `provider-event-form.ftlh` |
| US-PROV-003: Save event | `ProviderMvcController` | `POST /providers/{id}/events` | redirects to events list |
| US-PROV-003: View events list | `ProviderMvcController` | `GET /providers/{id}/events` | `provider-events.ftlh` |
| US-PROV-004: View member statistics | `ProviderMvcController` | `GET /providers/{id}/statistics` | `provider-statistics.ftlh` |
| US-PROV-005: View reviews | `ProviderMvcController` | `GET /providers/{id}/reviews` | `provider-reviews.ftlh` |
| US-PROV-005: Reply to review | `ProviderMvcController` | `POST /providers/{id}/reviews/{reviewId}/reply` | redirects to reviews |

---

### Hobbyist Use Cases (Yash)

| Use Case | Controller | Method | Template |
|----------|------------|--------|----------|
| US-CUST-002: Browse all circles | `HobbyMvcController` | `GET /search` | `circle-list.ftlh` |
| US-CUST-002: Search circles by name/city/category | `HobbyMvcController` | `GET /search?query=...` | `circle-list.ftlh` |
| US-CUST-003: Show join circle form | `HobbyMvcController` | `GET /join/{id}` | `join-form.ftlh` |
| US-CUST-003: Submit join form | `HobbyMvcController` | `POST /join/submit` | `joined-circles.ftlh` |
| US-CUST-005: Show write review form | `HobbyMvcController` | `GET /review/{circleId}` | `write-review.ftlh` |
| US-CUST-005: Submit review | `HobbyMvcController` | `POST /review/submit` | redirects to `/search` |
| US-CUST-001: Edit hobbyist profile | `HobbyMvcController` | `GET /profile/edit/{id}` | `edit-profile.ftlh` |
| US-CUST-001: Save hobbyist profile | `HobbyMvcController` | `POST /profile/update` | redirects to `/search` |
| View hobbyist dashboard | `HobbyMvcController` | `GET /hobbyist/dashboard` | `hobbyist-dashboard.ftlh` |

---

## Database Tables Used

| Table | Entity Class | Used By |
|-------|-------------|---------|
| `users` | `User.java` | Auth — all login/register |
| `providers` | `Provider.java` | Provider dashboard, circle management |
| `circles` | `Circle.java` | Provider circle form, hobbyist search |
| `events` | `Event.java` | Provider event scheduling and listing |
| `reviews` | `Review.java` | Hobbyist review submission, provider replies |
| `memberships` | `Membership.java` | Hobbyist join circle |
| `registrations` | `Registration.java` | Hobbyist join form details (name, phone, reason) |
| `hobbyists` | `Hobbyist.java` | Hobbyist profile edit |

---

## How to Run

```bash
cd mvc-app/mvc-app
./mvnw spring-boot:run
```

Open: http://localhost:8080