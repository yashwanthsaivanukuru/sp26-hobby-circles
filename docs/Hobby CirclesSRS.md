# Requirements – HobbyCircles

**Project Name:** HobbyCircles  
**Team:** Pranav Bellie (Provider) · Yashwanth Vanukuru (Customer)  
**Course:** CSC 340 — Spring 2026  
**Version:** 1.1 (Final)  
**Date:** May 7, 2026  
**Purpose:** This SRS defines the scope and user-facing requirements of HobbyCircles and the user stories that guide development and testing.

---

## 1. Overview

HobbyCircles is a web-based community platform that helps individuals discover and join hobby-based social groups in a new city. Finding specific local communities is currently scattered across dozens of social media platforms with no single structured hub. HobbyCircles solves this by offering a single, structured web application where users can browse Circles, join communities, view meetup calendars, and leave reviews — while group leaders manage their pages and engage with members.

The system is implemented as a Spring Boot MVC application backed by a shared PostgreSQL database (Neon). A single combined app serves both user roles through one login/register entry point at `localhost:8080/`.

### Glossary

| Term | Definition |
|------|------------|
| Circle | A hobby-based community group created by a Provider |
| Hobbyist | A registered user who joins Circles and participates in events |
| Provider | A group creator/leader who manages a Circle |
| Meetup | A scheduled event organised by a Circle |
| Subscription / Membership | A Hobbyist joining a Circle; stored in the memberships table |
| Review | Feedback (rating + comment) left by a Hobbyist about a Circle |
| Registration | A Hobbyist's join-circle form submission stored in the registrations table |

### Primary Users / Roles

**Customer (Hobbyist)** — Discover Circles, join communities, attend meetups, and provide feedback.  
**Provider (Group Creator)** — Create and manage Circles, schedule meetups, and monitor participation.

### Scope (this semester)

- User registration and authentication (login/register page with role selection)
- Hobbyist profile creation and editing
- Circle creation and management by Providers
- Meetup scheduling and event listing
- Subscription / joining Circles
- Review system with provider responses
- Shared PostgreSQL database across both interfaces

### Out of Scope (deferred)

- Real-time chat or messaging system
- Mobile application
- Paid events or payment processing
- Advanced recommendation algorithms
- Full RSVP persistence (UI visible but not wired end-to-end)
- SysAdmin moderation interface

---

## 2. Functional Requirements

### 2.1 Customer (Hobbyist) Stories

---

**US-CUST-001 — Register & manage profile**

Story:  
As a hobbyist, I want to create and update my profile with personal interests and preferences so that I can discover relevant Circles.

Acceptance:

Scenario: Register via login page  
  Given I am a new user  
  When I open localhost:8080/, select "Join Circles", enter my email and password, and click Create Account  
  Then my account is saved with HOBBYIST role and I am redirected to the circle explorer at /search

Scenario: Edit profile  
  Given I am a registered hobbyist  
  When I navigate to /profile/edit/{id} and update my name or interests  
  Then the updated information is saved in the hobbyists table

---

**US-CUST-002 — Browse Circles**

Story:  
As a hobbyist, I want to browse available Circles by category and location so that I can find groups that match my interests.

Acceptance:

Scenario: View all circles  
  Given I am logged in as a Hobbyist  
  When I navigate to /search  
  Then I see a list of all Circles with name, description, city, and category

Scenario: Search circles  
  Given I am on the /search page  
  When I enter a keyword (name, city, or category) and click Search  
  Then only matching Circles are displayed

---

**US-CUST-003 — Subscribe to a Circle**

Story:  
As a hobbyist, I want to join a Circle so that I can access its meetup calendar and events.

Acceptance:

Scenario: Join Circle successfully  
  Given I am logged in and viewing the circle list  
  When I click "Join Circle", fill in the join form (name, email, phone, reason), and submit  
  Then a registration record is saved and I see a success confirmation page with a "Write a Review" button

---

**US-CUST-004 — RSVP to Meetup**

Story:  
As a hobbyist, I want to RSVP to upcoming meetups so that organizers know how many people will attend.

Acceptance:

Scenario: RSVP to event  
  Given I am a member of a Circle  
  When I select a meetup and click RSVP  
  Then my attendance is recorded and the attendee count increases

Note: RSVP UI is visible on the provider events view. Full hobbyist-side RSVP persistence is deferred to a future increment.

---

**US-CUST-005 — Write a review**

Story:  
As a hobbyist, I want to leave a review for a Circle I joined so that I can share my experience with others.

Acceptance:

Scenario: Submit review  
  Given I have joined a Circle  
  When I click "Write a Review" on the success page, select a star rating, enter a comment, and submit  
  Then the review is saved to the reviews table with the correct circle_id and hobbyist_id, and it appears on the Provider's reviews page

---

**US-CUST-006 — Read reviews**

Story:  
As a hobbyist, I want to read reviews from other members so that I can evaluate the quality of a Circle.

Acceptance:

Scenario: View reviews  
  Given reviews exist for a Circle  
  When I call GET /api/reviews/circle/{circleId} or the provider opens their reviews page  
  Then I see recent reviews with ratings and comments

---

### 2.2 Provider (Group Creator) Stories

---

**US-PROV-001 — Register & manage provider profile**

Story:  
As a provider, I want to create and update my profile so that users can learn about me and my Circle.

Acceptance:

Scenario: Register as Provider  
  Given I am a new user  
  When I open localhost:8080/, select "Lead a Circle", enter my email, bio, and password, and click Create Account  
  Then my account is saved with PROVIDER role and I am redirected to my dashboard at /providers/{id}

Scenario: Update provider profile  
  Given I am a verified provider  
  When I edit my profile information via the dashboard  
  Then the updated details are saved and visible

---

**US-PROV-002 — Create a Circle**

Story:  
As a provider, I want to create a Circle page with details about the group so that hobbyists can discover it.

Acceptance:

Scenario: Create Circle  
  Given my provider account is active  
  When I navigate to /providers/{id}/circle, fill in name, city, category, description, and click Save  
  Then the Circle is created in the circles table with my provider_id and appears in the hobbyist search results at /search

---

**US-PROV-003 — Schedule meetups**

Story:  
As a provider, I want to post meetup events with date and location so that members know when to gather.

Acceptance:

Scenario: Create meetup  
  Given I manage a Circle  
  When I navigate to /providers/{id}/events/new, enter title, location, date/time, and description, and save  
  Then the event is saved to the events table and appears in my events list at /providers/{id}/events

---

**US-PROV-004 — View member statistics**

Story:  
As a provider, I want to view participation statistics so that I can evaluate engagement.

Acceptance:

Scenario: View analytics  
  Given I access my provider dashboard  
  When I click View Statistics at /providers/{id}/statistics  
  Then I see member count, upcoming event count, and average review rating for my Circle

---

**US-PROV-005 — Reply to reviews**

Story:  
As a provider, I want to respond to reviews so that I can engage with members and address feedback.

Acceptance:

Scenario: Respond to review  
  Given a review exists for my Circle  
  When I navigate to /providers/{id}/reviews, type a reply, and submit  
  Then the reply is saved in the reply_text column and displayed publicly beneath the review

---

## 3. Non-Functional Requirements

| Category | Requirement |
|----------|-------------|
| Performance | 95% of pages load within 2 seconds under normal usage |
| Availability | ≥ 99% uptime during the semester demonstration period |
| Security | Role-based access enforced via Spring session attributes; password stored as-is for demo purposes |
| Usability | New users should be able to join a Circle within 3 minutes of first use |
| Compatibility | Tested on Chrome / Edge on Windows 11; Spring Boot 3.2.5, Java 17, Neon PostgreSQL |

---

## 4. Assumptions, Constraints, and Policies

- Users access the platform via modern web browsers (Chrome / Edge recommended)
- Reliable internet connection is required for Neon database connectivity
- Content must follow community guidelines
- Only users who have completed the join form may submit a review for a Circle
- Both the Provider and Hobbyist interfaces share a single PostgreSQL database (Neon)
- The merged demo app runs on port 8080; only one instance should run at a time

---

## 5. Milestones

| Milestone | Name | Status |
|-----------|------|--------|
| M2 | Requirements | Complete — SRS + stories opened as GitHub issues |
| M3 | High-Fidelity Prototype | Complete — core hobbyist/provider flows as interactive HTML prototypes |
| M4 | Design | Complete — architecture, schema, API outline |
| M5 | Backend API | Complete — REST endpoints implemented and tested |
| M6 | Increment | Complete — ≥ 2 use cases end-to-end with shared database |
| M7 | Final | Complete — integrated app with login/register, search, join, review, provider dashboard, events, statistics, replies |

---

## 6. Change Management

Stories are living artifacts tracked via repository issues and pull requests. Significant scope changes require team approval and SRS updates.

**Changes in v1.1 (Final):**

- Added login/register page (AuthMvcController + login.ftlh) integrating both roles into one app
- Hobbyist join flow updated to save registration records; review form wired to session user ID
- Database synchronized: provider_id FK made nullable in circles table; memberships table updated with status and timestamp columns
- Circle search extended with findByNameContainingIgnoreCase for name-based keyword search
- RSVP (US-CUST-004) noted as partially deferred — UI visible but full persistence not completed this semester
- Reqs Testing Plan added to docs/ folder with 19 test cases covering all use cases
- SysAdmin role removed from scope — not implemented this semester